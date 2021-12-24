module Main exposing (..)

import Browser
import Css
import Html

import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing ( css, class )
import Html.Styled.Events as Evt exposing ( onInput, onCheck, onClick )

import Form.Login as FrmLogin exposing ( init, view, update, Model, Msg )
import Form.Register as FrmRegister exposing ( init, view, update, Model, Msg )

main = Browser.element
         { init = init 
         , update = update
         , view = view >> toUnstyled
         , subscriptions = subscriptions
         }


-- MODEL

type alias Model = 
  { activeTab : Tab
  , loginFields : FrmLogin.Model
  , registerFields : FrmRegister.Model
  }


type Tab
  = Login
  | Register

init : () -> (Model, Cmd Msg)
init _ = 
  let
    model = 
      { activeTab = Login 
      , loginFields = (FrmLogin.init ())
      , registerFields = (FrmRegister.init ())
      }
  in
    (model, Cmd.none)

-- UPDATE

type Msg 
  = LoginClick
  | RegisterClick
  | GotLoginMsg FrmLogin.Msg
  | GotRegisterMsg FrmRegister.Msg


update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of 
    LoginClick ->
      ({ model | activeTab = Login }, Cmd.none)
    
    RegisterClick ->
      ({model | activeTab = Register}, Cmd.none)
    
    GotLoginMsg loginMsg ->
      let
        loginModel = FrmLogin.update loginMsg model.loginFields
      in
        ({model | loginFields = loginModel }, Cmd.none)
    
    GotRegisterMsg registerMsg ->
      let
        registerModel = FrmRegister.update registerMsg model.registerFields
      in
        ({model | registerFields = registerModel }, Cmd.none)



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg 
subscriptions model
  = Sub.none 



-- VIEW

view : Model -> Html Msg 
view model = 
  div 
    [ class "ar-tab-container"
    ]
    [ viewListTab model
    , viewContentTab model
    ]


viewListTab : Model -> Html Msg 
viewListTab model =   
  ul []
    [ viewListTabLink model LoginClick "Login"
    , viewListTabLink model RegisterClick "Register"
    ]


viewListTabLink : Model -> msg -> String -> Html msg
viewListTabLink model message linkText = 
  let
    classVal = 
      if model.activeTab == Register && linkText == "Register" then 
        "register-tab-active"
        
      else if model.activeTab == Login && linkText == "Login" then
        "login-tab-active"
        
      else 
        ""
  in
    li 
      [ class ("tab-link " ++ classVal ) ]
      [ a 
        [ Evt.onClick message 
        , Attr.css
            [ Css.cursor Css.pointer 
            ] 
        ] 
        [ text linkText ]
      ]

viewContentTab : Model -> Html Msg 
viewContentTab model = 
  if model.activeTab == Login then
    div [] 
      [ map GotLoginMsg ( FrmLogin.view model.loginFields ) 
      ]
  else
    div [] 
      [ map GotRegisterMsg ( FrmRegister.view model.registerFields )
      ]