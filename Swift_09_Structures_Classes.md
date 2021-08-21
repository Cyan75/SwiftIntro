# Structures and Classes
> * a general-purpose building blocks
> * no separation of interface and implementation files
>   * external interfaces to classes or structures are automatically made available for other code to use
> * in general, 
>   * an object is an instance of a class
>   * in Swift, structures are often used as much as classes
>   * use more general terminology : *instance*


## 1.Comparing Structures and Classes
> most of the custom data types will be structures and enumerations
* Things in common
  * Define properties to store values
  * Define methods to provide functionality
  * Define subscripts to provide access to their values using subscript syntax
  * Define initializers to set up their initial state
  * Be extended to expand their functionality beyond a default implementation
  * Conform to protocols to provide standard functionality of a certain kind

* Exclusive additional capabilities of classes
  * Inheritance enables one class to inherit the characteristics of another.
  * Type casting enables you to check and interpret the type of a class instance at runtime.
  * Deinitializers enable an instance of a class to free up any resources it has assigned.
  * Reference counting allows more than one reference to a class instance.
