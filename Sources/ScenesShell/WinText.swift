import Scenes
import Igis

class WinText : RenderableEntity {
    func winText(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let gameOver = Text(location: Point(x: canvasSize.center.x, y: canvasSize.center.y - 25), text: "You Win!")
            canvas.render(FillStyle(color: Color(.white)), gameOver)
        }
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Lose")
        setAlpha(alpha: Alpha(alphaValue: 1.0))
    }
    override func render(canvas: Canvas) {
        winText(canvas: canvas)
    }
}
