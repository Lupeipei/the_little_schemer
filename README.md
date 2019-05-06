code snippets of the book《the little schemer》4th edition.

this README is inspired by Peter Krumins's [the little schemer](<https://github.com/pkrumins/the-little-schemer>).

### Contents
=====================================================================================

* [chapter 01. Toys](#chapter-01-toys)
* [chapter 02. Do it, do it again, and again, and again](#chapter-02-do-it-do-it-again-and-again-and-again)
* [chapter 03. Cons the magnificent](#chapter-03-cons-the-magnificent)
* [chapter 04. Numbers Games](#chapter-04-numbers-games)
* [chapter 05. Oh My Gawd, It's full of Stars](#chapter-05-oh-my-gawd-it-s-full-of-stars)
* [chapter 06. Shadows](#chapter-06-shadows)
* [chapter 07. Friends and Relations](#chapter-07-friends-and-relations)
* [chapter 08. Lambda the Ultimate](#chapter-08-lambda-the-ultimate)
* [chapter 09. And Again, and Again, and Again](#chapter-09-and-again-and-again-and-again)
* [chapter 10. What Is the Value of All of This?](#chapter-10-what-is-the-value-of-all-of-this)


=====================================================================================

### chapter 01. Toys

Introduce the basic concepts in scheme: atom, list and some primitive functions, such as car, cdr, cons, null?, eq? and ect.

notes: All lists and all atoms are S-expressions.

Below are  the five rules that we should follow when using those primitives:

**the law of car**

> The primitive car is defined only for non-empty lists.



**the law of cdr**

> The primitive cdr is defined only for non-empty lists.
> the cdr of any non-empty list is always another list.



**the law of cons**

> The primitive cons takes two arguments. The second argument to cons must
> be a list. The result is a list.



**the law of null?**

> The primitive null? is defined only for lists.



**the law of eq?**

> The primitive eq? takes two arguments. Each must be a non-numeric atom.



=====================================================================================

### chapter 02. Do it do it again and again and again

With the implements and explanations of lat? and member? functions, we meet recursion. that's why this chapter is titled "do it, do it again, and again, and again". well, as you can guess,  we'll meet recursion frequently in the later chapters😄.

Also, we get the preliminary version of the first commandment in this chapter.

**the first commandment[preliminary]**

> always ask null? as the first question in expressing any function.



=====================================================================================

### chapter 03. Cons the magnificent

Of course, as it is titled, we embrace cons in this chapter!😄

First, define function rember? to remove a member in a list, and we get the second commandment.

**the second commandment**

> use cons to build lists.

Then, define function firsts to build another list. and here, the third commandment.

**the third commandment**

> when building a list, describe the first typical element, and then cons it into the natural recursion.

Then, with the definitions of insertR, insertL, subst and multiinsertR, multiinsertL, multisubst, we get the preliminary version of the four commandment.

**the fourth commandment[preliminary]**

> always change at least one argument while recurring. it  must be changed to be closer to termination. The changing argument must be tested in the termination condition: when using cdr, test termination with null?


=====================================================================================

### chapter 04. Numbers Games

This chapter is about numbers and primitive functions , such as add1, sub1, zero?, +, - etc.

when recurring on a number, we ask`( zero? n)`.

so, we can optimize the first commandment.

**the first commandment[first revision]**

> when recurring on a list of atom, lat, ask two questions about it:
>  (null? lat) and else.
> when recurring on a number n, ask two questions about it:
>  (zero? n) and else.

After the definition of  addtup function, we can also optimize the fourth commandment.

**the fourth commandment[first revision]**

> always change at least one argument while recurring. it must be changed to
>
> be closer to termination. The changing argument must be tested in the   
>
> termination condition:
>
> when using cdr, test termination with null?
>
> when using sub1, test termination with zero?

And, define + and x functions, here goes the fifth commandment.

**the fifth commandment**

> when building a value with +, always use 0 for the value of the terminating line, for adding 0 does not change the value of an addition.
>
> when building a value with x, always use 1 for the value of the terminating line, for multiplying by 1 does not change the value of a multiplicaition.
>
> when building a value with cons, always conside () for the value of the value of the terminating line.

Beside, operators like >, <, =, /, expt, length and pick also have been defined in this chapter.

=====================================================================================

### chapter 05. Oh My Gawd It's full of Stars

Yes, this chapter is full of ✨✨✨.

Redefine the functions we have defined in chapter2 and chapter 3 but with stars, such as rember\*, insertR\*, insertL\*, occur\*, substantially\*, member\* and we get the  final version of the first commandment and the four commandment:

**the first commandment[final revision]**

> when recurring on a list of atom, lat, ask two questions about it:        
>
> (null? lat) and else.                                                     
>
> when recurring on a number n, ask two questions about it:                 
>
> (zero? n) and else.                                                       
>
> when recurring on a list of S-expressions, ask three questions about it:
> (null? l), (atom? (car l)) and else.



**the fourth commandment[final revision]**

> always change at least one argument while recurring.
> when recurring on a list of atoms, lat, use (cdr lat).
>
> when recurring on  a number, use (sub1 n).
>
> and when recurring on a list of S-expressions, use (car l) and (cdr l) if neither (null? l) nor (atom? (car l)) are true.
> It must be changing closer to termination.
>
> The changing argument must be  tested in the termination condition:
> when using cdr, test termination with null?
> when using sub1, test termination with zero?

and, also with the definition of eqlist? , equal?, the six commandment is stated:

**the six commandment**

> simplify only after the function is correct.

=====================================================================================

### chapter 06. Shadows

Introduce the arithmetic expression.

with the functions of value and numbered?, we can get the result of an arithmetic expression.

Also, the seventh commandment is presented:

**the seventh commandment**

> Recur on the subparts that are of the same nature:
> - On the sublists of a list
> - On the subexpressions of an arithmetic expression

after refactoring the value function, we get the eight commandment.

**the eight commandment**

> use help functions to abstract from representations.

in the later part of this chapter, a different type of list is introduced. Using list to represent number, for example,  (()) stands for 1,  (() ()) stands for 2,   (() () ()) stands for 3 and etc . Beware of shadow  when apply the function lat? to these list.

=====================================================================================

### chapter 07. Friends and Relations

Introduce the concepts of set and pair, also define some helper functions for each.

For set,  functions like eqset?, intersect?, intersect?, intersectall are defined.

For pair,  a-pair?, fun?, revrel, revpair and fullfun?  are defined.

Yep, have fun!

=====================================================================================

### chapter 08. Lambda the Ultimate

First, define member-f to show that a function can also return a function.

This kind of functions are called [currying](<https://en.wikipedia.org/wiki/Currying>).

with this power of abstraction, the functions that we have defined in previous chapters like rember, insertR, insertL can be redefined  with only one function.

Then, the nine commandment is stated:

**the nine commandment**

> abstract common patterns with a new function.

later, using collector in the definition of multimember&co function. collector is a special concept, it is sometimes called a "continuation", you'll meet it again in 《the seasoned schemer》chapter 19.

Final,  the ten commandment.

**the ten commandment**

> build functions to collect more than one value at a time.

some more examples of collector are presented. you can also practice it for fun.

=====================================================================================

### chapter 09. And Again and Again and Again

This chapter is the most difficult part in this book, it is about the derivation of the Y-combinator.

I have written an article in Chinese, showing the complete derivation process. Hope it is useful.

[derivation of Y combinator in scheme](<https://luciaca.cn/2019/04/13/deriving-the-Y-combinator-in-scheme/>)

=====================================================================================

### chapter 10. What Is the Value of All of This

this chapter complete  a preliminary version of scheme compiler,  parse scheme in scheme.

in 《the seasoned schemer》 chapter 20, you will get the final version.

OK, time for 🍰!
