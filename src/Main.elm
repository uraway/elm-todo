module Main exposing (..)
import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onClick, onInput)

---- MODEL ----

type alias ToDo =
    { id: Int
    , message: String
    , status: ToDoStatus
    }

type ToDoStatus
    = Wip
    | Done

type alias Model =
    { toDoList: List ToDo
    , message: String
    , nextId: Int
    }


init : Model
init =
    { toDoList = []
    , message = ""
    , nextId = 0
    }



---- UPDATE ----


type Msg
    = EnteredMessage String
    | ClickedCreateButton

update : Msg -> Model -> Model
update msg model =
    case msg of
      EnteredMessage message ->
        { model | message = message }

      ClickedCreateButton ->
        let
          newToDo =
            { id = model.nextId
            , message = model.message
            , status = Wip
            }
        in
        { model
            | toDoList = newToDo :: model.toDoList
            , message = ""
            , nextId = model.nextId + 1
        }

---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ input
            [ type_ "text"
            , onInput EnteredMessage
            , value model.message
            ]
            []
        , button
            [ onClick ClickedCreateButton ]
            [ text "作成" ]
        , div
            []
            (List.map viewToDo model.toDoList)
        ]

viewToDo : ToDo -> Html Msg
viewToDo { message } =
    div [] [ text message  ]

---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
