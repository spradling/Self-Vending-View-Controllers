# Self-Vending View Controllers
Tired of constantly looking up storyboard identifiers? Overwhelmed by string-literal-induced anxiety every time you try to add a new subview? Fret no more!
<br><br>
Now with Self-Vending View Controller, simply ask a view or view controller for its respective instance from a single property, and it will do the rest.
---
The Self-Vending View Controller protocol is a system aimed at centrally organizing xibs, storyboards, and identifiers, and pre-configuring UIView and UIViewController classes to define their own InterfaceBuilder location.
<br><br>
The system operates at three levels, and assumes a project made of multiple and a shared library that all other modules can reference (It can also be used in a single-module project, but you won't get the write-once-and-forget benefits of dropping the protocol definition in a shared location)

## Shared: The Backbone
At the lowest level, this system provides a protocol that ties view controllers to the notion of a IB location (either xib or storyboard). It also provides most of the heavy-lifting functionality of converting a view controller's identifiers into an instantiated screen.
<br><br>
This is also where we define protocols for the *idea* of an enumerated set of storyboard/xib names-- and if we have shared screens, we can go ahead and define those here too.
## Module: Making it concrete
With the shared framework in place, a given module need only create a couple of barebones protocols-- ones that flesh out the associatedType requirements of the shared protocol with the module's own Storyboard Enum and/or Nib Enum.
<br><br>
The module is also responsible for creating these enums, which on the one hand are expected to encompass the names of every board and nib in the module... but on the other hand, this will be the LAST time you'll have to write those names by hand again!

## View Controller: Easy Breezy Implementation
With all that structure in place, each view controller or view (or, in the future, cell!) you create needs to define only one property to conform to its respective protocol and become a fully automatic self-vending view controller:

`class var viewSource: Source? { return .storyboard(.nameOfStoryboard) }`

That's it!

Now you can call your viewController with `.viewController` and you'll get a fully instantiated screen from the correct screen, every time.
