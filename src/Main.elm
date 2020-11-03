module Main exposing (main)

{- This is a starter app which presents a text label, text field, and a button.
   What you enter in the text field is echoed in the label.  When you press the
   button, the text in the label is reverse.
   This version uses `mdgriffith/elm-ui` for the view functions.
-}

import Browser
import Html exposing (Html)
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Http


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { input : String
    , output : String
    }


type Msg
    = NoOp
    | InputText String
    | ReverseText


type alias Flags =
    {}


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { input = "App started"
      , output = "App started"
      }
    , Cmd.none
    )


subscriptions model =
    Sub.none



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        InputText str ->
            ( { model | input = str, output = str }, Cmd.none )

        ReverseText ->
            ( { model | output = model.output |> String.reverse |> String.toLower }, Cmd.none )



--
-- VIEW
--

fontGray g = Font.color (Element.rgb g g g )
bgGray g =  Background.color (Element.rgb g g g)

view : Model -> Html Msg
view model =
    Element.layout [bgGray 0.2] (mainColumn model)


mainColumn : Model -> Element Msg
mainColumn model =
    column mainColumnStyle
        [ column [ spacing 36, width (px 500), height (px 400) ]
            [ title "Starter app"
            , inputText model
            , outputDisplay model
            , appButton
            
            ]
        ]


title : String -> Element msg
title str =
    row [ centerX, Font.bold, fontGray 0.9 ] [ text str ]



outputDisplay : Model -> Element msg
outputDisplay model =
    column [ spacing 8 ]
        [ el [fontGray 0.9] (text "Output")
        , outputDisplay_ model]            

outputDisplay_ : Model -> Element msg
outputDisplay_ model =
    column [ spacing 8
             , Background.color (Element.rgb 1.0 1.0 1.0)
             , paddingXY 8 12
            , width (px 500)]
        [ text model.output ]


inputText : Model -> Element Msg
inputText model =
    Input.text [ ]
        { onChange = InputText
        , text = model.input
        , placeholder = Nothing
        , label = Input.labelAbove [fontGray 0.9] <| el [] (text "Input")
        }


appButton : Element Msg
appButton =
    row [  ]
        [ Input.button buttonStyle
            { onPress = Just ReverseText
            , label = el [ centerX, centerY ] (text "Reverse")
            }
        ]



--
-- STYLE
--


mainColumnStyle =
    [ centerX
    , centerY
    , bgGray 0.5
    , paddingXY 20 20
    ]


buttonStyle =
    [ Background.color (Element.rgb 0.5 0.5 1.0)
    , Font.color (rgb255 255 255 255)
    , paddingXY 15 8
    ]



--