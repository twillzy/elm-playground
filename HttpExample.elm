module HttpExample exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Http exposing (..)
import Json.Decode as Decode


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { topic : String
    , gifUrl : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "Cat" "waiting.gif", getRandomGif "Cat" )


type Msg
    = MorePlease
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( model, getRandomGif model.topic )

        NewGif (Ok newUrl) ->
            ( { model | gifUrl = newUrl }, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.topic ]
        , img [ src model.gifUrl ] []
        , button [ onClick MorePlease ] [ text "More Please!" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- key idea is (1) create an HTTP request and (2) turn it into a command so Elm will actually do it


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic

        request =
            Http.get url decodeGifUrl
    in
        Http.send NewGif request


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string
