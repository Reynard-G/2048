import Scenes
import Igis

class WinBackground : RenderableEntity {

    func winBackground(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let rect = Rect(topLeft: Point(x: canvasSize.center.x - 225, y: canvasSize.center.y - 225), size: Size(width: 450, height: 450))
            let rectangle = Rectangle(rect: rect, fillMode: .fill)
            canvas.render(FillStyle(color: Color(red: 238, green: 201, blue: 77)), rectangle)
        }
    }

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"WinBackground")
        setAlpha(alpha: Alpha(alphaValue: 0.4))
    }

    override func render(canvas: Canvas) {
        winBackground(canvas: canvas)
    }
}
