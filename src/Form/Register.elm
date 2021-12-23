module Form.Register exposing (init, update, view, Model, Msg)

import Browser
import Css exposing (..)
import Html

import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (..)
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
      if model.passConfirm == password then 
        { model | isPassMatched = True}
      
      else 
        { model | isPassMatched = False}
    
    PassConfirmChange passConfirm ->
      if model.passConfirm == passConfirm then 
        { model | isPassMatched = True}
      
      else 
        { model | isPassMatched = False}


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
    ]

viewInputText : String -> String -> String -> String -> String -> ( String -> msg ) -> Html msg
viewInputText typ val inputTitle inputName inputID evt = 
  div 
    [ class "ar-input-container" ]
    [ input
        [ Attr.type_ typ 
        , Attr.class ( "ar-input-" ++ typ ) 
        , Attr.value val
        , Attr.placeholder inputTitle
        , Attr.name inputName
        , Attr.id inputID
        , Evt.onInput evt 
        , Attr.css 
            [ padding (px 5)
            , border3 (px 1) solid (rgba 0 0 0 0.2)
            , borderRadius (px 4)
            ]
        ] []
    ]

viewResult : Model -> Html msg 
viewResult model =
  let
    resultText = textResult model
  in
   
    div 
      [ class "ar-result-container" ]
      [ text resultText ]

textResult : Model -> String 
textResult model = 
  if model.isPassMatched == True then 
    "Password is matched"
      
  else 
    "Password is not matched"