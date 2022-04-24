import Scenes
import Igis

class UndoButton : RenderableEntity {
    let interaction = InteractionLayer()
    
    public func pressedButton() {
        
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"UndoButton")
    }
}
