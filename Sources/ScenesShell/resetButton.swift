import Scenes
import Igis

class ResetButton : RenderableEntity {
    let interaction = InteractionLayer()

    public func pressedButton() {
        positions = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        score = 0
        interaction.generateRandomBlock(positions: &positions)
        interaction.generateRandomBlock(positions: &positions)
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"ResetButton")
    }
}
