
enum MyOptional<A> {
    case some(A)
    case none
}

enum MyResult<Value, Failure: Error> {
    case success(Value)
    case failure(Failure)
}


public struct Future<A> {
    let sink: (@escaping (Result<A, Error>) -> Void) -> Void
    init(_ sink: @escaping (@escaping (Result<A, Error>) -> Void) -> Void) {
        self.sink = sink
    }
}

public extension Future {
    init(_ a: A) {
        self = Future<A> { callback in callback(.success(a)) }
    }
    init(_ error: Error) {
        self = Future<A> { callback in callback(.failure(error)) }
    }
    func callAsFunction(_ f: @escaping (Result<A, Error>) -> Void) {
        sink(f)
    }
}

public extension Future {
    func map<B>(_ f: @escaping (A) -> B) -> Future<B> {
        .init { downstream in self { r in
            switch r {
                case .success(let a):
                    downstream(.success(f(a)))
                case .failure(let e):
                    downstream(.failure(e))
            }
        } }
    }
    func mapError(_ f: @escaping (Error) -> Error) -> Future<A> {
        .init { downstream in self { r in
            switch r {
                case .success(let a):
                    downstream(.success(a))
                case .failure(let e):
                    downstream(.failure(f(e)))
            }
        } }
    }
    func flatMap<B>(_ f: @escaping (A) -> Future<B>) -> Future<B> {
        .init { downstream in self { r in
            switch r {
                case .success(let a):
                    f(a)(downstream)
                case .failure(let e):
                    downstream(.failure(e))
            }
        } }
    }
}

import Dispatch
func zip<A, B>(
    _ fa: Future<A>,
    _ fb: Future<B>
) -> Future<(A, B)> {
    .init { callback in
        var lock = os_unfair_lock_s()
        var optionalA: A?, optionalB: B?, hasFailed = false
        fa.sink { r in
            os_unfair_lock_lock(&lock)
            switch r {
                case let .success(a):
                    optionalA = a
                    guard let b = optionalB else { os_unfair_lock_unlock(&lock); return }
                    os_unfair_lock_unlock(&lock)
                    callback(.success((a, b)))
                case let .failure(error):
                    guard !hasFailed else { os_unfair_lock_unlock(&lock); return }
                    hasFailed = true
                    os_unfair_lock_unlock(&lock)
                    callback(.failure(error))
            }
        }
        fb.sink { r in
            os_unfair_lock_lock(&lock)
            switch r {
                case let .success(b):
                    optionalB = b
                    guard let a = optionalA else { os_unfair_lock_unlock(&lock); return }
                    os_unfair_lock_unlock(&lock)
                    callback(.success((a, b)))
                case let .failure(error):
                    guard !hasFailed else { os_unfair_lock_unlock(&lock); return }
                    hasFailed = true
                    os_unfair_lock_unlock(&lock)
                    callback(.failure(error))
            }
        }
    }
}

public enum PromiseError: Error {
    case alreadyUsed
    case released
}

public final class Promise<A> {
    private var lock = os_unfair_lock_s()
    private var value: Result<A, Error>? = .none
    private var futures: [(Result<A, Error>) -> Void] = []

    deinit {
        os_unfair_lock_lock(&lock)
        value = .failure(PromiseError.released)
        precondition(
            futures.count == 0,
            "Leaking promise.  \(futures.count) futures unresolved."
        )
        os_unfair_lock_unlock(&lock)
    }

    func future() -> Future<A> {
        Future<A> { callback in
            os_unfair_lock_lock(&self.lock)
            guard let value = self.value else {
                self.futures.append(callback)
                os_unfair_lock_unlock(&self.lock)
                return
            }
            os_unfair_lock_unlock(&self.lock)
            callback(value)
        }
    }
    func resolve(with r: Result<A, Error>) throws {
        os_unfair_lock_lock(&self.lock)
        guard value == nil else {
            os_unfair_lock_unlock(&self.lock)
            throw PromiseError.alreadyUsed
        }
        value = r
        let futuresCopy = futures
        futures = []
        os_unfair_lock_unlock(&self.lock)
        futuresCopy.forEach { callback in callback(r) }
    }
    func callAsFunction(_ a: Result<A, Error>) throws {
        try resolve(with: a)
    }
    func callAsFunction(_ a: A) throws {
        try resolve(with: .success(a))
    }
    func callAsFunction(_ error: Error) throws {
        try resolve(with: .failure(error))
    }
}

import Foundation
func stringSink(_ result: Result<String, Error>) {
    let queue = OperationQueue.current?.name ?? "Unknown queue"
    switch result {
        case .success(let value):
            print("🎉 \(value.trimmingCharacters(in: .whitespacesAndNewlines)) on: \"\(queue)\"")
        case .failure(let error):
            print("🐞 😢 \(error) on: \"\(queue)\"")
    }
}

let future = Future<Int>(14)
    .map { $0 * 10 }
    .map(String.init)
type(of: future)

future(stringSink)
future(stringSink)

var promise: Promise<Int>? = Promise<Int>()

promise?.future().map { $0 * 10 }.map(String.init).sink(stringSink)
promise?.future().map { $0 * 100 }.map(String.init).sink(stringSink)

enum SomeError: Error {
    case myError
}

//do {
//    try promise(14)
//    try promise(15)
//} catch {
//    print(error)
//}

try? promise?(14)

func randomNumberURLString(min: Int = 0, max: Int = 1_000_000) -> URL {
    URL(string: "https://www.random.org/integers/?num=1&min=\(min)&max=\(max)&col=1&base=10&format=plain&rnd=new")!
}

enum FutureError: Error, CustomStringConvertible {
    case invalidURLString(String)
    case emptyURLResponse
    case invalidURLResponse(URLResponse)
    case invalidHTTPURLResponse(Int)
    case noData

    var description: String {
        switch self {
            case .invalidURLString(let badString):
                return "Error: FutureError.invalidURLString(\(badString))"
            case .emptyURLResponse:
                return "Error: Empty URLResponse"
            case .invalidURLResponse(let urlResponse):
                return "Error: Response not appropriate - \(urlResponse)"
            case .invalidHTTPURLResponse(let code):
                return "Error: Invalid URL Response: \(code)"
            case .noData:
                return "Error: No data returned from URL"
        }
    }
}

class Fetcher: NSObject, URLSessionDelegate {
    static var session: URLSession {
        return URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: Fetcher(),
            delegateQueue: nil
        )
    }

    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        NSLog("\(#function): Session received authentication challenge")
        completionHandler(.performDefaultHandling, nil)
    }
}

func fetch(url: URL) -> Future<Data> {
    let promise = Promise<Data>()
    Fetcher.session
        .dataTask(with: url) { (data: Data?, response: URLResponse?, netError: Error?) in
        guard netError == nil else {
            try? promise(netError!)
            return
        }
        guard let response = response else {
            try? promise(FutureError.emptyURLResponse)
            return
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            try? promise(FutureError.invalidURLResponse(response))
            return
        }
        guard httpResponse.statusCode / 100 == 2 else {
            try? promise(FutureError.invalidHTTPURLResponse(httpResponse.statusCode))
            return
        }
        guard let data = data else {
            try? promise(FutureError.noData)
            return
        }
        try? promise(data)
    }
    .resume()
    return promise.future()
}

extension Future {
    func tryMap<B>(_ f: @escaping (A) throws -> B) -> Future<B> {
        .init { downstream in self { r in
            switch r {
                case .success(let a):
                    do { try downstream(.success(f(a))) }
                    catch { downstream(.failure(error)) }
                case .failure(let e):
                    downstream(.failure(e))
            }
        } }
    }
    func replaceError(_ f: @escaping (Error) -> A) -> Future<A> {
        .init { downstream in self { r in
            switch r {
                case .success(let a):
                    downstream(.success(a))
                case .failure(let e):
                    downstream(.success(f(e)))
            }
        } }
    }
    func tryFlatMap<B>(_ f: @escaping (A) throws -> Future<B>) -> Future<B> {
        .init { downstream in self { r in
            switch r {
                case .success(let a):
                    do { try f(a)(downstream) }
                    catch { downstream(.failure(error)) }
                case .failure(let e):
                    downstream(.failure(e))
            }
        } }
    }
}

extension Future {
    func log(_ f: @escaping (A) -> String) -> Self {
        .init { downstream in self { r in
            switch r {
                case .success(let a):
                    print(f(a))
                    downstream(.success(a))
                case .failure(let e):
                    downstream(.failure(e))
            }
        } }
    }
    func logError(_ f: @escaping (Error) -> String) -> Self {
        .init { downstream in self { r in
            switch r {
                case .success(let a):
                    downstream(.success(a))
                case .failure(let e):
                    print(f(e))
                    downstream(.failure(e))
            }
        } }
    }
    func logResult(_ f: @escaping (Result<A, Error>) -> String) -> Self {
        .init { downstream in self { r in
            print(f(r))
            downstream(r)
        } }
    }
}


let promise2 = Promise<Int>()

let selectionFuture = promise2.future()
    .tryMap { randomNumberURLString(min: 0, max: $0) }
    .flatMap(fetch)
    .logError { err in "Got an error: \(err)"}
    .map { String.init(data: $0, encoding: .utf8) ?? "0" }
    .map { Int.init($0.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0 }
type(of: selectionFuture)

selectionFuture.map(String.init).sink(stringSink)

let promise3 = Promise<URL>()

let characterset = CharacterSet(
    charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
)

enum FetchError: Error {
    case noString
    case stringTooSmall
    case testError
}

let wordsFuture = promise3.future()
    .flatMap(fetch)
    .log { _ in "Got words"}
    .tryMap { (data: Data) throws -> ArraySlice<Substring> in
        guard let dataString = String.init(data: data, encoding: .utf8) else {
            throw FetchError.noString
        }
        let stringArray = dataString.split(separator: " ")
            .filter { $0.rangeOfCharacter(from: characterset.inverted) == nil }
        guard stringArray.count >= 3000 else {
            throw FetchError.stringTooSmall
        }
        return stringArray[0 ..< 3_000]
    }
type(of: wordsFuture)

zip(selectionFuture, wordsFuture)
    .log{ _, _  in "Got Pair" }
    .map { selection, words in "words[\(selection)] = \"\(words[selection])\"" }
    .sink(stringSink)

try? promise2(3_000)
try? promise3(URL(string: "https://www.pointfree.co")!)
