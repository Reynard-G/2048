import Scenes
import Igis
import ScenesAnimations

class Title : RenderableEntity {

    var title = Text(location: Point(x: 0, y: 0), text: "")
    var ease : EasingStyle
    var text : String

    init(ease: EasingStyle, text: String) {
        self.ease = ease
        self.text = text
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Title")
    }
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        title = Text(location: Point(x: canvasSize.center.x, y: canvasSize.center.y - 300), text: "\(text)")
        title.font = "50pt Roboto"
        let fromPoint = Point(x: title.location.x - 170, y: title.location.y)
        let toPoint = Point(x: title.location.x + 170, y: title.location.y)
        let tween = Tween(from:fromPoint, to:toPoint, duration:1.5, ease:ease, update: {self.title.location = $0})
        tween.repeatStyle = .forever
        tween.direction = .alternate

        animationController.register(animation: tween)
        tween.play()

    }

    override func render(canvas: Canvas) {
        canvas.render(FillStyle(color: Color(red: 119, green: 110, blue: 101)), title)
    }
}
