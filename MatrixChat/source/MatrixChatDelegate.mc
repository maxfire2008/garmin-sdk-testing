import Toybox.Lang;
import Toybox.WatchUi;

class MatrixChatDelegate extends WatchUi.BehaviorDelegate {
    private var _notify as Method(args as Dictionary or String or Null) as Void;

    public function initialize(handler as Method(args as Dictionary or String or Null) as Void) {
        WatchUi.BehaviorDelegate.initialize();
        _notify = handler;
    }

    function onMenu() as Boolean {
        var delegate = new $.MatrixChatMenuDelegate(_notify);
        WatchUi.pushView(new Rez.Menus.MainMenu(), delegate, WatchUi.SLIDE_UP);
        return true;
    }

}
