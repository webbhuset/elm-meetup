module FunctionComposition exposing (main)

import Html exposing (Html)
import Json.Encode as Json



{-| For printing a list of integers in a more readable format.
-}
stringify : List Int -> String
stringify =
    Json.list Json.int
        >> Json.encode 0 


main : Html msg
main =
    let
        {- This is the list of integers we will use in all examples. 0-9 -}
        numbers = List.range 0 9
    in
    Html.div
        [
        ]
        ( List.map
            ( Html.text
                >> List.singleton
                >> Html.div []
            )
            [ "Input:"
            , stringify numbers
            , "Output:"
            , "0: " ++ stringify (example0 numbers)
            , "1: " ++ stringify (example1 numbers)
            , "2: " ++ stringify (example2 numbers)
            , "3: " ++ stringify (example3 numbers)
            , "4: " ++ stringify (example4 numbers)
            , "5: " ++ stringify (example5 numbers)
            , "6: " ++ stringify (example6 numbers)
            ]
        )


{-| Iterate over a list of numbers do a simple mathematical operation.
    
    In javascript, it would be something like this:
    
    numbers.map(function(n) {
        return (n + 1) * 2 - 1;
    });

    or using arrow functions:
    
    numbers.map(n => (n + 1) * 2 - 1);
-}
example0 : List Int -> List Int
example0 numbers =
    List.map (\n -> (n + 1) * 2 - 1) numbers


{-| Forward function application with lambdas.

    numbers.map(n => n + 1)
           .map(n => n * 2)
           .map(n => n - 1);

-}
example1 : List Int -> List Int
example1 numbers =
    numbers
        |> List.map (\n -> n + 1)
        |> List.map (\n -> n * 2)
        |> List.map (\n -> n - 1)


{-| Forward function composition with lambdas

-}
example2 : List Int -> List Int
example2 =
    List.map (\n -> n + 1)
        >> List.map (\n -> n * 2)
        >> List.map (\n -> n - 1)
    
    
{-| Forward function composition with named functions
using partial application (currying)

    numbers.map(addTo.bind(null, 1))
           .map(multiplyBy.bind(null, 2))
           .map(addTo.bind(null, -1));

    numbers.map(n => addTo(1, n))
           .map(n => multiplyBy(2, n))
           .map(n => addTo(-1, n));
        
-}
example3 : List Int -> List Int
example3 =
    List.map (addTo 1)
        >> List.map (multiplyBy 2)
        >> List.map (addTo -1)
        
        

{-| Forward function composition of inner functions

Instead of iterating three times and performing one operation,
we can iterate one time and compose the three oprations.

-}
example4 : List Int -> List Int
example4 =
    List.map
        ( addTo 1
            >> multiplyBy 2
            >> addTo -1
        )
       {- You can also use function application instead of composition:
        
            (\n ->
                n
                |> addTo 1
                |> multiplyBy 2
                |> addTo -1
            )
      -}
        
        
{-| Backwards function composition of inner functions

This resembles the order functions would be composed in imperative languages.


    numbers.map(n => addTo(-1, multiplyBy(2, addTo(1, n))));

-}
example5 : List Int -> List Int
example5 =
    List.map
        ( addTo -1 << multiplyBy 2 << addTo 1 )
        
        -- (\n -> addTo -1 <| multiplyBy 2 <| addTo 1 n)
    
    
{-| Using infix functions.

An infix function (operator) can be converted to a 
prefix function (how it normally works) by wrapping it in parenthesis.
-}
example6 : List Int -> List Int
example6 =
    List.map
        ( (+) 1
            >> (*) 2
            >> (+) -1
        )

addTo : Int -> Int -> Int
addTo n1 n2 =
    n1 + n2
    
    
multiplyBy : Int -> Int -> Int
multiplyBy n1 n2 =
    n1 * n2
