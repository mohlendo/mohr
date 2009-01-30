package components
{
  import config.Components;
  
  import flash.desktop.DockIcon;
  import flash.desktop.NativeApplication;
  import flash.desktop.NotificationType;
  import flash.display.NativeWindowSystemChrome;
  import flash.display.NativeWindowType;
  import flash.display.Screen;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.Rectangle;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  
  import mx.core.Application;
  import mx.core.Window;
  import mx.events.FlexEvent;
  
  public class Notification
  {
    /** Reference to singleton instance of this class. */
    private static var _instance:Notification;    
    
    public function Notification()
    {
      super();
      _instance = this;
     }
    
    [Bindable("instanceChanged")]
    public static function get instance():Notification
    {
      if(!_instance)
        _instance = new Notification();
      return _instance;
    }
    
    public function newMessage(data:Object):void 
    {
      Components.instance.notificationSound.play();
      if(NativeApplication.supportsDockIcon) {
          var dock:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;
          dock.bounce(NotificationType.CRITICAL);
      } else if (NativeApplication.supportsSystemTrayIcon) {
          Application.application.stage.nativeWindow.notifyUser(NotificationType.CRITICAL);
      }
                        
      var notifyWindow:Window = new Window();
      notifyWindow.systemChrome = NativeWindowSystemChrome.NONE;
      notifyWindow.height=80;
      notifyWindow.width=300;
      notifyWindow.type = NativeWindowType.LIGHTWEIGHT;
      notifyWindow.transparent=true;
      notifyWindow.setStyle("borderStyle", "none");
      notifyWindow.showGripper = false;
      notifyWindow.showStatusBar = false;
      notifyWindow.showTitleBar = false;
      var timeoutId:uint = setTimeout(function():void {notifyWindow.close()}, 5000);
      notifyWindow.addEventListener(MouseEvent.CLICK, function(e:Event):void {
        Components.instance.analyticsTracker.trackEvent("mohr","Close notification"); 
        clearTimeout(timeoutId); 
        notifyWindow.close(); 
        Application.application.undock(e);
      });
      var item:TrillrItemRenderer = new TrillrItemRenderer();
      item.data = data;
      notifyWindow.addChild(item);
      notifyWindow.open(false);           
      var bounds:Rectangle = Screen.mainScreen.visibleBounds;   	
      notifyWindow.nativeWindow.x = bounds.bottomRight.x - notifyWindow.width, 
      notifyWindow.nativeWindow.y = bounds.bottomRight.y - notifyWindow.height;                      
    }    
  }
}