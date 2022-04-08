import Scenes
import Igis

  /*
        This class is responsible for rendering the background.
   */


class Score : RenderableEntity {

    func renderScore(canvas: Canvas, score: Int) {
        if let canvasSize = canvas.canvasSize {
            let scoreText = Text(location: Point(x: canvasSize.center.x + 75, y: canvasSize.center.y - 235), text: " Score: \(String(score))")
            scoreText.font = "20pt Clear-Sans"
            canvas.render(scoreText)
        }
    }
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Score")
    }
    // THE POSITIONS ARRAY WILL BE MOVED TO THE INTERACTION LAYER
    override func render(canvas: Canvas) {
        renderScore(canvas: canvas, score: score)
    }
}
