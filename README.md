# CollectionVia

A way to get `Sequence`, `Collection`, `BidirectionalCollection`, `RandomAccessCollection`, `RangeReplaceableCollection`, or `MutableCollection` conformance for types where just want to forward all that stuff to an instance variable (or anything else you can get a keypath to, I suppose). It works by having the user define a static `collectionVia` keypath and then uses protocol extensions to fill everything in.

In the Standard Library, a lot of these protocols refine others (`Collection` refines `Sequence`, `MutableCollection` refines `Collection`, etc). I haven't figured out a way to make this work with the type inference system... something to do with `KeyPath` vs `WritableKeyPath` for `MutableCollectionVia`, I think, but I'm not sure yet.

On the TODO list is creating `(Array|Set|Dictionary)Via` protocols, as well as `(Array|Set|Dictionary)Type` protocols (or whatever the current Swift naming convention is... I haven't looked it up in a while) which replicate their respective interfaces. That way, for example, you could write generic code (`func foo<T: ArrayType>(array: T) {...}`) which will work both with an honest `Array` as well as a type which conforms to `ArrayVia`.



Hopefully there'll eventually be a compiler/language feature that lets you present properties of a type's properties as belonging to the type itself, but we don't have that (yet?) and `*Collection` conformance is one of my most common reasons for wanting it.
