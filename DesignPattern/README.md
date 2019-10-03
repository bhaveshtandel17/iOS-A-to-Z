# Design Pattern


***There are three main types of design patterns:***

> 1. Structural design pattern:

Describes how objects are composed and combined to form larger structures. Examples of structural design patterns include Model-View-Controller (MVC), Model-View-ViewModel (MVVM) and Facade.

> 2. Behavioral design pattern: 

Describes how objects communicate with each other. Examples of behavioral design patterns are Delegation, Strategy and Observer.

> 3. Creational design pattern:

Describes how to create or instantiate objects. Examples of creational patterns are Builder, Singleton and Prototype.

`NOTE: There’s an ongoing debate on whether some patterns, including MVVM and MVC, are actually architectural patterns, which span an entire app or subsystem architecture.`


### Model-View-Controller Pattern (Structural)

The model-view-controller (MVC) pattern separates objects into three distinct types. **models, views and controllers!**

<img src="./Files/mvc.png"/>

* **Models** hold application data. They are usually structs or simple classes.
* **Views** display visual elements and controls on screen. They are usually subclasses of `UIView`. (Custom view and view or controls from UIKIT)
* **Controllers** coordinate between models and views. They are usually subclasses of `UIViewController`.

> MVC is very common in iOS programming, because it's the design pattern that Apple chose to adopt in `UIKit`.

Controllers are allowed to have **strong properties** for their model and view so they can be accessed directly. Controllers may have more than one model and/or view.

Conversely, models and views should **not hold a strong reference** to their owning controller. This would cause a retain cycle.

Instead, models communicate to their controller via property observing, and views communicate to their controller via `IBActions`.

This lets you reuse models and views between several controllers. But Controllers are much harder to reuse.

***When should you use it?***

Use this pattern as a starting point for creating iOS apps.

In nearly every app, you’ll likely need additional patterns besides MVC, but it’s okay to introduce more patterns as your app requires them.

***What should you be careful about?***

MVC is a good starting point, but it has limitations. Not every object will neatly fit into the category of model, view or controller. Consequently, applications that only use MVC tend to have a lot of logic in the controllers. This can result in view controllers getting very big! There's a rather quaint term for when this happens, called "**Massive View
Controller.**"

To solve this issue, You should use other patterns as needed along with MVC.

