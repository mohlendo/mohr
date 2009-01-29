package components
{
  import mx.core.UIComponent;

  public class Status extends UIComponent
  {
    private var _status:String;
    
    public static const GOOD:String = "good";
    public static const BAD:String = "bad";
    
    
    [Inspectable(defaultValue="bad",enumeration="good,bad")]
    [Bindable] 
    public function set status(value:String):void
    {
      this._status = value;
      this.createChildren();
    }
    
    public function get status():String
    {
      return _status;
    }
    
    [Bindable] 
    public function set text(value:String):void
    {
      this.toolTip = value;
    }
    
    public function get text():String
    {
      return this.toolTip;
    }
    
    public function Status()
    {      
      super();
      this._status = BAD;
    }
    
    override public function get measuredHeight():Number
    {
        return 6;
     }

    override public function get measuredWidth():Number
    {
      return 6;
    }
    
    override protected function createChildren():void
    {
      super.createChildren();
       graphics.clear();
      if(status == GOOD)
        graphics.beginFill(0x00FF00,1);
      if(status == BAD)
        graphics.beginFill(0xFF0000,1);
      graphics.lineStyle(0.5,0x00000,1,false);
      graphics.drawCircle(this.x+4,this.y+8,6);
      graphics.endFill();
    }
    
    
  }
}