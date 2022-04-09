import Scenes
import Igis

  /*
        This class is responsible for rendering the background.
   */


class Background : RenderableEntity {
    func board(canvas: Canvas, canvasSize: Size, biggerSquare: Rect, square: Rect) {
        var currentRect = square
        let bigBoiSquare = Rectangle(rect: biggerSquare, fillMode: .fill)
        var Square = Rectangle(rect: square, fillMode: .fill)
        canvas.render(FillStyle(color: Color(red: 187, green: 172, blue: 161)), bigBoiSquare)
        for _ in 0 ..< 4 {
            for _ in 0 ..< 4 {
                Square = Rectangle(rect: currentRect, fillMode: .fill)
                canvas.render(FillStyle(color: Color(red: 205, green: 192, blue: 181)), Square)
                currentRect.topLeft.x += 110
            }
            currentRect.topLeft.y += 110
            currentRect.topLeft.x = canvasSize.center.x - 215
        }
    }
    func background(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft: Point(), size: canvasSize)
            let canvasRectangle = Rectangle(rect: canvasRect, fillMode: .fill)
            canvas.render(FillStyle(color: Color(red: 251, green: 249, blue: 239)), canvasRectangle)
        }
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }
    override func setup(canvasSize: Size, canvas: Canvas) {
        let bigBoiSqr = Rect(topLeft: Point(x: canvasSize.center.x - 225, y: canvasSize.center.x - 225), size: Size(width: 450, height: 450))
        let Sqr = Rect(topLeft: Point(x: canvasSize.center.x - 215, y: canvasSize.center.x - 215), size: Size(width: 100, height: 100))
        background(canvas: canvas)
        board(canvas: canvas, canvasSize: canvasSize, biggerSquare: bigBoiSqr, square: Sqr)
    }
}
