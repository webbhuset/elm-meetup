module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (href, style)


type alias BlogPost =
    { slug : String
    , heading : String
    , body : String
    }

main =
    notFoundView


notFoundView : Html msg
notFoundView =
    div
        []
        [ h1 [] [ text "404 Not Found" ]
        ]


initPosts : List BlogPost
initPosts =
    [ { slug = "hello"
      , heading = "Hello World!"
      , body = "Consectetur ipsa laboriosam repudiandae ratione laudantium. Veniam labore voluptate qui."
      }
    , { slug = "taking-shape"
      , heading = "The blog is taking shape..."
      , body = "Amet aspernatur amet inventore voluptatem nam. Ipsum aut ab dolorum."
      }
    , { slug = "flowing"
      , heading = "Words are flowing..."
      , body = "Adipisicing hic sit modi alias necessitatibus Deleniti distinctio dolorem quisquam maiores necessitatibus?"
      }
    , { slug = "going-viral"
      , heading = "Going viral"
      , body = "Elit nulla voluptas aut rerum a nobis! Aliquid fugiat dicta est fugit magni!"
      }
    ]

