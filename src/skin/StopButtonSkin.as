package skin
{
  import mx.skins.ProgrammaticSkin;

  public class StopButtonSkin extends ProgrammaticSkin
  {
    public function StopButtonSkin()
    {
      super();
    }

    // Override updateDisplayList().
     override protected function updateDisplayList(w:Number,
        h:Number):void {

          switch (name) {
           case "upSkin":
            drawStop(w,h);
            break;
           case "overSkin":
            drawStop(w,h);
            break;
           case "downSkin":
            drawStop(w,h);
            break;
           case "disabledSkin":
            drawStop(w,h);
            break;
           case "selectedUpSkin":
            drawStop(w,h);
            break;
           case "selectedOverSkin":
            drawStop(w,h);
            break;
           case "selectedDownSkin":
            drawStop(w,h);
            break;
        }

     }

     override public function get measuredHeight():Number
     {
        return 18;
     }

    override public function get measuredWidth():Number
    {
      return 18;
    }

     private function drawStop(w:Number, h:Number):void
     {
       graphics.clear();
       graphics.beginFill(0xFFFFFF,1);
       graphics.drawRect(0,0,w,h);
       graphics.endFill();

     }


  }
}