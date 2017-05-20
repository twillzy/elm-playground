module SignupForm exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (id, type_, for, class, value)
import Http


initialModel =
    { username = "", password = "", errors = initialErrors }


initialErrors =
    { username = "", password = "" }


main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


update msg model =
    if msg.msgType == "VALIDATE" then
        ( { model | errors = getErrors model }, Cmd.none )
    else if msg.msgType == "SET_USERNAME" then
        ( { model | username = msg.payload }, Cmd.none )
    else if msg.msgType == "SET_PASSWORD" then
        ( { model | password = msg.payload }, Cmd.none )
    else
        ( model, Cmd.none )


getErrors model =
    { username =
        if model.username == "" then
            "Plase enter a username!"
        else
            ""
    , password =
        if model.password == "" then
            "Please enter a password!"
        else
            ""
    }


view model =
    form [ id "signup-form" ]
        [ h1 [] [ text "Sensational Signup Form" ]
        , label [ for "username-field" ] [ text "username: " ]
        , input
            [ id "username-field"
            , type_ "text"
            , value model.username
            , onInput (\str -> { msgType = "SET_USERNAME", payload = str })
            ]
            []
        , div [ class "validation-error" ] [ text model.errors.username ]
        , label [ for "password" ] [ text "password: " ]
        , input
            [ id "password-field"
            , type_ "password"
            , value model.password
            , onInput (\str -> { msgType = "SET_PASSWORD", payload = str })
            ]
            []
        , div [ class "validation-error" ] [ text model.errors.password ]
        , div [ class "signup-button", onClick { msgType = "VALIDATE", payload = "" } ] [ text "Sign Up!" ]
        ]
