package config
{
  import com.google.analytics.AnalyticsTracker;
  
  import controller.UpdateController;
  
  import flash.events.Event;
  import flash.media.Sound;
  import flash.net.URLRequest;
  
  import mx.binding.utils.BindingUtils;
  import mx.collections.ArrayCollection;
  import mx.core.UIComponent;

  public class Components extends UIComponent
  {
    /** Reference to singleton instance of this class. */
    private static var _instance:Components;
    
    [Bindable]
    public var updateText:String;
    
    [Bindable]
    public var group:Object;
        
    [Bindable]
    public var settings:Settings;
    
    [Bindable]
    public var sounds:ArrayCollection = new ArrayCollection();
    
    [Bindable]
    public var updateController:UpdateController;
    
    [Bindable]
    public var analyticsTracker:AnalyticsTracker;
    
    private var _notificationSound:Sound;
    
    public function Components()
    {
      super();
      _instance = this;
      settings = new Settings();            
      
      sounds.addItem({label:"Sheep",sound:"app:/assets/sounds/sheep.mp3"});
      sounds.addItem({label:"Frog",sound:"app:/assets/sounds/frog.mp3"});
      sounds.addItem({label:"Cow",sound:"app:/assets/sounds/cow.mp3"});
      
      dispatchEvent(new Event("instanceChanged"));      
      BindingUtils.bindSetter(changeSound,settings,["notificationSoundIndex"]);
    }
    
    private function  changeSound(value:uint):void {
      _notificationSound = new Sound(new URLRequest(sounds.getItemAt(settings.notificationSoundIndex).sound));
    }
    
    public function get notificationSound():Sound {
      if(!_notificationSound) {
        _notificationSound = new Sound(new URLRequest(sounds.getItemAt(settings.notificationSoundIndex).sound));
      }
      return _notificationSound;
      
    }

    [Bindable("instanceChanged")]
    public static function get instance():Components
    {
      return _instance;
    }

  }
}