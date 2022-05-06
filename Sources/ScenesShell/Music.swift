import Scenes
import Igis
import Foundation

class Music : RenderableEntity {

    var doodoodoodoo : Audio
    var rickroll : Audio
    var geico : Audio
    var isRickrollPlaying = false
    var isGeicoPlaying = false
    
    init() {
        doodoodoodoo = Audio(sourceURL: URL(string: "https://codermerlin.com/users/reynard-gunawan/Dream%20Speedrun%20Music.mp3")!, shouldLoop: true)
        rickroll = Audio(sourceURL: URL(string: "https://codermerlin.com/users/reynard-gunawan/Rickroll.mp3")!, shouldLoop: true)
        geico = Audio(sourceURL: URL(string: "https://codermerlin.com/users/reynard-gunawan/geico.mp3")!, shouldLoop: true)
        
        super.init(name:"Music")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        canvas.setup(doodoodoodoo, rickroll, geico)
        canvas.render(doodoodoodoo)
    }
    
    override func render(canvas: Canvas) {
        guard let layer = layer as? InteractionLayer else {
            fatalError("Failed to get InteractionLayer")
        }

        // Play Rickroll when player loses
        if layer.isLost == true && isRickrollPlaying == false {
            isRickrollPlaying = true
            doodoodoodoo.mode = .pause
            rickroll.mode = .play
            canvas.render(doodoodoodoo, rickroll)
        }

        // Play Geico Commercial when player wins
        if layer.isWon == true && isGeicoPlaying == false {
            isGeicoPlaying = true
            doodoodoodoo.mode = .pause
            geico.mode = .play
            canvas.render(doodoodoodoo, geico)
        }
        
        // Play DooDoo after reset button is pressed
        if layer.isLost == false && isRickrollPlaying == true {
            rickroll.mode = .pause
            doodoodoodoo.mode = .play
            isRickrollPlaying = false
            canvas.render(doodoodoodoo, rickroll)
        }
    }
}
