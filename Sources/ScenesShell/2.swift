import Scenes
import Igis

  /*
        This class is responsible for rendering the background.
   */


class block : RenderableEntity {
    var rectangle : Rectangle
    var Board = Background()

    func clearCanvas(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }
    
    init(rect: Rect) {
        rectangle = Rectangle(rect: rect, fillMode: .fillAndStroke)
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }
    override func render(canvas: Canvas) {
        let fillStyle = FillStyle(color: Color(.floralwhite))
        let strokeStyle = StrokeStyle(color: Color(.darkgray))
        let bigBoiSqr = Rect(topLeft: Point(x: 100, y: 100), size: Size(width: 450, height: 450))
        let Sqr = Rect(topLeft: Point(x: 110, y: 110), size: Size(width: 100, height: 100))
        clearCanvas(canvas: canvas)
        Board.board(canvas: canvas, biggerSquare: bigBoiSqr, square: Sqr)
        canvas.render(fillStyle, strokeStyle, rectangle)
    }

    func move(to point: Point) {
        rectangle.rect.topLeft = point
    }
}
