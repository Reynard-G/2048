import Scenes
import Igis

  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity {
    func board(canvas: Canvas, biggerSquare: Rect, square: Rect) {
        var currentRect = square
        let bigBoiSquare = Rectangle(rect: biggerSquare, fillMode: .fill)
        var Square = Rectangle(rect: square, fillMode: .fill)
        canvas.render(FillStyle(color: Color(red: 186, green: 173, blue: 161)), bigBoiSquare)
        for _ in 0 ..< 4 {
            for _ in 0 ..< 4 {
                Square = Rectangle(rect: currentRect, fillMode: .fill)
                canvas.render(FillStyle(color: Color(red: 205, green: 192, blue: 181)), Square)
                currentRect.topLeft.x += currentRect.size.width + 10 // Make a space of 10 units between squares horizontally
            }
            currentRect.topLeft.y += currentRect.size.height + 10 // Make a space of 10 units between squares vertically
            currentRect.topLeft.x = 110 // Reset x position and render the next row
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
      // THE POSITIONS ARRAY WILL BE MOVED TO THE INTERACTION LAYER
      override func setup(canvasSize: Size, canvas: Canvas) {
          let bigBoiSqr = Rect(topLeft: Point(x: 100, y: 100), size: Size(width: 450, height: 450))
          let Sqr = Rect(topLeft: Point(x: 110, y: 110), size: Size(width: 100, height: 100))
          background(canvas: canvas)
          board(canvas: canvas, biggerSquare: bigBoiSqr, square: Sqr)
      }
}
