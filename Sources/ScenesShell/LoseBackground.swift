import Scenes
import Igis

class LoseBackground : RenderableEntity {
    func loseBackground(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let rect = Rect(topLeft: Point(x: canvasSize.center.x - 225, y: canvasSize.center.y - 225), size: Size(width: 450, height: 450))
            let rectangle = Rectangle(rect: rect, fillMode: .fill)
            canvas.render(FillStyle(color: Color(.white)), rectangle)
        }
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Lose")
        setAlpha(alpha: Alpha(alphaValue: 0.4))
    }
    override func render(canvas: Canvas) {
        loseBackground(canvas: canvas)
    }
}
