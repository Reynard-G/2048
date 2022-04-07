import Scenes
import Igis

  /*
           This class is responsible for rendering the background.
   */


class RenderBlocks : RenderableEntity {
    func clearCanvas(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }
    func getCoords(coord: String, index: Double) -> Double {
        if coord == "x" {
            let column = index.truncatingRemainder(dividingBy: 4.0)
            return (column * 110.0) + 110.0
        } else if coord == "y" {
            var row: Double = Double(index) / 4.0
            row.round(.down)
            return (row * 110.0) + 110.0
        } else {
            fatalError("The only acceptable 'coord' inputs are `x` & `y`.")
        }
    }
    // Create a function here to find where the blocks are suppose to render
    func Blocks(canvas: Canvas, value: Int, x: Double, y: Double) {
        let rect = Rect(topLeft: Point(x: Int(x), y: Int(y)), size: Size(width: 100, height: 100))
        let Block = Rectangle(rect: rect, fillMode: .fill)
        switch(value) {
        case 2:
            // Design/render blocks here
            let Block2Text = Text(location: Point(x: Int(x) + 38, y: Int(y) + 68), text: "2")
            Block2Text.font = "40pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 239, green: 229, blue: 218)), Block, FillStyle(color: Color(red: 119, green: 110, blue: 101)), Block2Text)
            break;
        case 4:
            let Block4Text = Text(location: Point(x: Int(x) + 38, y: Int(y) + 68), text: "4")
            Block4Text.font = "40pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 239, green: 224, blue: 201)), Block, FillStyle(color: Color(red: 119, green: 110, blue: 101)), Block4Text)
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
                Blocks(canvas: canvas, value: 2, x: getCoords(coord: "x", index: Double(i)), y: getCoords(coord: "y", index: Double(i)))
                break;
            case 4:
                Blocks(canvas: canvas, value: 4, x: getCoords(coord: "x", index: Double(i)), y: getCoords(coord: "y", index: Double(i)))
                break;
            case 8:
                Blocks(canvas: canvas, value: 8, x: getCoords(coord: "x", index: Double(i)), y: getCoords(coord: "y", index: Double(i)))
                break;
            case 16:
                Blocks(canvas: canvas, value: 16, x: getCoords(coord: "x", index: Double(i)), y: getCoords(coord: "y", index: Double(i)))
                break;
            case 32:
                Blocks(canvas: canvas, value: 32, x: getCoords(coord: "x", index: Double(i)), y: getCoords(coord: "y", index: Double(i)))
                break;
            case 64:
                Blocks(canvas: canvas, value: 64, x: getCoords(coord: "x", index: Double(i)), y: getCoords(coord: "y", index: Double(i)))
                break;
            case 128:
                Blocks(canvas: canvas, value: 128, x: getCoords(coord: "x", index: Double(i)), y: getCoords(coord: "y", index: Double(i)))
                break;
            case 256:
                Blocks(canvas: canvas, value: 256, x: getCoords(coord: "x", index: Double(i)), y: getCoords(coord: "y", index: Double(i)))
                break;
            case 512:
                Blocks(canvas: canvas, value: 512, x: getCoords(coord: "x", index: Double(i)), y: getCoords(coord: "y", index: Double(i)))
                break;
            case 1024:
                Blocks(canvas: canvas, value: 1024, x: getCoords(coord: "x", index: Double(i)), y: getCoords(coord: "y", index: Double(i)))
                break;
            case 2048:
                Blocks(canvas: canvas, value: 2048, x: getCoords(coord: "x", index: Double(i)), y: getCoords(coord: "y", index: Double(i)))
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
        let bigBoiSqr = Rect(topLeft: Point(x: 100, y: 100), size: Size(width: 450, height: 450))
        let Sqr = Rect(topLeft: Point(x: 110, y: 110), size: Size(width: 100, height: 100))
        clearCanvas(canvas: canvas)
        let Board = Background()
        Board.background(canvas: canvas)
        Board.board(canvas: canvas, biggerSquare: bigBoiSqr, square: Sqr)
        renderLayout(canvas: canvas)
    }
}
