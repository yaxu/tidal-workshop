'''This does not describe current behaviour - this is upcoming in version 1.0.0.'''

A core feature of Tidal is the ease in which two patterns can be combined. This is changing a lot in the upcoming 1.0.0 version of Tidal. For example, these are two patterns being combined by adding together their elements:

<syntaxhighlight lang = "Haskell">
"2 3" + "4 5 6"
</syntaxhighlight>

The following table shows how these two patterns line up over time:

<pre>
  |  2  |  3  |
+ | 4 | 5 | 6 |
</pre>

Unlike in previous versions of Tidal, by default the structure now comes from _both sides_. This means you end up with _four_ events, because the 5 lines up both with the <syntaxhighlight lang="Haskell" inline>2</syntaxhighlight> and the <syntaxhighlight lang="Haskell" inline>3</syntaxhighlight>. So the result is equivalent to <syntaxhighlight lang="Haskell" inline>"6 [7 8] 9"</syntaxhighlight>:

<pre>
  |  2  |  3  |
+ | 4 | 5 | 6 |
= | 6 |7|8| 9 |
</pre>

You can see that the event with the value of <syntaxhighlight lang="Haskell" inline>4</syntaxhighlight> fits in the event
with value of <syntaxhighlight lang="Haskell" inline>2</syntaxhighlight>, so you get a new event equalling their sum <syntaxhighlight lang="Haskell" inline>6</syntaxhighlight>. You
can see that the onset and duration is the interection, which in this
case is just the onset and duration of the original event with the
value <syntaxhighlight lang="Haskell" inline>4</syntaxhighlight>.

Also see that the event with value <syntaxhighlight lang="Haskell" inline>5</syntaxhighlight> is cut in half, to create two,
shorter events. Half matches with the <syntaxhighlight lang="Haskell" inline>2</syntaxhighlight> event and the other half
matches with the <syntaxhighlight lang="Haskell" inline>3</syntaxhighlight> event. Again, the onset and duration of both
events comes from the intersections.

The fourth and final event comes from the intersection of <syntaxhighlight lang="Haskell" inline>3</syntaxhighlight> and <syntaxhighlight lang="Haskell" inline>6</syntaxhighlight>,
giving a value of <syntaxhighlight lang="Haskell" inline>9</syntaxhighlight>.

## Structure from the left

The old behaviour was to take the structure from the left. You can
still do this, but in this case using <syntaxhighlight lang="Haskell" inline>|+`. 

For example:

<syntaxhighlight lang="Haskell">
"2 3" |+ "4 5 6"
</syntaxhighlight>

In the above example, you end up with structure from the first, leftmost pattern, like this:


<pre>
   |  2  |  3  |
|+ | 4 | 5 | 6 |
 = |  6  |  8  |
</pre>

You can see the structure comes from the <syntaxhighlight lang="Haskell" inline>2</syntaxhighlight> and <syntaxhighlight lang="Haskell" inline>3</syntaxhighlight>. <syntaxhighlight lang="Haskell" inline>2</syntaxhighlight> lines up
with <syntaxhighlight lang="Haskell" inline>4</syntaxhighlight>, and the start of <syntaxhighlight lang="Haskell" inline>3</syntaxhighlight> is in <syntaxhighlight lang="Haskell" inline>5</syntaxhighlight>, so you end up with <syntaxhighlight lang="Haskell" inline>2+4=6</syntaxhighlight>
and <syntaxhighlight lang="Haskell" inline>3+5=8</syntaxhighlight>.

## Structure from the right

Likewise, you can take the structure from the right, with <syntaxhighlight lang="Haskell" inline>+|</syntaxhighlight>. So <syntaxhighlight lang="Haskell" inline>"2
3" +| "4 5 6"</syntaxhighlight> looks like:

<pre>
   |  2  |  3  |
+| | 4 | 5 | 6 |
 = | 6 | 7 | 9 |
</pre>

## All the operators

Note that <syntaxhighlight lang="Haskell" inline>+</syntaxhighlight> is actually an alias for <syntaxhighlight lang="Haskell" inline>|+|</syntaxhighlight>. So <syntaxhighlight lang="Haskell" inline>|+</syntaxhighlight> is to take the
structure from the left, <syntaxhighlight lang="Haskell" inline>+|</syntaxhighlight> from the right, and <syntaxhighlight lang="Haskell" inline>|+|</syntaxhighlight> or <syntaxhighlight lang="Haskell" inline>+</syntaxhighlight> for
both. Here are all the basic operators you can use to combine
structure:

Function     Both      Left  Right 
--------     --------- ----- ------
Add          <syntaxhighlight lang="Haskell" inline>|+|</syntaxhighlight>/</syntaxhighlight>+</syntaxhighlight> <syntaxhighlight lang="Haskell" inline>|+</syntaxhighlight>  <syntaxhighlight lang="Haskell" inline>+|</syntaxhighlight>
Multiply     <syntaxhighlight lang="Haskell" inline>|*|</syntaxhighlight>/</syntaxhighlight>*</syntaxhighlight> <syntaxhighlight lang="Haskell" inline>|*</syntaxhighlight>  <syntaxhighlight lang="Haskell" inline>*|</syntaxhighlight>
Subtract     <syntaxhighlight lang="Haskell" inline>|-|</syntaxhighlight>/</syntaxhighlight>-</syntaxhighlight> <syntaxhighlight lang="Haskell" inline>|-</syntaxhighlight>  <syntaxhighlight lang="Haskell" inline>-|</syntaxhighlight>
Divide       <syntaxhighlight lang="Haskell" inline>|/|</syntaxhighlight>/</syntaxhighlight>/</syntaxhighlight> <syntaxhighlight lang="Haskell" inline>|/</syntaxhighlight>  <syntaxhighlight lang="Haskell" inline>/|</syntaxhighlight>
Modulo       <syntaxhighlight lang="Haskell" inline>|%|</syntaxhighlight>     <syntaxhighlight lang="Haskell" inline>|%</syntaxhighlight>  <syntaxhighlight lang="Haskell" inline>%|</syntaxhighlight>
Left values  <syntaxhighlight lang="Haskell" inline>|<|</syntaxhighlight>     <syntaxhighlight lang="Haskell" inline>|<</syntaxhighlight>  <syntaxhighlight lang="Haskell" inline><|</syntaxhighlight>
Right values <syntaxhighlight lang="Haskell" inline>|>|</syntaxhighlight>/</syntaxhighlight>#</syntaxhighlight>  <syntaxhighlight lang="Haskell" inline>|></syntaxhighlight>  <syntaxhighlight lang="Haskell" inline>>|</syntaxhighlight>

The last two are interesting, they let you only take values from one
side. So for example you could take structure from the left, but
values from the right with <syntaxhighlight lang="Haskell" inline>|></syntaxhighlight>, for example:

<pre>
   |  2  |  3  |
|> | 4 | 5 | 6 |
 = |  2  |  9  |
</pre>

This is actually how <syntaxhighlight lang="Haskell" inline>#</syntaxhighlight> works in the current tidal.
