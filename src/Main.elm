module Main exposing (..)

import Browser
import Css exposing (..)
import Html

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)

main = Browser.element
         { init = init 
         , update = update
         , view = view
         , subscriptions = subscriptions
         }


-- MODEL

type alias Model =
  { username     : String
  , password     : String
  , rememberPass : Bool 
  }


init : () -> (Model, Cmd Msg)
init _ = 
  ( { accounts = 
      [ { id = 1, name = "John", age = 42 }
      , { id = 2, name = "Jake", age = 43 }
      , { id = 3, name = "Jack", age = 44 }
      ]
    }
  , Cmd.none)

type Msg
  = UsernameChange String 
  | PasswordChange String 
  | RememberPass Bool


-- UPDATE
update : Msg -> Model -> Model
update msg model = 
  case msg of 
    UsernameChange username ->
      { model | username = username }
    
    PasswordChange password ->
      { model | password = password }
    
    RememberPass isRemember ->
      { model | rememberPass = isRemember }


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg 
subscriptions model
  = Sub.none 



-- VIEW

view : Model -> Html Msg
view model = 
  div []
    [ viewInputText "text" model.username "Username" "username" "ar_input_username" UsernameChange 
    , viewInputText "password" model.password "Password" "password" "ar_input_password" PasswordChange
    , viewCheckbox "yes" "Remember Password" "remember-password" "ar_chk_remember_pass" RememberPass
    ]

viewInputText : String -> String -> String -> String -> String -> ( String -> msg ) -> Html Msg
viewInputText typ val inputTitle inputName inputID evt = 
  div 
    [ class "ar-input-container"
    ]
    [ input
        [ type_ typ 
        , class ( "ar-input-" ++ typ ) 
        , value val
        , placeholder inputTitle
        , name inputName
        , id inputID
        , onInput evt 
        , css 
            [ padding (px 5)
            , border3 (px 1) solid (rgba 0 0 0 0.2)
            , borderRadius (px 4)
            ]
        ]
    ]

viewCheckbox : String -> String -> String -> String -> Bool -> ( Bool -> msg ) -> Html Msg
viewCheckbox val inputTitle inputName inputID isChecked evt = 
  div 
    [ class "ar-checkbox-container"
    ]
    [ input
        [ type_ "checkbox" 
        , class ( "ar-input-checkbox" ) 
        , value val
        , checked isChecked
        , placeholder inputTitle
        , name inputName
        , id inputID
        , onCheck evt
        ]
    ]