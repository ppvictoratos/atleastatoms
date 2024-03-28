precedencegroup CompositionPrecedence {
  associativity: right
  higherThan: AssignmentPrecedence
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

infix operator >>> : CompositionPrecedence  // Map
infix operator >>= : CompositionPrecedence  // FlatMap
infix operator <*> : CompositionPrecedence  // Zip

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
func >>><A, B, C>(
    _ f: @escaping (A) -> B,
    _ g: @escaping (B) -> C
) -> (A) -> C {
    { a in g(f(a)) }
}

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

import Foundation
public typealias Executor = (@escaping () -> Void) -> Void
public extension OperationQueue {
    var executor: Executor { self.addOperation }
}
public extension RunLoop {
    var executor: Executor { self.schedule }
}
public extension DispatchQueue {
    var executor: Executor { { self.async(execute: $0) } }
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

let q1: OperationQueue = {
    let q = OperationQueue()
    q.name = "Q1"
    q.maxConcurrentOperationCount = 1
    return q
}()

let q2: OperationQueue = {
    let q = OperationQueue()
    q.name = "Q2"
    q.maxConcurrentOperationCount = 1
    return q
}()

let future = Future(14)
    .receive(on: q2.executor)
    .map { $0 * 10 }
    .receive(on: q1.executor)
    .map(String.init)
    .receive(on: OperationQueue.main.executor)
print(type(of: future))

future
    .sink { print(type(of: $0), $0.count, OperationQueue.current?.name ?? "None") }

import Combine
let pub = Combine.Just(14)
    .receive(on: q2)
    .map { $0 * 10 }
    .receive(on: q1)
    .map(String.init)
    .receive(on: OperationQueue.main)
    .eraseToAnyPublisher()
print(type(of: pub))

let cancellable = pub
    .sink { print(type(of: $0), $0.count, OperationQueue.current?.name ?? "None") }
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
    .receive(on: q2.executor)
    .map { $0 * 10 }
    .receive(on: q1.executor)
    .map(String.init)
    .receive(on: OperationQueue.main.executor)
    .sink {
        print(
            "Promise: ", $0.count, OperationQueue.current?.name ?? "None"
        )
    }

promise.future()
    .receive(on: q1.executor)
    .map { $0 * 100 }
    .receive(on: q1.executor)
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
