module Form.Login exposing ( init, update, view, Model, Msg)

import Browser
import Css
import Html

import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing ( class, type_, value, placeholder, checked, name, id, css )
import Html.Styled.Events as Evt exposing ( onInput, onCheck )


-- MODEL

type alias Model =
  { username     : String
  , password     : String
  , rememberPass : Bool 
  }


init : () -> Model
init _ = 
  { username = ""
  , password = ""
  , rememberPass = False
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
    , viewCheckbox "yes" "Remember Password" "remember-password" "ar_chk_remember_pass" model.rememberPass RememberPass
    ]

viewInputText : String -> String -> String -> String -> String -> ( String -> msg ) -> Html msg
viewInputText typ val inputTitle inputName inputID evt = 
  div 
    [ Attr.class "ar-input-container" ]
    [ input
        [ Attr.type_ typ 
        , Attr.class ( "ar-input-" ++ typ ) 
        , Attr.value val
        , Attr.placeholder inputTitle
        , Attr.name inputName
        , Attr.id inputID
        , Evt.onInput evt 
        , Attr.css 
            [ Css.padding ( Css.px 5)
            , Css.border3 (Css.px 1) Css.solid (Css.rgba 0 0 0 0.2)
            , Css.borderRadius (Css.px 4)
            ]
        ] []
    ]

viewCheckbox : String -> String -> String -> String -> Bool -> ( Bool -> msg ) -> Html msg
viewCheckbox val inputTitle inputName inputID isChecked evt = 
  div 
    [ Attr.class "ar-checkbox-container" ]
    [ input
        [ Attr.type_ "checkbox" 
        , Attr.class ( "ar-input-checkbox" ) 
        , Attr.value val
        , Attr.checked isChecked
        , Attr.placeholder inputTitle
        , Attr.name inputName
        , Attr.id inputID
        , Evt.onCheck evt
        ] []
    ]