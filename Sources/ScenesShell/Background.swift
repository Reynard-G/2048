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
        /*guard let doodooURL = URL(string: "https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg") else {
            fatalError("Failed to create URL for doodoo")
        }*/
        doodoo = Audio(sourceURL: URL(string: "https://codermerlin.com/users/reynard-gunawan/dreamrunning_trim-1.mp3")!, shouldLoop: true)
        super.init(name:"Background")
    }
    override func setup(canvasSize: Size, canvas: Canvas) {
        let bigBoiSqr = Rect(topLeft: Point(x: canvasSize.center.x - 225, y: canvasSize.center.x - 225), size: Size(width: 450, height: 450))
        let Sqr = Rect(topLeft: Point(x: canvasSize.center.x - 215, y: canvasSize.center.x - 215), size: Size(width: 100, height: 100))
        background(canvas: canvas)
        board(canvas: canvas, canvasSize: canvasSize, biggerSquare: bigBoiSqr, square: Sqr)
        canvas.setup(doodoo)
    }
    override func render(canvas: Canvas) {
        if (isBackgroundPlaying == false) && doodoo.isReady == true {
            canvas.render(doodoo)
            isBackgroundPlaying = true
        }
    }
}
