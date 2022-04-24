import Scenes
import Igis

class Render : RenderableEntity {
    init() {
        super.init(name:"Render")
    }
    override func render(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let bigBoiSqr = Rect(topLeft: Point(x: canvasSize.center.x - 225, y: canvasSize.center.y - 225), size: Size(width: 450, height: 450))
            let Sqr = Rect(topLeft: Point(x: canvasSize.center.x - 215, y: canvasSize.center.y - 215), size: Size(width: 100, height: 100))
            Blocks().clearCanvas(canvas: canvas)
            Background().background(canvas: canvas)
            Background().board(canvas: canvas, canvasSize: canvasSize, biggerSquare: bigBoiSqr, square: Sqr)
            Score().renderScore(canvas: canvas, score: score)
            Blocks().renderLayout(canvas: canvas)
            TickRate().render(canvas: canvas)
        }
    }
}
