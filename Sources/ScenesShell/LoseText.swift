import Scenes
import Igis

class LoseText : RenderableEntity {

    // Render in the losing text
    func loseText(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let gameOver = Text(location: Point(x: canvasSize.center.x, y: canvasSize.center.y - 25), text: "Game Over!")
            canvas.render(FillStyle(color: Color(red: 118, green: 111, blue: 101)), gameOver)
        }
    }

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Lose")
        setAlpha(alpha: Alpha(alphaValue: 1.0))
    }

    override func render(canvas: Canvas) {
        loseText(canvas: canvas)
    }
}
