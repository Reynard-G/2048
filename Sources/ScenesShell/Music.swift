import Scenes
import Igis
import Foundation

class Music : RenderableEntity {

    var doodoodoodoo : Audio
    var rickroll : Audio
    var geico : Audio
    var isRickrollPlaying = false
    var isGeicoPlaying = false

    // Set the URLs for music
    init() {
        doodoodoodoo = Audio(sourceURL: URL(string: "https://codermerlin.com/users/reynard-gunawan/Dream%20Speedrun%20Music.mp3")!, shouldLoop: true)
        rickroll = Audio(sourceURL: URL(string: "https://codermerlin.com/users/reynard-gunawan/Rickroll.mp3")!, shouldLoop: true)
        geico = Audio(sourceURL: URL(string: "https://codermerlin.com/users/reynard-gunawan/geico.mp3")!, shouldLoop: true)

        doodoodoodoo.mode = .play
        rickroll.mode = .pause
        geico.mode = .pause
        super.init(name:"Music")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        canvas.setup(doodoodoodoo, rickroll, geico)
        canvas.render(doodoodoodoo)
    }

    // Play music according to when the player has won/loss
    override func render(canvas: Canvas) {
        guard let layer = layer as? InteractionLayer else {
            fatalError("Failed to get InteractionLayer")
        }

        // Play Rickroll when player loses
        if layer.isLost == true && isRickrollPlaying == false {
            doodoodoodoo.mode = .pause
            rickroll.mode = .play
            isRickrollPlaying = true
            isGeicoPlaying = false
            canvas.render(doodoodoodoo, rickroll)
        }

        // Play Geico Commercial when player wins
        if layer.isWon == true && isGeicoPlaying == false {
            doodoodoodoo.mode = .pause
            geico.mode = .play
            isGeicoPlaying = true
            isRickrollPlaying = false
            canvas.render(doodoodoodoo, geico)
        }

        // Play DooDoo after reset button is pressed
        if (layer.isLost == false && layer.isWon == false) && (isRickrollPlaying || isGeicoPlaying) {
            rickroll.mode = .pause
            geico.mode = .pause
            doodoodoodoo.mode = .play
            isRickrollPlaying = false
            isGeicoPlaying = false
            canvas.render(doodoodoodoo, rickroll, geico)
        }
    }
}
