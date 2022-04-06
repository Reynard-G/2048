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
    // Create a function here to find where the blocks are suppose to render
    func Blocks(canvas: Canvas, value: Int) {
        switch(value) {
        case 2:
            // Design/render blocks here
            let test = Text(location: Point(x: 110, y: 110), text: "LETS GOO IT WORKS")
            canvas.render(test)
            break;
        case 4:
            let test4 = Text(location: Point(x: 220, y: 220), text: ":OOOOOOOOOO")
            canvas.render(test4)
            break;
        case 8:
            break;
        case 16:
            break;
        case 32:
            break;
        case 64:
            break;
        case 128:
            break;
        case 256:
            break;
        case 512:
            break;
        case 1024:
            break;
        case 2048:
            break;
        default:
            print("They went over 2048???")
            break;
        }
    }
    
    func renderLayout(canvas: Canvas) {
        // Loop 16 times throughout the array and render in the approriate variables from the functions (Block2, Block4, etc).
        for i in 0 ..< positions.count {
            switch(positions[i]) {
            case 0:
                // Leave this alone
                break;
            case 2:
                // Call Blocks() and render the appropriate blocks here.
                // Maybe like getXCoords(index: i) & getYCoords(index: i) (It turns the index to coords on the array and relays it back to Blocks() like this    VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV)
                Blocks(canvas: canvas, value: 2/*, x: getXCoords(index: i), y: getYCoords(index: i)*/)
                break;
            case 4:
                Blocks(canvas: canvas, value: 4)
                break;
            case 8:
                break;
            case 16:
                break;
            case 32:
                break;
            case 64:
                break;
            case 128:
                break;
            case 256:
                break;
            case 512:
                break;
            case 1024:
                break;
            case 2048:
                break;
            default:
                print("This was not suppose to happen...")
            }
        }
    }
    init() {
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"RenderBlocks")
    }
    override func render(canvas: Canvas) {
        let fillStyle = FillStyle(color: Color(.floralwhite))
        let strokeStyle = StrokeStyle(color: Color(.darkgray))
        let bigBoiSqr = Rect(topLeft: Point(x: 100, y: 100), size: Size(width: 450, height: 450))
        let Sqr = Rect(topLeft: Point(x: 110, y: 110), size: Size(width: 100, height: 100))
        clearCanvas(canvas: canvas)
        Board.board(canvas: canvas, biggerSquare: bigBoiSqr, square: Sqr)
        renderLayout(canvas: canvas)
    }
}
