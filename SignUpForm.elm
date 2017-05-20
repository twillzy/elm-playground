module SignupForm exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (id, type_, for, class, value)


main =
    Html.program
        { init = ( { username = "", password = "", errors = initialErrors }, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


initialErrors =
    { username = "bad username", password = "bad password" }


update msg model =
    if msg.msgType == "VALIDATE" then
        ( { model | errors = getErrors model }, Cmd.none )
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
        , input [ id "username-field", type_ "text", value model.username ] []
        , div [ class "validation-error" ] [ text model.errors.password ]
        , label [ for "password" ] [ text "password: " ]
        , input [ id "password-field", type_ "password", value model.password ] []
        , div [ class "validation-error" ] [ text model.errors.password ]
        , div [ class "signup-button" ] [ text "Sign Up!" ]
        ]
