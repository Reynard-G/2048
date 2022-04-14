import Scenes
import Igis

class Score : RenderableEntity {

    func renderScore(canvas: Canvas, score: Int) {
        if let canvasSize = canvas.canvasSize {
            let scoreText = Text(location: Point(x: canvasSize.center.x + 140, y: canvasSize.center.y - 233), text: " Score: \(String(score))")
            scoreText.font = "20pt Clear-Sans"
            scoreText.alignment = .center
            let scorerect = Rect(topLeft: Point(x: canvasSize.center.x + 55, y: canvasSize.center.y - 257), size: Size(width: 170, height: 30))
            let scoreRect = Rectangle(rect: scorerect, fillMode: .fill)
            canvas.render(FillStyle(color: Color(red: 143, green: 122, blue: 102)), scoreRect, FillStyle(color: Color(.white)), scoreText)
        }
    }
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Score")
    }
    override func render(canvas: Canvas) {
        renderScore(canvas: canvas, score: score)
    }
}
