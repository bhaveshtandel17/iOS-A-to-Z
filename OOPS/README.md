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

Properties of the class are kept private(acces modifier) and public getter and setter methods or public computed property are provided to manipulate these properties.

***Abstraction***

Abstraction is hiding the information or providing only necessary details to outside world.

Swift Doesn’t support abstract classes. There is workaround Abstract Class Pattern using fatalError in base class method and overridden same method in subclass.

> Downside: Missing implemented isn’t detected at compile time.

Good alternative is **protocol**. In Any type class, struct and enum can conform to protocol. Protocol can have required and optional methods. If we don’t implement protocol required method in class, struct or enum, compiler throws an error at compile time.

***Inheritance***

objects of one class can derive part of their behavior and properties from another (base or parent) class.

> Swift allows only single inheritance. But workaround for this limitation is Protocol and Protocol extension.

***Method overloading***

Method overloading is the process by which a class has two or more methods with *same name* but *different parameters* or different return type.

***Operator overloading***

Ability of a certain language-dependant operator to behave differently based on the type of its operands (for instance, + could mean concatenation with Strings and addition with numeric operands).

> Example in swift: Adding two ints vs adding two strings.

***Method Overriding***

Overriding is the process by which two methods have the same method name and parameters. One of the methods is in the parent class and the other is in the child class. Thus child class is modifying/replacing the behavior the superclass provides.

***Polymorphism***

Polymorphism can be achieved through **overriding**. Polymorphism refers to the ability of an object to provide different behaviors (use different implementations) depending on its own nature.

```
class BaseClass {
    func print() {
        print("from base class")
    }
}

class ChildClass {
    override func print() {
        print("from child class")
    }
}

let object1: BaseClass = BaseClass()
object1.print()

let object2: BaseClass = ChildClass()
object1.print() // Polymorphism ;
//provide different behaviors depending on its own nature (Instance type is childClass.)
```
