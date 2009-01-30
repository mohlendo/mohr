package config
{
  import flash.desktop.NativeApplication;
  import flash.net.SharedObject;
  
  public class Settings
  {	      
	  [Bindable]
	  public var showCoreMediaBlog:Boolean = false;
    
    [Bindable]
	  public var startOnLoggin:Boolean = true;
	  	  	  
	  [Bindable]
	  public var username:String;
	  
	  [Bindable]
	  public var password:String;    
    
    [Bindable]
    public var notificationSoundIndex:uint = 0;
    
    private const SETTINGS_SO:String="settings";
        
    public function Settings() {
      NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExit);
      __load();
    }
    
    private function onExit(e:Event):void {
			__save();
		}
    
    public function __load():void {
      var settings:SharedObject = SharedObject.getLocal(SETTINGS_SO);
           
      if(settings.data.showCoreMediaBlog != null)
        showCoreMediaBlog = settings.data.showCoreMediaBlog;
      if(settings.data.startOnLoggin != null)
        startOnLoggin = settings.data.startOnLoggin;
      
      if(settings.data.notificationSoundIndex != null)
        notificationSoundIndex = settings.data.notificationSoundIndex;
        
      username = settings.data.username;
      password = settings.data.password;
    }
    
    public function __save():void {
      
      var settings:SharedObject = SharedObject.getLocal(SETTINGS_SO);      
      settings.data.showCoreMediaBlog = showCoreMediaBlog;
      settings.data.startOnLoggin = startOnLoggin; 
      
      settings.data.username = username;
      settings.data.password = password;
      
      settings.data.notificationSoundIndex = notificationSoundIndex;

      settings.flush();    
      
    }
  
  }
}