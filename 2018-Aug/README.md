# Meetup 21 of August 2018

## Agenda

- Our experinces of switching to Elm
- Group assignments:
    * Introduction to FP and Elm
    * Building UI with Style Elements
    * Solve "Walk The Grid"

## Resources

Useful Elm resources:

- [elm-lang/core package reference](https://package.elm-lang.org/packages/elm-lang/core/5.1.1)
- [elm-lang/html package reference](https://package.elm-lang.org/packages/elm-lang/html/2.0.0/Html)
- [Elm official guide](https://guide.elm-lang.org/)
- [Examples on elm-lang.org](http://elm-lang.org/examples)


## Group Assignments

### Introduction to FP and Elm

* Syntax and Pure Functions.
* Function composition and function application. [See examples](FunctionComposition.elm) [Try on Ellie](https://ellie-app.com/37YtJ4XC6bGa1)


### Building UI with Style Elements

Please style this ugly app: [Ellie code](https://ellie-app.com/38smFP3B7KKa1)

Simple examples of Style Element to play around with: [Ellie code](https://ellie-app.com/38svHdHJC7wa1)

[Style Elements documentation on elm-package.org](https://package.elm-lang.org/packages/mdgriffith/stylish-elephants/latest-)


### Solve "Walk The Grid"

#### Problem description

You are on a two dimensional grid with two axis, **x** and **y**, where
x and y are integers.

```
           (+y)
            ^
            |
            |
 (-x) <-----+-----> (+x)
            |
            |
            v
           (-y)
```

References to locations on the grid are done using a 2-dimensional vecor, `(x, y)`.
The center point has value `(0, 0)`. This is also your starting
location.

From any location in the grid you can move in four directions:
up, down, left or right.

You are given a list of instructions on which direction to move.
Each instruction moves you exactly one square in the
corresponding direction. These instructions are encoded as a string
of ascii characters, where each character corresponds to one
instruction:

* `^` move up (north) (y +1)
* `v` move down (south) (y -1)
* `>` move right (east) (x +1)
* `<` move left (west) (x -1)

Some example instructions:

* `>>>>` You will move right 4 times, starting at `(0, 0)` you will end up at `(4, 0)`.
* `^^>>vv<<` You will walk around in a 2x2 square, ending up where you started `(0, 0)`.
* `<<vv` You will walk left 2 and then down 2, ending up at `(-2, -2)`.

You have to implement the following two functions that would answear
these questions:

1. What is the final location after all instructions
   are processed?
2. Which is the first location you will visit twice?

Assume that any valid string could be given as input.

#### Code

Solve on [ellie-app.com](https://ellie-app.com/38sG6Bfx7wYa1) and optimize for one of
the following:

- Fastest execution
- Fewest lines of code (most clever)
- Most readable / understandable
- Most reusable / modular

