import Scenes
import Igis
import Foundation

class Blocks : RenderableEntity {

    func clearCanvas(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }
    func getCoords(canvas: Canvas, coord: String, index: Double) -> Double {
        // Convert the index f the array to canvas coordinates
        if let canvasSize = canvas.canvasSize {
            if coord == "x" {
                let column = index.truncatingRemainder(dividingBy: 4.0)
                return (column * 110.0) + (Double(canvasSize.center.x) - 215)
            } else if coord == "y" {
                var row: Double = Double(index) / 4.0
                row.round(.down)
                return (row * 110.0) + (Double(canvasSize.center.y - 215))
            } else {
                fatalError("The only acceptable 'coord' inputs are `x` & `y`.")
            }
        }
        return 0.0 // Will never reach this unless "coord" is not "x" or "y", which will be a mistake.
    }
    func renderBlock(canvas: Canvas, value: Int, x: Double, y: Double) {
        // "Database" of blocks that will be rendered
        let rect = Rect(topLeft: Point(x: Int(x), y: Int(y)), size: Size(width: 100, height: 100))
        let Block = Rectangle(rect: rect, fillMode: .fill)

        switch(value) {
        case 2:
            let Block2Text = Text(location: Point(x: Int(x) + 50, y: Int(y) + 67), text: "2")
            Block2Text.font = "40pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 239, green: 229, blue: 218)), Block, FillStyle(color: Color(red: 119, green: 111, blue: 100)), Block2Text)
            break;
        case 4:
            let Block4Text = Text(location: Point(x: Int(x) + 50, y: Int(y) + 67), text: "4")
            Block4Text.font = "40pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 238, green: 225, blue: 201)), Block, FillStyle(color: Color(red: 119, green: 111, blue: 100)), Block4Text)
            break;
        case 8:
            let Block8Text = Text(location: Point(x: Int(x) + 50, y: Int(y) + 67), text: "8")
            Block8Text.font = "40pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 242, green: 179, blue: 122)), Block, FillStyle(color: Color(red: 249, green: 247, blue: 243)), Block8Text)
            break;
        case 16:
            let Block16Text = Text(location: Point(x: Int(x) + 48, y: Int(y) + 67), text: "16")
            Block16Text.font = "40pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 246, green: 151, blue: 101)), Block, FillStyle(color: Color(red: 249, green: 247, blue: 243)), Block16Text)
            break;
        case 32:
            let Block32Text = Text(location: Point(x: Int(x) + 50, y: Int(y) + 67), text: "32")
            Block32Text.font = "40pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 247, green: 125, blue: 94)), Block, FillStyle(color: Color(red: 249, green: 247, blue: 243)), Block32Text)
            break;
        case 64:
            let Block64Text = Text(location: Point(x: Int(x) + 50, y: Int(y) + 67), text: "64")
            Block64Text.font = "40pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 247, green: 95, blue: 59)), Block, FillStyle(color: Color(red: 249, green: 247, blue: 243)), Block64Text)
            break;
        case 128:
            let Block128Text = Text(location: Point(x: Int(x) + 48, y: Int(y) + 67), text: "128")
            Block128Text.font = "40pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 237, green: 208, blue: 115)), Block, FillStyle(color: Color(red: 249, green: 247, blue: 243)), Block128Text)
            break;
        case 256:
            let Block256Text = Text(location: Point(x: Int(x) + 50, y: Int(y) + 67), text: "256")
            Block256Text.font = "40pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 236, green: 204, blue: 97)), Block, FillStyle(color: Color(red: 249, green: 247, blue: 243)), Block256Text)
            break;
        case 512:
            let Block512Text = Text(location: Point(x: Int(x) + 48, y: Int(y) + 67), text: "512")
            Block512Text.font = "40pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 237, green: 199, blue: 81)), Block, FillStyle(color: Color(red: 249, green: 247, blue: 243)), Block512Text)
            break;
        case 1024:
            let Block1024Text = Text(location: Point(x: Int(x) + 48, y: Int(y) + 65), text: "1028")
            Block1024Text.font = "30pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 237, green: 197, blue: 63)), Block, FillStyle(color: Color(red: 249, green: 247, blue: 243)), Block1024Text)
            break;
        case 2048:
            let Block2048Text = Text(location: Point(x: Int(x) + 50, y: Int(y) + 65), text: "2048")
            Block2048Text.font = "30pt Clear-Sans"
            canvas.render(FillStyle(color: Color(red: 236, green: 195, blue: 49)), Block, FillStyle(color: Color(red: 249, green: 247, blue: 243)), Block2048Text)
            break;
        default:
            print("They went over 2048???")
            break;
        }
    }
    func renderLayout(canvas: Canvas) {
        // Loop 16 times throughout the array and render in the approriate variables from the function.
        for i in 0 ..< positions.count {
            switch(positions[i]) {
            case 0:
                // Leave this alone
                break;
            case 2:
                renderBlock(canvas: canvas, value: 2, x: getCoords(canvas: canvas, coord: "x", index: Double(i)), y: getCoords(canvas: canvas, coord: "y", index: Double(i)))
                break;
            case 4:
                renderBlock(canvas: canvas, value: 4, x: getCoords(canvas: canvas, coord: "x", index: Double(i)), y: getCoords(canvas: canvas, coord: "y", index: Double(i)))
                break;
            case 8:
                renderBlock(canvas: canvas, value: 8, x: getCoords(canvas: canvas, coord: "x", index: Double(i)), y: getCoords(canvas: canvas, coord: "y", index: Double(i)))
                break;
            case 16:
                renderBlock(canvas: canvas, value: 16, x: getCoords(canvas: canvas, coord: "x", index: Double(i)), y: getCoords(canvas: canvas, coord: "y", index: Double(i)))
                break;
            case 32:
                renderBlock(canvas: canvas, value: 32, x: getCoords(canvas: canvas, coord: "x", index: Double(i)), y: getCoords(canvas: canvas, coord: "y", index: Double(i)))
                break;
            case 64:
                renderBlock(canvas: canvas, value: 64, x: getCoords(canvas: canvas, coord: "x", index: Double(i)), y: getCoords(canvas: canvas, coord: "y", index: Double(i)))
                break;
            case 128:
                renderBlock(canvas: canvas, value: 128, x: getCoords(canvas: canvas, coord: "x", index: Double(i)), y: getCoords(canvas: canvas, coord: "y", index: Double(i)))
                break;
            case 256:
                renderBlock(canvas: canvas, value: 256, x: getCoords(canvas: canvas, coord: "x", index: Double(i)), y: getCoords(canvas: canvas, coord: "y", index: Double(i)))
                break;
            case 512:
                renderBlock(canvas: canvas, value: 512, x: getCoords(canvas: canvas, coord: "x", index: Double(i)), y: getCoords(canvas: canvas, coord: "y", index: Double(i)))
                break;
            case 1024:
                renderBlock(canvas: canvas, value: 1024, x: getCoords(canvas: canvas, coord: "x", index: Double(i)), y: getCoords(canvas: canvas, coord: "y", index: Double(i)))
                break;
            case 2048:
                renderBlock(canvas: canvas, value: 2048, x: getCoords(canvas: canvas, coord: "x", index: Double(i)), y: getCoords(canvas: canvas, coord: "y", index: Double(i)))
                break;
            default:
                print("This was not suppose to happen...")
            }
        }
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Blocks")
        
    }
}
