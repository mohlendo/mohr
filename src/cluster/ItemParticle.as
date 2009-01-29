package cluster
{
  import mx.core.UIComponent;
  
  import org.cove.ape.RectangleParticle;

  public class ItemParticle extends RectangleParticle
  { 
    public var component:UIComponent;   
    
    public function ItemParticle(x:Number, y:Number, width:Number, height:Number, rotation:Number = 0, fixed:Boolean = false, mass:Number = 1, elasticity:Number = 0.3, friction:Number = 0)
    {
      super(x, y, width, height,rotation, fixed, mass, elasticity, friction);

    }
    
    public function updateTilePositions():void
        {
               
                component.x = this.px-(this.width/2);
                component.rotation = this.sprite.rotation;
                component.y = this.py-(this.height/2);
                
            
        }
    
    
    
  }
}