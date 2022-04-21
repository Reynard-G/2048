import Scenes
import Igis

class LoseBackground : RenderableEntity {
    func loseBackground(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let rect = Rect(topLeft: Point(x: canvasSize.center.x - 225, y: canvasSize.center.y - 225), size: Size(width: 450, height: 450))
            let rectangle = Rectangle(rect: rect, fillMode: .fill)
            canvas.render(FillStyle(color: Color(red: 251, green: 249, blue: 239)), rectangle)
        }
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"LoseBackground")
        setAlpha(alpha: Alpha(alphaValue: 0.4))
    }
    override func render(canvas: Canvas) {
        loseBackground(canvas: canvas)
    }
}
