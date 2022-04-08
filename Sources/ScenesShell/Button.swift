import Scenes
import Igis

  /*
           This class is responsible for rendering the background.
   */


class Button : RenderableEntity {

    func button(canvas: Canvas) {
        if let canvasSize = canvas.canvasSize {
            let Button = Rect(topLeft: Point(x: canvasSize.center.x - 225, y: canvasSize.center.y - 260), size: Size(width: 75, height: 30))
            let resetButton = Rectangle(rect: Button, fillMode: .fill)
            let resetButtonText = Text(location: Point(x: canvasSize.center.x - 220, y: canvasSize.center.y - 240), text: "New Game")
            resetButtonText.font = "10pt Arial"
            canvas.render(FillStyle(color: Color(red: 143, green: 122, blue: 102)), resetButton, FillStyle(color: Color(red: 251, green: 249, blue: 239)), resetButtonText)
        }
    }
    func onClick(location: Point) {
        
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Button")
    }
    // THE POSITIONS ARRAY WILL BE MOVED TO THE INTERACTION LAYER
    override func render(canvas: Canvas) {
        button(canvas: canvas)
    }
}
