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
