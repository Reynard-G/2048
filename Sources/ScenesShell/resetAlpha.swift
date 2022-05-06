import Scenes
import Igis

class resetAlpha : RenderableEntity {

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"resetAlpha")
    }

    // Reset the alpha/opacity of the canvas to 100%
    override func render(canvas: Canvas) {
        canvas.render(Alpha(alphaValue: 1.0))
    }
}
