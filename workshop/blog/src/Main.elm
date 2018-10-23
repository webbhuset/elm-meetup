module Main exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Nav
import Url exposing (Url)
import Html exposing (Html, a, div, text, h1, h2)
import Html.Attributes exposing (href, style)


type Msg
  = UrlRequested UrlRequest
  | UrlChanged Url


type alias Model =
    { navKey : Nav.Key
    , page : Page
    , posts : List BlogPost
    }


type Page
    = PostListing
    | PostView BlogPost
    | NotFound


type alias BlogPost =
    { slug : String
    , heading : String
    , body : String
    }


type alias Flags =
     ()


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
   ( { navKey = key
     , page = PostListing
     , posts = initPosts
     }
   , Cmd.none
   )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequested req ->
            case req of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.navKey (Url.toString url) )
                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | page = getPage (fragmentToPath url.fragment) model }, Cmd.none )


fragmentToPath : Maybe String -> List String
fragmentToPath frag =
    case frag of
        Just str ->
            String.split "/" str

        Nothing ->
            []


getPage : List String -> Model -> Page
getPage path model =
    case path of
        [ "blog" ] ->
            PostListing

        [ "blog", slug ] ->
            List.filter (\post -> post.slug == slug) model.posts
                |> List.head
                |> Maybe.map PostView
                |> Maybe.withDefault NotFound

        _ ->
            NotFound


renderPage : Model -> Html Msg
renderPage model =
    case model.page of
        PostListing ->
            listView model.posts

        PostView post ->
            postView post

        NotFound ->
            notFoundView


view : Model -> Document Msg
view model =
    { title = "The Blog"
    , body =
        [ a [ href "#blog" ] [ text " Home " ]
        , renderPage model
        ]
    }


notFoundView : Html Msg
notFoundView =
    div
        []
        [ h1 [] [ text "404 Not Found" ]
        ]


listView : List BlogPost -> Html Msg
listView posts =
    let
        renderPost post =
            div
                []
                [ a [ href ("#blog/" ++ post.slug) ] [ text post.heading ]
                ]
    in
        div [ style "margin" "2rem" ] (List.map renderPost posts)


postView : BlogPost -> Html Msg
postView post =
    div
        []
        [ h1 [] [ text post.heading ]
        , Html.p [] [ text post.body ] 
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

