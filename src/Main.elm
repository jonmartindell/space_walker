port module Main exposing (..)

import Browser
import Html exposing (Html, aside, div, h1, h6, img, text)
import Html.Attributes exposing (class, src, style)



---- MODEL ----


type alias Model =
    { ship : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { ship = 0 }, Cmd.none )



---- PORTS -----


port incomingGeoData : (Int -> msg) -> Sub msg



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions _ =
    incomingGeoData NewGeoData



---- UPDATE ----


type Msg
    = NoOp
    | NewGeoData Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        NewGeoData int ->
            ( { model | ship = int }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "main" ]
        ([ aside []
            [ text (String.concat [ "Ship: ", String.fromInt model.ship, "y from Sun" ]) ]
         , h1 []
            [ text <| "Sun" ]
         , shipView model
         ]
            ++ dots 10
            ++ [ planetView "Mercury" model ]
            ++ dots 9
            ++ [ planetView "Venus" model ]
            ++ dots 7
            ++ [ planetView "Earth" model ]
            ++ dots 14
            ++ [ planetView "Mars" model ]
            ++ dots 95
            ++ [ planetView "Jupiter" model ]
            ++ dots 112
            ++ [ planetView "Saturn" model ]
            ++ dots 249
            ++ [ planetView "Uranus" model ]
            ++ dots 281
            ++ [ planetView "Neptune" model ]
            ++ dots 242
            ++ [ planetView "Pluto" model ]
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
        , subscriptions = subscriptions
        }
