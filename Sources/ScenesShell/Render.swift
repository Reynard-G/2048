import Scenes
import Igis

class Render : RenderableEntity {

    let Block = Blocks()
    let Board = Background()
    let ScoreDisplay = Score()
    
    init() {
        super.init(name:"Render")
    }

    // Render all these entities during each render cycle
    override func render(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let bigBoiSqr = Rect(topLeft: Point(x: canvasSize.center.x - 225, y: canvasSize.center.y - 225), size: Size(width: 450, height: 450))
            let Sqr = Rect(topLeft: Point(x: canvasSize.center.x - 215, y: canvasSize.center.y - 215), size: Size(width: 100, height: 100))
            Block.clearCanvas(canvas: canvas)
            Board.background(canvas: canvas)
            Board.board(canvas: canvas, canvasSize: canvasSize, biggerSquare: bigBoiSqr, square: Sqr)
            ScoreDisplay.renderScore(canvas: canvas, score: score)
            Block.renderLayout(canvas: canvas)
        }
    }
}
