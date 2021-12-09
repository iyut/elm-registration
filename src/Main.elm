module Main exposing (..)

import Browser
import Css exposing (..)
import Html

import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (..)
import Html.Styled.Events as Evt exposing ( onInput, onCheck )

import Form.Login as Login exposing ( init, view, update, subscriptions )

main = Browser.element
         { init = Login.init 
         , update = Login.update
         , view = Login.view >> toUnstyled
         , subscriptions = Login.subscriptions
         }