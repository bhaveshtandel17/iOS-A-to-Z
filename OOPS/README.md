# OOPS

***Object-oriented programming (OOP)*** is a programming paradigm that represents the concept of `objects` that have data `fields` (attributes that describe the object) and associated procedures known as `methods`. 

Objects (instances of classes) are used to interact with one another to design applications and computer programs.

***What is classes and Objects?***

Class is an extensible program-code-template for creating objects, providing initial values for state (member variables) and implementations of behavior (member functions, methods).

> In other words,

A class is like a blueprint, it defines the data and behavior of a type.

```
//Class
class Button {
}

//Object
var button = Button()
```
In the example above button is an instance of the Button class.

***Properties***

Classes and instances can have associated values named properties.
```
class Square {
    var length: Int = 1
}
```
> Above is example of stored property. 

***Methods***

Methods add behaviour to classes and instances.
```
class Square {
  var length: Int = 1

  //method
  func area() -> Int {
    return length * length
  }
}
```

***Encapsulation***

Encapsulation restricts direct access(for other object) to data and exposes functions to operate on that data. By restricting access to data we prevent unexpected changes.

Properties of the class are kept private and public getter and setter methods are provided to manipulate these properties.


