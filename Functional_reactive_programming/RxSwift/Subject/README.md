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

***Working with publish subjects***

Publish subjects come in handy when you simply want subscribers to be notified of new events from the point at which they subscribed, until they either unsubscribe, or the subject has terminated with a .completed or .error event.

```
let disposeBag = DisposeBag()
        
let subject = PublishSubject<String>()
        
//PublishSubject is not subscribed yet.
subject.on(.next("Is anyone listening?: No"))
        
// Added 1st subscriber
let subscriptionOne = subject.subscribe({ event in
    print("subscription 1)", event.element ?? event)
})
        
//Print 1 : subscription 1) 1
//PublishSubject is subscribed with "subscriptionOne".
subject.on(.next("1"))
        
// Added 2nd subscriber
let subscriptionTwo = subject.subscribe({ event in
    print("subscription 2)", event.element ?? event)
})
        
//Print 2 : subscription 1) 2
//Print 3 : subscription 2) 2
//PublishSubject is subscribed with "subscriptionOne" and "subscriptionTwo".
subject.onNext("2")
        
//subscriptionOne dispose
subscriptionOne.dispose()
        
//Print 4 : subscription 2) 3
//PublishSubject is subscribed with "subscriptionTwo".
subject.onNext("3")
        
//Print 5 : subscription 2) completed
//PublishSubject is subscribed with "subscriptionTwo".
subject.onCompleted()
        
//subject is already completed; this event is useless
subject.onNext("4")
        
//subscriptionOne dispose
subscriptionTwo.dispose()
        
//Print 6 : subscription 3) completed
//subject is already completed. So print completed only
//PublishSubject is subscribed with "subscription three".
subject.subscribe {
    print("subscription 3)", $0.element ?? $0)
}.disposed(by: disposeBag)

//subject is already completed; this event is useless
subject.onNext("?")


Output:
subscription 1) 1
subscription 1) 2
subscription 2) 2
subscription 2) 3
subscription 2) completed
subscription 3) completed
```


