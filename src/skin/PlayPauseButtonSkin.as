package skin
{
  import mx.skins.ProgrammaticSkin;

  public class PlayPauseButtonSkin extends ProgrammaticSkin
  {
    public function PlayPauseButtonSkin()
    {
    }

    // Override updateDisplayList().
     override protected function updateDisplayList(w:Number,
        h:Number):void {

          switch (name) {
           case "upSkin":
            drawTriangle(w,h);
            break;
           case "overSkin":
            drawTriangle(w,h);
            break;
           case "downSkin":
            drawTriangle(w,h);
            break;
           case "disabledSkin":
            drawTriangle(w,h);
            break;
           case "selectedUpSkin":
            drawPause(w,h);
            break;
           case "selectedOverSkin":
            drawPause(w,h);
            break;
           case "selectedDownSkin":
            drawPause(w,h);
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

     private function drawPause(w:Number,h:Number):void {
        graphics.clear();
        graphics.beginFill(0xFFFFFF,0);
        graphics.drawRect(0,0,w,h);
        graphics.endFill();

        graphics.beginFill(0xFFFFFF,1);
        graphics.drawRect(0,0,7,h);
        graphics.endFill();

        graphics.beginFill(0xFFFFFF,1);
        graphics.drawRect(h-7,0,7,h);
        graphics.endFill();

     }

     private function drawTriangle(w:Number,h:Number):void {
        graphics.clear();
        graphics.beginFill(0xFFFFFF,0);
        graphics.drawRect(0,0,w,h);
        graphics.endFill();
        // red triangle, starting at point 0, 0
        graphics.beginFill(0xFFFFFF);
        graphics.moveTo(0, 0);
        graphics.lineTo(0, h);
        graphics.lineTo(w, h/2);
        graphics.lineTo(0, 0);
        graphics.endFill();
     }
  }
}