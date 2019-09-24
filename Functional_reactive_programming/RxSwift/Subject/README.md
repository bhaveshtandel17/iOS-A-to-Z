# Subject

Notice below code:
```
let disposeBag = DisposeBag()

let subject = PublishSubject<String>()

subject.on(.next("This element will not print: Added before PublishSubject is subscribed"))

// PublishSubject is subscribed
subject.subscribe(onNext: { string in
print(string)
}).disposed(by: disposeBag)


subject.on(.next("First element: Could print"))

subject.on(.completed)

subject.on(.next("Second element: couldnt print because PublishSubject is completed."))
```

