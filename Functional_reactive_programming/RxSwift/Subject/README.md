# Subject

Notice below code:
```
let disposeBag = DisposeBag()

let subject = PublishSubject<String>()

subject.on(.next("This element will not print: Added before PublishSubject is subscribed"))

// PublishSubject is subscribed; //act as observer
subject.subscribe(onNext: { string in
print(string)
}).disposed(by: disposeBag)

//act as observable
subject.on(.next("First element: Could print"))

subject.on(.completed)

subject.on(.next("Second element: couldnt print because PublishSubject is completed."))
```

Subjects act as both an **observable** and an **observer**. You saw earlier how they can receive events and also be subscribed to.

In above example; The subject received `.next` events, and every time it receives an event, it turns around and emits it to its subscribers.

***There are four subject types in RxSwift***

* `PublishSubject`: Starts empty and only emits new elements to subscribers.
* `BehaviorSubject`: Starts with an initial value and replays it or the latest element to new subscribers.
* `ReplaySubject`: Initialized with a buffer size and will maintain a buffer of elements up to that size and replay it to new subscribers.
* `AsyncSubject`: Emits only the last `.next` event in the sequence, and only when the subject receives a `.completed` event.

> Two relay types that wrap subjects

* `PublishRelay` and `BehaviorRelay`: These wrap their relative subjects, but only accept `.next` events. You cannot add a `.completed` or `.error` event onto relays at all, so they're great for non-terminating sequences.

