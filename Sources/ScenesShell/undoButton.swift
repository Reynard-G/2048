import Scenes
import Igis

class UndoButton : RenderableEntity {

    var prevPosition : [Int] = []
    var prevScore : Int = 0
    
    public func pressedButton() {
        if prevPosition.isEmpty == false && positions != prevPosition {
            positions = prevPosition
            score = prevScore
        }
    }

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"UndoButton")
    }
}
