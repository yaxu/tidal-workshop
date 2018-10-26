
# Introduction

TidalCycles is a language for the exploration of pattern.

What is a pattern? How can we explore them as code? In this workshop
we will explore some advanced topics, to try to understand what that
means. I'm not sure myself, but lets try.

## Tidal 1.0.0-pre

I have been making a new version of TidalCycles for these workshops,
so we can try something new. It's version 1.0-pre, which is not
officially released, but works and has some exciting new features. You
can install it with this command in a terminal window:

```
cabal install http://slab.org/tokyo/tidal-1.0.0-pre.tar.gz
```


If you want to uninstall it again you can run this command:

```
ghc-pkg unregister tidal-1.0.0
```

... then your old version will start running again (once you restart your text editor).

# Workshop topics

We have spare time. Please ask questions throughout, and I'm happy to cover something extra.

* Interaction
* Structure
* Tempo patterns
* Arpeggios
* External control

* Extra topics, if we have time
  * Randomisation
  * Composing functions
  * Collaboration
  * Feedforward editor


# Structure

## Structure from both sides

In old Tidal, when combining two patterns, "structure always comes
from the left". In the new tidal, you can choose where the structure comes from.

For example:
```
"2 3" + "4 5 6"
```

These two patterns line up like this:

```
|  2  |  3  |
| 4 | 5 | 6 |
```

Now by default, the structure comes from _both sides_, so you end up with _four_
events. I've shown the four events below:

```
  |  2  |  3  |
+ | 4 | 5 | 6 |
= | 6 |7|8| 9 |
```

You can see that the event with the value of `4` fits in the event
with value of `2`, so you get a new event equalling their sum `6`. You
can see that the onset and duration is the interection, which in this
case is just the onset and duration of the original event with the
value `4`.

Also see that the event with value `5` is cut in half, to create two,
shorter events. Half matches with the `2` event and the other half
matches with the `3` event. Again, the onset and duration of both
events comes from the intersections.

The fourth and final event comes from the intersection of `3` and `6`,
giving a value of `9`.

## Structure from the left

The old behaviour was to take the structure from the left. You can
still do this, but in this case using `|+`. For example:

```
   |  2  |  3  |
|+ | 4 | 5 | 6 |
 = |  6  |  8  |
```

You can see the structure comes from the `2` and `3`. `2` lines up
with `4`, and the start of `3` is in `5`, so you end up with `2+4=6`
and `3+5=8`.

## Structure from the right

Likewise, you can take the structure from the right, with `+|`:

```
   |  2  |  3  |
+| | 4 | 5 | 6 |
 = | 6 | 7 | 9 |
```

## All the operators

Note that `+` is actually an alias for `|+|`. So `|+` is to take the
structure from the left, `+|` from the right, and `|+|` (or `+`) for
both. Here are all the basic operators you can use to combine
structure:

Function     Both      Left  Right 
--------     --------- ----- ------
Add          `|+|`/`+` `|+`  `+|`
Multiply     `|*|`/`*` `|*`  `*|`
Subtract     `|-|`/`-` `|-`  `-|`
Divide       `|/|`/`/` `|/`  `/|`
Modulo       `|%|`     `|%`  `%|`
Left values  `|<|`     `|<`  `<|`
Right values `|>|`     `|>`  `>|`

