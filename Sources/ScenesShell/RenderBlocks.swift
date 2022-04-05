import Scenes
import Igis

  /*
           This class is responsible for rendering the background.
   */


class RenderBlocks : RenderableEntity {
    var Board = Background()

    func clearCanvas(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }
    func Block2() {
        
    }
    func Block4() {
        
    }
    func renderLayout() {
        // Loop 16 times throughout the array and render in the approriate variables from the functions (Block2, Block4, etc).
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"RenderBlocks")
    }
    override func setup(canvasSize: Size, canvas: Canvas) {
        let fillStyle = FillStyle(color: Color(.floralwhite))
        let strokeStyle = StrokeStyle(color: Color(.darkgray))
        let bigBoiSqr = Rect(topLeft: Point(x: 100, y: 100), size: Size(width: 450, height: 450))
        let Sqr = Rect(topLeft: Point(x: 110, y: 110), size: Size(width: 100, height: 100))
        clearCanvas(canvas: canvas)
        Board.board(canvas: canvas, biggerSquare: bigBoiSqr, square: Sqr)
    }
}
