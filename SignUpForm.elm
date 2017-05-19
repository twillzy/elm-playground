module SignUpForm exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (id, type_, for, class, value)


view model =
    form [ id "signup-form" ]
        [ h1 [] [ text "Sensational Signup Form" ]
        , label [ for "username-field" ] [ text "username: " ]
        , input [ id "username-field", type_ "text", value model.username ] []
        , label [ for "password" ] [ text "password: " ]
        , input [ id "password-field", type_ "password", value model.password ] []
        , div [ class "signup-button" ] [ text "Sign Up!" ]
        ]
