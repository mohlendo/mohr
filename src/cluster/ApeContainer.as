package cluster
{
  import flash.display.Sprite;
  import flash.events.Event;
  
  import mx.collections.ArrayCollection;
  import mx.collections.ICollectionView;
  import mx.collections.IList;
  import mx.collections.ListCollectionView;
  import mx.collections.XMLListCollection;
  import mx.core.IFactory;
  import mx.core.UIComponent;
  import mx.events.CollectionEvent;
  import mx.events.CollectionEventKind;
  
  import org.cove.ape.APEngine;
  import org.cove.ape.Group;
  import org.cove.ape.RectangleParticle;

  public class ApeContainer extends UIComponent
  {
    private var defaultGroup:Group;
    private var boundaryGroup:Group = new Group();
    
    protected var collection:ICollectionView;
    
    private var _itemRenderer:IFactory;

    public function ApeContainer() {
      super();
      this.addEventListener(Event.ENTER_FRAME, run);
            
      APEngine.init(1/4);
      APEngine.container = this;
      APEngine.damping = 1
      //APEngine.addForce(new VectorForce(false,0,1-1));
       
      defaultGroup = new Group();
      defaultGroup.collideInternal = true;

      APEngine.addGroup(defaultGroup);      
    }
    
    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
      super.updateDisplayList(unscaledWidth,unscaledHeight);
      if(boundaryGroup)
        APEngine.removeGroup(boundaryGroup); 
      boundaryGroup = new Group();
      boundaryGroup.cleanup();
      var leftWallParticle:RectangleParticle =  new RectangleParticle(this.x, this.x, 1, this.height, 0, true, 100);
      leftWallParticle.setStyle(2, 0x555555, 1, 0x5d81bd);
            
      var bottomWallParticle:RectangleParticle = new RectangleParticle(this.x,this.x + this.height,this.width,1,0,true,100);
      bottomWallParticle.setStyle(2, 0x555555, 1, 0x8aa9dc);
            
            // not setting the sprites will show the APE components, which just happen to create 
            // a cool drop-shadow effect inside the display panel so I'm leaving them commented out
            /*
            topWallParticle.setDisplay(new Sprite());
            bottomWallParticle.setDisplay(new Sprite());
            leftWallParticle.setDisplay(new Sprite());
            rightWallParticle.setDisplay(new Sprite());
            */
     boundaryGroup.addParticle(leftWallParticle);   
     boundaryGroup.addParticle(bottomWallParticle);
      
     APEngine.addGroup(boundaryGroup);      
    }

    [Inspectable(category="Data")]

    public function get itemRenderer():IFactory
    {
      return _itemRenderer;
    }

    /**
     *  @private
     */
    public function set itemRenderer(value:IFactory):void
    {
      _itemRenderer = value;
      
      invalidateSize();
      invalidateDisplayList();

      dispatchEvent(new Event("itemRendererChanged"));
    }
    
    
    [Bindable("collectionChange")]
    [Inspectable(category="Data", defaultValue="undefined")]

    public function get dataProvider():Object
    {               
      return collection;
    }

    
    /**
     *  @private
     */
    public function set dataProvider(value:Object):void
    {
      if (collection)
      {
          collection.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler);
      }
  
      if (value is Array)
      {
          collection = new ArrayCollection(value as Array);
      }
      else if (value is ICollectionView)
      {
          collection = ICollectionView(value);
      }
      else if (value is IList)
      {
          collection = new ListCollectionView(IList(value));
      }
      else if (value is XMLList)
      {
          collection = new XMLListCollection(value as XMLList);
      }
      else if (value is XML)
      {
          var xl:XMLList = new XMLList();
          xl += value;
          collection = new XMLListCollection(xl);
      }
      else
      {
          // convert it to an array containing this one item
          var tmp:Array = [];
          if (value != null)
              tmp.push(value);
          collection = new ArrayCollection(tmp);
      }
      
      collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, 0, true);
  
  
      var event:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
      event.kind = CollectionEventKind.RESET;
      collectionChangeHandler(event);
      dispatchEvent(event);
  
      invalidateProperties();
      invalidateSize();
      invalidateDisplayList();
    }
    
    protected function collectionChangeHandler(event:Event):void {
      
      var randomX:Number;
      var randomY:Number;
      var randomAngle:Number;      
            
      for each (var item:Object in collection) {
        
        randomX = this.x + ((Math.random() * this.width/2) - (Math.random() * this.width/2));
        randomY = this.y + ((Math.random() * this.height/2) - (Math.random() * this.height/2));
        if(randomX < 0)
          randomX = randomX * -1
          
        if(randomY <0)
          randomY = randomY * -1
          
        var renderer:* = _itemRenderer.newInstance();
        renderer.data = item;
        renderer.x = randomX;
        renderer.y = randomY;
        renderer.owner = this;
        
        this.addChild(renderer);
        var tile:ItemParticle = new ItemParticle(randomX+(renderer.width/2),randomY+(renderer.height/2),renderer.width,renderer.height,
                                                                      0,
                                                                      false, 
                                                                     .3, 
                                                                     .3, 
                                                                     .3);
        tile.setDisplay(new Sprite());
        tile.component = UIComponent(renderer);        
        defaultGroup.addParticle(tile);        
      }      
      
      //defaultGroup.addCollidableList(new Array(boundaryGroup, defaultGroup));
    }
    
    
    private function run(evt:Event):void {         
      APEngine.step();
      APEngine.paint();   
      for each (var nextTileParticle:ItemParticle in defaultGroup.particles)
      {
                nextTileParticle.updateTilePositions();
      } 
    }
  }
}