# CollectionVia

A kinda hacky way to get `Collection` conformance for types that just want to forward all that stuff to an instance variable (or anything else you can get a keypath to, I suppose). It works by having the user define a static `collectionVia` keypath and then uses protocol extensions to fill everything in. I say it's "kinda hacky" because there are some shenannigans going on with type inference and the  `MutableCollectionVia` protocol, and they unfortunately throw warnings. See the TODO comments there for more info.

Speaking of TODOs, creating `(Array|Set|Dictionary)Via` protocols are all on the list, as well as `(Array|Set|Dictionary)Type` protocols (or whatever the current Swift naming convention is... I haven't looked it up yet) which replicate their respective interfaces. That way, for example, you could write generic code (`func foo<T: ArrayType>(array: T) {...}`) which will work both with honest `Array`s as well as types which conform to `ArrayVia`. 



There really ought to be behind some compiler/language feature that lets you present properties of a type's properties as belonging to the type itself, but we don't have that (yet?) and `*Collection` conformance is one of my most common reasons for wanting it.
