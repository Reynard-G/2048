import Scenes
import Igis

class Win : RenderableEntity {
    func winBackground(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let rect = Rect(topLeft: Point(x: canvasSize.center.x - 225, y: canvasSize.center.x), size: Size(width: 450, height: 450))
            let rectangle = Rectangle(rect: rect, fillMode: .fill)
            canvas.render(FillStyle(color: Color(red:237, green:194, blue:45)), Alpha(alphaValue: 0.6), rectangle)
            let gameOver = Text(location: Point(x: canvasSize.center.x, y: canvasSize.center.y - 25), text: "You Win!")
            canvas.render(FillStyle(color: Color(red: 118, green: 111, blue: 101)), gameOver)
        }
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Win")
    }
    override func render(canvas: Canvas) {
        winBackground(canvas: canvas)
    }
}
