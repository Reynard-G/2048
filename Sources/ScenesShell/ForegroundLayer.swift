import Scenes

  /*
     This class is responsible for the foreground Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class ForegroundLayer : Layer {
    
      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Foreground")
      }
  }
