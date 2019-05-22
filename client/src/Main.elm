module Main exposing (main)

import Browser
import Browser.Navigation
import Element exposing (Element)
import Element.Border
import Element.Events
import Element.Input
import Html.Attributes
import RemoteData exposing (RemoteData)
import Url exposing (Url)


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url


type alias Model =
    { navKey : Browser.Navigation.Key
    }


type alias Flags =
    ()


init : Flags -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ url navKey =
    ( { navKey = navKey
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Browser.Navigation.pushUrl model.navKey (Url.toString url)
                    )

                Browser.External href ->
                    ( model, Browser.Navigation.load href )

        UrlChanged url ->
            ( model, Cmd.none )


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }


view : Model -> Browser.Document Msg
view model =
    { title = "The Elm Shoppe"
    , body =
        [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
            |> List.map String.fromInt
            |> List.map
                (\n ->
                    Element.paragraph [ Element.height (Element.px 100) ]
                        [ Element.link []
                            { url = "/#" ++ n
                            , label =
                                Element.text n
                                    |> Element.el
                                        [ Element.htmlAttribute (Html.Attributes.id n)
                                        ]
                            }
                        ]
                )
            |> Element.column [ Element.centerX ]
            |> Element.layout []
            |> List.singleton
    }
