module Form.Register exposing (init, update, view, Model, Msg)

import Browser
import Css
import Html

import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing ( class, type_, id, name, placeholder, css, value )
import Html.Styled.Events as Evt exposing ( onInput, onCheck )


-- MODEL

type alias Model =
  { username     : String
  , password     : String
  , passConfirm  : String 
  , isPassMatched : Bool
  }


init : () -> Model
init _ = 
  { username = ""
  , password = ""
  , passConfirm = ""
  , isPassMatched = False
  }

type Msg
  = UsernameChange String 
  | PasswordChange String 
  | PassConfirmChange String


-- UPDATE
update : Msg -> Model -> Model
update msg model = 
  case msg of 
    UsernameChange username ->
      { model | username = username }
    
    PasswordChange password ->
      { model | password = password }
    
    PassConfirmChange passConfirm ->
      { model | passConfirm = passConfirm }


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
    , viewInputText "password" model.passConfirm "Confirm Password" "pass_confirm" "ar_input_password" PassConfirmChange
    , viewResult model
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
            [ Css.padding (Css.px 5)
            , Css.border3 (Css.px 1) Css.solid (Css.rgba 0 0 0 0.2)
            , Css.borderRadius (Css.px 4)
            ]
        ] []
    ]

viewResult : Model -> Html msg 
viewResult model =
  let
    resultText = textResult model
  in
   
    div 
      [ Attr.class "ar-result-container" ]
      [ text resultText ]

textResult : Model -> String 
textResult model = 
  if model.password == model.passConfirm then 
    "Password is matched"
      
  else 
    "Password is not matched"