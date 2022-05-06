import Scenes
import Igis
import Foundation

  /*
        This class is responsible for rendering the background.
   */

class Background : RenderableEntity {

    // Setup a 4x4 Board
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

    // Peach Background
    func background(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft: Point(), size: canvasSize)
            let canvasRectangle = Rectangle(rect: canvasRect, fillMode: .fill)
            canvas.render(FillStyle(color: Color(red: 251, green: 249, blue: 239)), canvasRectangle)
        }
    }
    
    init() {
        // Dream Speedrun Music
        super.init(name:"Background")
    }
}
