# Observable


`Observable` is just a sequence, with some special powers. One of these powers — in fact the most important one — is that it is **asynchronous**. 

Observables produce events, the process of which is referred to as **emitting**, over a period of time.

Events can contain values, such as numbers or instances of a custom type, or they can be recognized gestures, such as taps.

One of the best ways to conceptualize this is by using **marble diagrams**, which are just values plotted on a timeline.

<img src="./Files/marble_diagrams.png" height="50" width="350">

The left-to-right arrow represents time, and the numbered circles represent elements of a sequence. Element 1 will be emitted, some time will pass, and then 2 and 3 will be emitted. How much time, you ask? It could be at any point throughout the life of the observable.

***Lifecycle of an observable***

In above diagram, the observable emitted three elements. When an observable emits an element, it does so in what’s known as a **next** event.

<img src="./Files/completed.png" height="50" width="350">

In above diagram, This observable emits three tap events, and then it ends. This is called a **completed** event, as it’s been terminated. For example, perhaps the taps were on a view that had been dismissed. 

<img src="./Files/error.png" height="50" width="350">

However, sometimes things can go wrong. it’s represented by the red X. The observable emitted an **error** event containing the error.

This is no different than when an observable terminates normally with a completed event.

***Creating observables***

* using `just` operator.

`let observable = Observable<Int>.just(one)` Create an observable sequence of type Int using the `just` method with the **one** integer.

* using `of` operator

`let observable2 = Observable.of(one, two, three)` create `Observable<Int>` using the `of` method with the **three** integer.
  
`let observable3 = Observable.of([one, two, three])` create `Observable<[Int]>` i.e. array using the `of` method with the **one** integer array.
  
* using `from` operator

The from operator creates an observable of individual elements from an array of typed elements.
 
`let observable4 = Observable.from([one, two, three])` The from operator creates an observable of individual elements from an array of typed elements. create `Observable<Int>` using the `of` method with the **three** integer.


**Subscribing to observables**


User `subscribe` operator to add subscriber for observables.

An observable emits `.next`, `.error` and `.completed` events. A `.next` event passes the `element` being emitted to the handler, and an `.error` event contains an error instance.

> Definition of EVENT
>
```
public enum Event<Element> {
    /// Next element is produced.
    case next(Element)

    /// Sequence terminated with an error.
    case error(Swift.Error)

    /// Sequence completed successfully.
    case completed
}
```

Example: subscribe Observable

```
let observable = Observable.of(one, two, three)

observable.subscribe { event in
  let element = "\(event.element)"
  print("\(event) with element " + element)
}

Output:

next(1) with element Optional(1)
next(2) with element Optional(2)
next(3) with element Optional(3)
completed with element nil
```

Example: Subscribe observer but handle only next event
```
observable.subscribe(onNext: { element in
   print(element)
})

Output:
1
2
3
```

If you see both methods/subscribe opertors definition, subscribe returns a `Disposable`.

```
func subscribe(_ on: @escaping (Event<Int>) -> Void) -> Disposable
```

```
func subscribe(onNext: ((Int) -> Void)? = nil, onError: ((Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable
```

Remember that an observable doesn’t do anything until it receives a subscription. It’s the subscription that triggers an observable's work, which emits new events, up until it emits an `.error` or `.completed` event and is terminated. You can manually cause an observable to terminate by canceling a subscription to it. up to this point you’ve been working with observables that automatically emit a `.completed` event and naturally terminate.

***Disposing and terminating***

To explicitly cancel a subscription, call `dispose()` on it. After you cancel the subscription, or dispose of it, the observable in the current example will stop emitting events.


`subscription.dispose()`

Managing each subscription individually would be tedious, so RxSwift includes a `DisposeBag` type. A dispose bag holds disposables — typically added using the `.disposed(by:)` method — and will call `dispose()` on each one when the dispose bag is about to be deallocated. 

```
let disposeBag = DisposeBag()
  
Observable.of("A", "B", "C")
  .subscribe { 
    print($0)
  }
  .disposed(by: disposeBag)
```
This is the pattern you’ll use most frequently: creating and subscribing to an observable and immediately adding the subscription to a dispose bag.

> Why bother with disposables at all?

If you forget to add a subscription to a dispose bag, or manually call dispose on it when you’re done with the subscription, or in some other way cause the observable to terminate at some point, you will probably leak memory.

Example: Create custom Observable<String> with two element of event .next, disbpopse it using disposeBag. (No completd)

```
//create use to create custom observable i.e 1-->2-->
let observable = Observable<String>.create { observer in
    observer.on(.next("1"))
    observer.on(.next("2"))
    return Disposables.create()
}
        
let disposable = observable.subscribe(
    onNext: { print($0) },
    onError: { print($0) },
    onCompleted: { print("Completed") },
    onDisposed: { print("Disposed") }
)
        
disposable.disposed(by: disposeBag)

Output:
1
2
Disposed
```

Example: Create custom Observable<String> with three element of 2 events .next and one .completed , disbpopse it using disposeBag.

```
//create use to create custom observable i.e 1-->|-->2
let observable = Observable<String>.create { observer in
    observer.on(.next("1"))
    observer.on(.completed)
    observer.on(.next("2"))
    return Disposables.create()
}
        
let disposable = observable.subscribe(
    onNext: { print($0) },
    onError: { print($0) },
    onCompleted: { print("Completed") },
    onDisposed: { print("Disposed") }
)
        
disposable.disposed(by: disposeBag)

Output:
1
Completed ; // 2 will never print because we completed it before 2
Disposed
```
Example: Create custom Observable<String> with two element of 2 events .next, Do not disbpopse it.  **Memory leak**

```
let observable = Observable<String>.create { observer in
    observer.on(.next("1"))
    observer.on(.next("2"))
    return Disposables.create()
}
        
let disposable = observable.subscribe(
    onNext: { print($0) },
    onError: { print($0) },
    onCompleted: { print("Completed") },
    onDisposed: { print("Disposed") }
)

Output:
1
2
```

***Creating observable factories i.e. `deferred` operator***

it’s possible to create observable factories that vend a new observable to each subscriber. `deferred`'s observableFactory clouser parameter `() throws -> Observable<Int>` returns Observable. 

```
let disposeBag = DisposeBag()
var flag = true
let factory: Observable<Int> = Observable.deferred {
    // You can add logic and create Observable
    if flag {
        return Observable.of(1, 2, 3)
    } else {
        return Observable.of(10, 20, 30)
    }
}
        
factory.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

flag.toggle()
factory.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

flag.toggle()
factory.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)


Output: 
1
2
3
10
20
30
1
2
3
```

***Traits***

https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Traits.md

Traits are observables with a narrower set of behaviors than regular observables. (Their use is optional; you can use a regular observable anywhere you might use a trait instead.)

Their purpose is to provide a way to more clearly convey your intent to readers of your code or consumers of your API. The context implied by using a trait can help make your code more intuitive.

There are three kinds of traits in RxSwift: `Single`, `Maybe` and `Completable`.

**Singles** will emit either a `.success(value)` or `.error` event. 

`.success(value)` is actually a combination of the `.next` and `.completed` events.

This is useful for one-time processes that will either succeed and yield a value or fail, such as downloading data or loading it from disk.

<img src="./Files/Single.png" height="100" width="400">

A **Completable** will only emit a `.completed` or `.error` event. It doesn't emit any values.

You could use a completable when you only care that an operation completed successfully or failed, such as a file write.

Finally, **Maybe** is a mashup of a Single and Completable.

It can either emit a `.success(value)`, `.completed` or `.error`. 

If you need to implement an operation that could either succeed or fail, and optionally return a value on success, then use Maybe.

Example with Regular Observerable
```
Observable<String>.create({ observer in
    let disposable = Disposables.create()
    guard let path = Bundle.main.path(forResource: name, ofType: "strings") else {
        observer.on(.error(FileReadError.fileNotFound))
        return disposable
    }
            
    guard let data = FileManager.default.contents(atPath: path) else {
        observer.on(.error(FileReadError.unreadable))
        return disposable
    }
    
    guard let contents = String(data: data, encoding: .utf8) else {
        observer.on(.error(FileReadError.encodingFailed))
        return disposable
    }
    observer.on(.next(contents))
    return disposable   
}).subscribe{
    switch $0 {
    case .next(let string):
        print(string)
    case .error(let error):
        print(error)
    }
}.disposed(by: disposeBag)
```

Example with Single Traits

```
Single.create(subscribe: { single in
    let disposable = Disposables.create()
    guard let path = Bundle.main.path(forResource: name, ofType: "strings") else {
        single(.error(FileReadError.fileNotFound))
        return disposable
    }

    guard let data = FileManager.default.contents(atPath: path) else {
        single(.error(FileReadError.unreadable))
        return disposable
    }

    guard let contents = String(data: data, encoding: .utf8) else {
        single(.error(FileReadError.encodingFailed))
        return disposable
    }
    single(.success(contents))
    return disposable
}).subscribe{
    switch $0 {
    case .success(let string):
        print(string)
    case .error(let error):
        print(error)
    }
}.disposed(by: disposeBag)
```

***Do Operator***

Register an action to take upon a variety of Observable lifecycle events.

You can provide handlers for any or all of these events, Useful to perform side effects.

```
do`(onNext: ((Int) throws -> Void)? = nil, afterNext: ((Int) throws -> Void)? = nil, onError: ((Error) throws -> Void)? = nil, afterError: ((Error) throws -> Void)? = nil, onCompleted: (() throws -> Void)? = nil, afterCompleted: (() throws -> Void)? = nil, onSubscribe: (() -> Void)? = nil, onSubscribed: (() -> Void)? = nil, onDispose: (() -> Void)? = nil) -> Observable<Int>
```
