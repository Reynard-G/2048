import Scenes
import Igis
import Foundation

  /*
        This class is responsible for rendering the background.
   */


class Background : RenderableEntity {

    var doodoo : Audio
    var isBackgroundPlaying = false
    
    func board(canvas: Canvas, canvasSize: Size, biggerSquare: Rect, square: Rect) {
        // Setup 4x4 Board
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
        // Peach Background
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft: Point(), size: canvasSize)
            let canvasRectangle = Rectangle(rect: canvasRect, fillMode: .fill)
            canvas.render(FillStyle(color: Color(red: 251, green: 249, blue: 239)), canvasRectangle)
        }
    }

    init() {
        // Dream Speedrun Music
        doodoo = Audio(sourceURL: URL(string: "https://codermerlin.com/users/reynard-gunawan/Dream%20Speedrun%20Music.mp3")!, shouldLoop: true)
        super.init(name:"Background")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        canvas.setup(doodoo)
    }

    override func render(canvas: Canvas) {
        if (isBackgroundPlaying == false) && doodoo.isReady == true {
            canvas.render(doodoo)
            isBackgroundPlaying = true
        }
    }
}
