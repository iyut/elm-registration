Module Form.Login exposing (..)

import Css exposing (..)
import Html

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing ( onInput, onCheck )


-- MODEL

type alias Model =
  { username : String
  , password : String
  , rememberPass : Bool 
  }

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


-- VIEW

view : Model -> Html Msg
view model = 
  div []
    [ viewInput "text" model.username "Username" "username" "ar_input_username" UsernameChange 
    , viewInput "password" model.password "Password" "password" "ar_input_password" PasswordChange
    , viewCheckbox "yes" "Remember Password" "remember-password" "ar_chk_remember_pass" RememberPass
    ]

viewInputText : String -> String -> String -> String -> String -> ( String -> msg ) -> Html Msg
viewInputText typ val inputTitle inputName inputID evt = 
  div 
    [ class "ar-input-container"
    ]
    [ input
        [ _type typ 
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
viewCheckbox = val inputTitle inputName inputID isChecked evt = 
  div 
    [ class "ar-checkbox-container"
    ]
    [ input
        [ _type "checkbox" 
        , class ( "ar-input-" ++ typ ) 
        , value val
        , checked isChecked
        , placeholder inputTitle
        , name inputName
        , id inputID
        , onCheck evt
        ]
    ]