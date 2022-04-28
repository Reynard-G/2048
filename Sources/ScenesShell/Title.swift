import Scenes
import Igis
import ScenesAnimations

class Title : RenderableEntity {
    var title = Text(location: Point(x: 0, y: 0), text: "")
    var ease : EasingStyle

    init(ease: EasingStyle) {
        self.ease = ease
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Title")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        title = Text(location: Point(x: canvasSize.center.x, y: canvasSize.center.y - 300), text: "2048")
        title.font = "50pt Roboto"
        let fromPoint = Point(x: title.location.x - 220, y: title.location.y)
        let toPoint = Point(x: title.location.x + 220, y: title.location.y)
        let tween = Tween(from:fromPoint, to:toPoint, duration:1.5, ease:ease, update: {self.title.location = $0})
        tween.repeatStyle = .forever
        tween.direction = .alternate

        animationController.register(animation: tween)
        tween.play()
    }
    override func render(canvas: Canvas) {
        canvas.render(title)
    }
}
