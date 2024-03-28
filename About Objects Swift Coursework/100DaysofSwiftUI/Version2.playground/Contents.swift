
precedencegroup CompositionPrecedence {
  associativity: right
  higherThan: AssignmentPrecedence
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

infix operator >>> : CompositionPrecedence  // Map
infix operator >>= : CompositionPrecedence  // FlatMap
infix operator <*> : CompositionPrecedence  // Zip

func >>><A, B, C>(
    _ f: @escaping (A) -> B,
    _ g: @escaping (B) -> C
) -> (A) -> C {
    { a in g(f(a)) }
}

struct Just<A> { // Also can be called Future in Pointfree
    let sink: (@escaping (A) -> Void) -> Void
    init(_ sink: @escaping (@escaping (A) -> Void) -> Void) {
        self.sink = sink
    }
    init(_ a: A) {
        self = Just<A> { callback in callback(a) }
    }
    func map<B>(_ transform: @escaping (A) -> B) -> Just<B> {
        .init { sink(transform >>> $0) }
    }
}

Just(14)
    .map { $0 * 10 }
    .map(String.init)
    .sink { print(type(of: $0), $0.count) }
type(of: Just(14))

import Combine

Combine.Just(14)
    .map { $0 * 10 }
    .map(String.init)
    .sink { print(type(of: $0), $0.count) }
type(of: Combine.Just(14))

let subject = PassthroughSubject<Int, Never>()

let cancellable = subject
    .map { $0 * 10 }
    .map(String.init)
    .sink { print(type(of: $0), $0.count) }

subject.send(14)
subject.send(27)
subject.send(158)

/*:
 __________________________________________________
 */
func doubler(_ anInt: Int) -> Int { anInt * 2 }
doubler(14)

let counter = doubler >>> String.init >>> \.count
counter(50)

func curry<A, B, C>(
    _ f: @escaping (A, B) -> C
) -> (A) -> (B) -> C {
    { a in { b in f(a, b) } }
//    { (a: A) -> (B) -> C in
//        { (b: B) -> C in
//            f(a, b)
//        }
//    }
}

// (A) -> B
func >>><A, B>(
    _ f: @escaping (A) -> B,
    _ g: @escaping (B) -> Void
) -> (A) -> Void {
    { a in g(f(a)) }
//    { (a: A) -> Void in
//        let b: B = f(a)
//        g(b)
//    }
}

// The previous function only curried
public func liftToVoid<A, B>(
    _ f: @escaping (A) -> B
) -> (@escaping (B) -> Void) -> (A) -> Void {
    { g in { a in g(f(a)) } }
//    { (g: @escaping (B) -> Void) -> (A) -> Void in
//        { (a: A) -> Void in
//            let b: B = f(a)
//            g(b)
//        }
//    }
}

// Composition with the return value of the previous function
public func >>><A, B, C> (
    _ me: @escaping (@escaping (A) -> Void) -> (B) -> Void,
    _ f: @escaping (A) -> C
) -> (@escaping (C) -> Void) -> (B) -> Void {
    { me(f >>> $0) }
//    { (callback: @escaping (C) -> Void) -> (B) -> Void in
//        { (b: B) in
//            let a2Void = { (a: A) -> Void in callback(f(a)) }
//            me(a2Void)
//        }
//    }
}

// Flatmap over the same form as the previous function
func >>=<A, B, C, D>(
    _ me: @escaping (@escaping (A) -> B) -> (C) -> B,
    _ f: @escaping (A) -> (@escaping (D) -> B) -> (C) -> B
) -> (@escaping (D) -> B) -> (C) -> B {
    { callback in { c in me { a in f(a)(callback)(c) }(c) } }
//        { (callback: @escaping (D) -> B) in
//            { (c: C) in
//                let a2c2b: (A) -> (C) -> B = { (a: A) in f(a)(callback) }
//                let a2b: (A) -> B = { (a: A) in  a2c2b(a)(c) }
//                let c2b: (C) -> B = me(a2b)
//                let b: B = c2b(c)
//                return b
//            }
//        }
}

// Moving the Void form of the previous function to a different execution context
func await<A, B>(
    _ me: (@escaping (@escaping (A) -> Void) -> (B) -> Void),
    on executor: @escaping (@escaping () -> Void) -> Void
) -> (@escaping (A) -> Void) -> (B) -> Void  {
    { aToVoid in me({ a in executor({ aToVoid(a) }) }) }
//    { (aToVoid: @escaping (A) -> Void) in
//        { (b: B) -> Void in
//            let a2Executor: (A) -> Void = { a in
//                let voidToVoid: () -> Void = { aToVoid(a) }
//                executor(voidToVoid)
//            }
//            me(a2Executor)
//        }
//    }
}

typealias Executor = (@escaping () -> Void) -> Void // Future<Void>

let immediate: Executor = { f in f() }

import Foundation
public extension OperationQueue {
    var executor: (@escaping () -> Void) -> Void { self.addOperation }
}
let q1: Executor = {
    let q = OperationQueue()
    q.name = "Q1"
    q.maxConcurrentOperationCount = 1
    return q.executor
}()
let q2: Executor = {
    let q = OperationQueue()
    q.name = "Q2"
    q.maxConcurrentOperationCount = 1
    return q.executor
}()
let q3: Executor = {
    let q = OperationQueue()
    q.name = "Q3"
    q.maxConcurrentOperationCount = 1
    return q.executor
}()

let lifted  = liftToVoid(counter)
type(of: lifted)

func doubleToString(_ aDouble: Double) -> String {
    String(aDouble)
}

let transport1 = lifted >>> Double.init
let transport2 = transport1 >>> doubleToString

type(of: transport2)

func printString(_ aString: String) -> Void {
    print(aString)
}

let composition = transport2(printString)
type(of: composition)

composition(158)
composition(1)
composition(10)
composition(100)
composition(1_000)
composition(10_000)
composition(100_000)
composition(1_000_000)

let queueHopper1 = await(lifted, on: q1)
let queueHopper2 = await(queueHopper1 >>> Double.init, on: q2)
let queueHopper3 = await(queueHopper2 >>> doubleToString, on: q3)

let send = queueHopper3 { value in
    print("Receieved(\(value)) on: \(OperationQueue.current?.name ?? "No name queue")")
}
type(of: send)

send(1)
send(10)
send(100)
send(1_000)
send(10_000)
send(100_000)

func compactURL(input: URL?) -> (@escaping (URL) -> Void) -> (String) -> Void {
    { delivery in
        { original in
            guard let input = input else { return }
            delivery(input)
        }
    }
}

public func identity<T>(_ t: T) -> T { t }

let stringToString: (String) -> String = identity
type(of: stringToString)

let converter = liftToVoid(stringToString) >>> URL.init(string:)
type(of: converter)

let compacted = converter >>= compactURL
type(of: compacted)

func fetch(url: URL) -> String {
    ((try? String(contentsOf: url)) ?? "").trimmingCharacters(in: .newlines)
}
let producer = compacted >>> fetch
type(of: producer)

let fetcher = producer(printString)

let randomNumberLocation = "https://www.random.org/integers/?num=1&min=1&max=235866&col=1&base=10&format=plain&rnd=new"

fetcher(randomNumberLocation)
fetcher(randomNumberLocation)
fetcher(randomNumberLocation)
fetcher(randomNumberLocation)
fetcher(randomNumberLocation)
fetcher(randomNumberLocation)

public extension RunLoop {
    internal var executor: Executor { self.schedule }
}
public extension DispatchQueue {
    internal var executor: Executor { { self.async(execute: $0) } }
}

public struct Future<A> { // Also can be called Future in Pointfree
    let sink: (@escaping (A) -> Void) -> Void
    init(_ sink: @escaping (@escaping (A) -> Void) -> Void) {
        self.sink = sink
    }
    init(_ a: A) {
        self = Future<A> { callback in callback(a) }
    }
    func callAsFunction(_ f: @escaping (A) -> Void) {
        sink(f)
    }
    func map<B>(_ f: @escaping (A) -> B) -> Future<B> {
        .init { downstream in self { a in
            downstream(f(a))
        } }
    }
    func flatMap<B>(_ f: @escaping (A) -> Future<B>) -> Future<B> {
        .init { downstream in self { a in
            f(a)(downstream)
        } }
    }
    func receive(on executor: @escaping Executor) -> Self {
        .init { downstream in self { a in
            executor { downstream(a) }
        } }
    }
    func subscribe(on executor: @escaping Executor) -> Self {
        .init { downstream in executor {
            self { a in downstream(a) }
        } }
    }
}

let z1: OperationQueue = {
    let q = OperationQueue()
    q.name = "Q1"
    q.maxConcurrentOperationCount = 1
    return q
}()

let z2: OperationQueue = {
    let q = OperationQueue()
    q.name = "Q2"
    q.maxConcurrentOperationCount = 1
    return q
}()

let future = Future(14)
    .receive(on: z2.executor)
    .map { $0 * 10 }
    .receive(on: z1.executor)
    .map(String.init)
    .receive(on: OperationQueue.main.executor)
print(type(of: future))

future
    .sink { print(type(of: $0), $0.count, OperationQueue.current?.name ?? "None") }

import Combine
let pub = Combine.Just(14)
    .receive(on: z2)
    .map { $0 * 10 }
    .receive(on: z1)
    .map(String.init)
    .receive(on: OperationQueue.main)
    .eraseToAnyPublisher()
print(type(of: pub))

//let cancellable = pub
//    .sink { print(type(of: $0), $0.count, OperationQueue.current?.name ?? "None") }
type(of: Future(14))

public enum PromiseError: Error {
    case alreadyUsed
}

public final class Promise<A> {
    private var value: A? = .none
    private var futures: [(A) -> Void] = []
    public func future() -> Future<A> {
        Future<A> { callback in
            guard let value = self.value else {
                self.futures.append(callback)
                return
            }
            callback(value)
        }
    }
    public func resolve(with a: A) throws {
        guard value == nil else { throw PromiseError.alreadyUsed }
        value = a
        futures.forEach { callback in callback(a) }
        futures = []
    }
}

let promise = Promise<Int>()

promise.future()
    .receive(on: z2.executor)
    .map { $0 * 10 }
    .receive(on: z1.executor)
    .map(String.init)
    .receive(on: OperationQueue.main.executor)
    .sink {
        print(
            "Promise: ", $0.count, OperationQueue.current?.name ?? "None"
        )
    }

promise.future()
    .receive(on: z1.executor)
    .map { $0 * 100 }
    .receive(on: z1.executor)
    .map(String.init)
    .receive(on: OperationQueue.main.executor)
    .sink {
        print(
            "Promise: ", $0.count, OperationQueue.current?.name ?? "None"
        )
    }

do {
    try promise.resolve(with: 10)
} catch {
    print(error)
}
