module Main exposing (..)

import Browser
import Html exposing (Html, aside, div, h1, h6, img, text)
import Html.Attributes exposing (class, src, style)



---- MODEL ----


type alias Model =
    { ship : Int }


init : ( Model, Cmd Msg )
init =
    ( { ship = 15 }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "main" ]
        ([ aside []
            [ text (String.concat [ "Ship: ", String.fromInt model.ship, "x from Sun" ]) ]
         , h1 []
            [ text "Sun" ]
         , shipView model
         ]
            ++ dots 10
            ++ [ planetView "Mercury" model]
            ++ dots 9
            ++ [ planetView "Venus" model]
            ++ dots 7
            ++ [ planetView "Earth" model]
            ++ dots 14
            ++ [ planetView "Mars" model]
            ++ dots 95
            ++ [ planetView "Jupiter" model]
            ++ dots 112
            ++ [ planetView "Saturn" model]
            ++ dots 249
            ++ [ planetView "Uranus" model]
            ++ dots 281
            ++ [ planetView "Neptune" model]
            ++ dots 242
            ++ [ planetView "Pluto" model]
        )


dots : Int -> List (Html Msg)
dots count =
    List.repeat count
        (div [ class "space_dot" ]
            [ text "⋅" ]
        )


shipView : Model -> Html Msg
shipView model =
    div
        [ class "ship floating"
        , style "top" (String.append (String.fromInt model.ship) "rem")
        ]
        [ img [ src "%PUBLIC_URL%/shuttle.png" ]
            []
        ]


planetView : String -> Model -> Html Msg
planetView planet model =
    h6 [] [ text planet ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
