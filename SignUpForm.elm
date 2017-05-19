module SignUpForm exposing (..)

import Html.App
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (id, type, class, value)


view model =
    form [ id "signup-form" ]
        [ h1 [] [ text "Sensational Signup Form" ]
        , label [ for "username-field" ] [ text "username: " ]
        , input [ id "username-field", type "text", value model.username ] []
        , label [ for "password" ] [ text "password: " ]
        , input [ id "password-field", type "password", value model.password ]
        , div [ class "signup-button" ] [ text "Sign Up!" ]
        ]
