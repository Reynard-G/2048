import Scenes
import Igis

class Lose : RenderableEntity {
    func loseBackground(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let gameOver = Text(location: Point(x: canvasSize.center.x, y: canvasSize.center.y - 25), text: "Game Over!")
            canvas.render(FillStyle(color: Color(red: 118, green: 111, blue: 101)), gameOver, Alpha(alphaValue: 0.6))
        }
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Lose")
    }
    override func render(canvas: Canvas) {
        loseBackground(canvas: canvas)
    }
}
