package controller
{
  import flash.desktop.Updater;
  import flash.display.Screen;
  import flash.events.Event;
  import flash.filesystem.File;
  import flash.filesystem.FileMode;
  import flash.filesystem.FileStream;
  import flash.geom.Rectangle;
  import flash.net.URLRequest;
  import flash.net.URLStream;
  import flash.utils.ByteArray;
  
  import mx.core.Application;
  import mx.rpc.events.FaultEvent;
  import mx.rpc.events.ResultEvent;
  import mx.rpc.http.HTTPService;
  import mx.utils.StringUtil;

  public class UpdateController
  {
    public var serverVersion:String;
    
    private var updatePopup:UpdatePopup;

    private var urlStream:URLStream = new URLStream();
    private var fileData:ByteArray = new ByteArray();
    

    public function updateRequired():void
    {
      var versionService:HTTPService = new HTTPService();
      versionService.url = Application.application.baseUrl+"/static/apps/mohr/version";
      versionService.addEventListener(ResultEvent.RESULT,checkVersion);
      versionService.addEventListener(FaultEvent.FAULT,handleError);
      versionService.send();
    }

    private function checkVersion(event:ResultEvent):void
    {
      
      serverVersion = StringUtil.trim(event.result.toString());
      if(Application.application.version != serverVersion)
      {
        updatePopup = new UpdatePopup();
        updatePopup.version = serverVersion;
        updatePopup.open(true);
        var screenBounds:Rectangle = Screen.mainScreen.bounds;
        updatePopup.nativeWindow.x = (screenBounds.width - updatePopup.nativeWindow.width) / 2;
        updatePopup.nativeWindow.y = (screenBounds.height - updatePopup.nativeWindow.height) / 2;
        
      }
    }

    public function cancelUpdate():void
    {
      updatePopup.close();
      updatePopup = null;
    }

    public function update():void
    {
      getUpdate();
    }

    private function getUpdate():void
    {
      var urlReq:URLRequest = new URLRequest(Application.application.baseUrl+"/static/apps/mohr/mohr.air");
      urlStream.addEventListener(Event.COMPLETE, loaded);
      urlStream.load(urlReq);
    }

    // Handle urlStream COMPLETE Event and call writeAirFile()
    private function loaded(event:Event):void
    {
      urlStream.readBytes(fileData, 0, urlStream.bytesAvailable);
      writeAirFile();
    }

    // Write air file to disk and store in appStorageDirectory
    private function writeAirFile():void
    {
      var file:File = File.applicationStorageDirectory.resolvePath("mohr.air");

      if(file.exists)
        file.deleteFile();

      var fileStream:FileStream = new FileStream();
      fileStream.addEventListener(Event.CLOSE, fileClosed);
      fileStream.openAsync(file, FileMode.WRITE);
      fileStream.writeBytes(fileData, 0, fileData.length);
      fileStream.close();
    }

    private function fileClosed(event:Event):void
    {
      var updater:Updater = new Updater();
      var airFile:File = File.applicationStorageDirectory.resolvePath("mohr.air");
      updater.update(airFile,serverVersion);
    }



    private function handleError(e:Event):void
    {
      Application.application.connectError();
    }

  }
}
