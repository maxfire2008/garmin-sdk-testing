import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MatrixChatMenuDelegate extends WatchUi.MenuInputDelegate {
    private var _notify as Method(args as Dictionary or String or Null) as Void;

    public function initialize(handler as Method(args as Dictionary or String or Null) as Void) {
        MenuInputDelegate.initialize();
        _notify = handler;
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) {
            System.println("item 1");
            makeRequest();
        } else if (item == :item_2) {
            System.println("item 2");
        }
    }

    //! Make the web request
    private function makeRequest() as Void {
        _notify.invoke("Executing\nRequest");

        var options = {
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
            :headers => {
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED
            }
        };

        Communications.makeWebRequest(
            "https://jsonplaceholder.typicode.com/todos/115",
            {},
            options,
            method(:onReceive)
        );
    }

    //! Receive the data from the web request
    //! @param responseCode The server response code
    //! @param data Content from a successful request
    public function onReceive(responseCode as Number, data as Dictionary<String, Object?> or String or Null) as Void {
        if (responseCode == 200) {
            _notify.invoke(data);
            System.println(data);
        } else {
            _notify.invoke("Failed to load\nError: " + responseCode.toString());
        }
    }

}

