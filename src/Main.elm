module Main exposing (..)

import Browser
import Html exposing (Html, aside, div, h1, img, text)
import Html.Attributes exposing (class, src, style)



---- MODEL ----


type alias Model =
    { ship : Int }


init : ( Model, Cmd Msg )
init =
    ( { ship = 5 }, Cmd.none )



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
        [ aside []
            [ text (String.concat [ "Ship: ", String.fromInt model.ship, "x from Sun" ]) ]
        , h1 []
            [ text "Sun" ]
        , div [ class "space_dot" ]
            [ text "⋅" ]
        , div [ class "space_dot" ]
            [ text "⋅" ]
        , div [ class "space_dot" ]
            [ text "⋅" ]
        , div [ class "space_dot" ]
            [ text "⋅" ]
        , div [ class "space_dot" ]
            [ text "⋅" ]
        , div [ class "space_dot" ]
            [ text "⋅" ]
        , div
            [ class "ship floating"
            , style "top" (String.append (String.fromInt model.ship) "rem")
            ]
            [ img [ src "%PUBLIC_URL%/shuttle.png" ]
                []
            ]
        , div [ class "space_dot" ]
            [ text "⋅" ]
        , div [ class "space_dot" ]
            [ text "⋅" ]
        , div [ class "space_dot" ]
            [ text "⋅" ]
        , div [ class "space_dot" ]
            [ text "⋅" ]
        , div [ class "space_dot" ]
            [ text "⋅" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
