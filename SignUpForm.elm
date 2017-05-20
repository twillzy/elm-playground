module SignupForm exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (id, type_, for, class, value)
import Http
import Task exposing (Task)
import Json.Decode exposing (succeed)


initialModel =
    { username = "", password = "", errors = initialErrors }


initialErrors =
    { username = "", password = "", usernameTaken = False }


main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


update msg model =
    if msg.msgType == "VALIDATE" then
        let
            url =
                "https://api.github.com/users/" ++ model.username

            handleResponse result =
                case result of
                    Ok _ ->
                        { msgType = "USERNAME_TAKEN", payload = "" }

                    Err _ ->
                        { msgType = "USERNAME_AVAILABLE", payload = "" }

            request =
                Http.get url (succeed "")

            cmd =
                Http.send handleResponse request
        in
            ( { model | errors = getErrors model }, cmd )
    else if msg.msgType == "SET_USERNAME" then
        ( { model | username = msg.payload }, Cmd.none )
    else if msg.msgType == "SET_PASSWORD" then
        ( { model | password = msg.payload }, Cmd.none )
    else if msg.msgType == "USERNAME_TAKEN" then
        ( withUsernameTaken True model, Cmd.none )
    else if msg.msgType == "USERNAME_AVAILABLE" then
        ( withUsernameTaken False model, Cmd.none )
    else
        ( model, Cmd.none )


withUsernameTaken isTaken model =
    let
        currentErrors =
            model.errors

        newErrors =
            { currentErrors | usernameTaken = isTaken }
    in
        { model | errors = newErrors }


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
    , usernameTaken = model.errors.usernameTaken
    }


viewUsernameErrors model =
    if model.errors.usernameTaken then
        "That username is taken!"
    else
        model.errors.username


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
        , div [ class "validation-error" ] [ text (viewUsernameErrors model) ]
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
