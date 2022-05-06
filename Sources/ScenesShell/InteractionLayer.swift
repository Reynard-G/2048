import Scenes
import Igis
import ScenesControls
import Foundation

  /*
        This class is responsible for the interaction Layer.
        Internally, it maintains the RenderableEntities for this layer.
   */

public var positions : [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
public var score : Int = 0

class InteractionLayer : Layer, KeyDownHandler {
    
    let renderAll = Render()
    let displayLoseBackground = LoseBackground()
    let displayLoseText = LoseText()
    let displayWinBackground = WinBackground()
    let displayWinText = WinText()
    let music = Music()
    let clearAlpha = resetAlpha()
    var prevPos : [Int] = []
    var prevScr : Int = 0
    var isLost = false
    
    // Generate a random block on an available slot
    func generateRandomBlock(positions: inout [Int]) {
        var availableSlots : [Int] = []
        let randPercent : Int = Int.random(in: 1 ... 10)

        for i in 0 ..< positions.count { // Get available slots and put their indexes into an array
            if positions[i] == 0 {
                availableSlots.append(i)
            }
        }
        
        let chosenSlot = availableSlots.randomElement()! // Choose a random element in the array
        
        if randPercent == 10 {
            positions[chosenSlot] = 4
            checkLose(positions: positions)
        } else {
            positions[chosenSlot] = 2
            checkLose(positions: positions)
        }
    }
    
    // Shift the blocks over to the right
    func moveRight(positions: inout [Int]) {
        for i in 0 ..< positions.count {
            if i % 4 == 0 {
                let total1 : Int = positions[i]
                let total2 : Int = positions[i + 1]
                let total3 : Int = positions[i + 2]
                let total4 : Int = positions[i + 3]
                let row : [Int] = [total1, total2, total3, total4]
                let filteredRow : [Int] = row.filter({$0 > 0})
                let missing : Int = 4 - filteredRow.count
                let zeros : [Int] = Array(repeating: 0, count: missing)
                let newRow : [Int] = zeros + filteredRow
                positions[i] = newRow[0]
                positions[i + 1] = newRow[1]
                positions[i + 2] = newRow[2]
                positions[i + 3] = newRow[3]
            }
        }
    }
    
    // Shift the blocks over to the left
    func moveLeft(positions: inout [Int]) {
        for i in 0 ..< positions.count {
            if i % 4 == 0 {
                let total1 : Int = positions[i]
                let total2 : Int = positions[i + 1]
                let total3 : Int = positions[i + 2]
                let total4 : Int = positions[i + 3]
                let row : [Int] = [total1, total2, total3, total4]
                let filteredRow : [Int] = row.filter({$0 > 0})
                let missing : Int = 4 - filteredRow.count
                let zeros : [Int] = Array(repeating: 0, count: missing)
                let newRow : [Int] = filteredRow + zeros
                positions[i] = newRow[0]
                positions[i + 1] = newRow[1]
                positions[i + 2] = newRow[2]
                positions[i + 3] = newRow[3]
            }
        }
    }
    
    // Shift blocks upwards
    func moveUp(positions: inout [Int]) {
        for i in 0 ..< 4 {
            let total1 : Int = positions[i]
            let total2 : Int = positions[i + 4]
            let total3 : Int = positions[i + 8]
            let total4 : Int = positions[i + 12]
            let column : [Int] = [total1, total2, total3, total4]
            let filteredColumn : [Int] = column.filter({$0 > 0})
            let missing : Int = 4 - filteredColumn.count
            let zeros : [Int] = Array(repeating: 0, count: missing)
            let newColumn : [Int] = filteredColumn + zeros
            positions[i] = newColumn[0]
            positions[i + 4] = newColumn[1]
            positions[i + 8] = newColumn[2]
            positions[i + 12] = newColumn[3]
        }
    }
    
    // Shift blocks downwards
    func moveDown(positions: inout [Int]) {
        for i in 0 ..< 4 {
            let total1 : Int = positions[i]
            let total2 : Int = positions[i + 4]
            let total3 : Int = positions[i + 8]
            let total4 : Int = positions[i + 12]
            let column : [Int] = [total1, total2, total3, total4]
            let filteredColumn : [Int] = column.filter({$0 > 0})
            let missing : Int = 4 - filteredColumn.count
            let zeros : [Int] = Array(repeating: 0, count: missing)
            let newColumn : [Int] = zeros + filteredColumn
            positions[i] = newColumn[0]
            positions[i + 4] = newColumn[1]
            positions[i + 8] = newColumn[2]
            positions[i + 12] = newColumn[3]
        }
    }
    
    // Combine viable blocks to the left
    func combineRowLeft(positions: inout [Int]) {
        for i in 1 ..< 16 {
            if (i != 4 && i != 8 && i != 12) { // Prevents combining from other rows
                if positions[i] == positions[i - 1] {
                    let combinedTotal : Int = positions[i] + positions[i - 1]
                    positions[i] = 0
                    positions[i - 1] = combinedTotal
                    score += combinedTotal
                }
            }
        }
        checkWin(positions: positions)
    }
    
    // Combine viable blocks to the right
    func combineRowRight(positions: inout [Int]) {
        for i in (0 ..< 15).reversed() {
            if (i != 11 && i != 7 && i != 3) { // Prevents combining from other rows
                if positions[i] == positions[i + 1] {
                    let combinedTotal : Int = positions[i] + positions[i + 1]
                    positions[i] = 0
                    positions[i + 1] = combinedTotal
                    score += combinedTotal
                }
            }
        }
        checkWin(positions: positions)
    }
    
    // Combine viable blocks upwards
    func combineColumnUp(positions: inout [Int]) {
        for i in 0 ..< 12 {
            if positions[i] == positions[i + 4] {
                let combinedTotal : Int = positions[i] + positions[i + 4]
                    positions[i] = combinedTotal
                    positions[i + 4] = 0
                    score += combinedTotal
            }
        }
        checkWin(positions: positions)
    }
    
    // Combine viable blocks downwards
    func combineColumnDown(positions: inout [Int]) {
        for i in (0 ..< 12).reversed() {
            if positions[i] == positions[i + 4] {
                let combinedTotal : Int = positions[i] + positions[i + 4]
                positions[i] = 0
                positions[i + 4] = combinedTotal
                score += combinedTotal
            }
        }
        checkWin(positions: positions)
    }
    
    // Check if any blocks on the board are "2048"
    func checkWin(positions: [Int]) {
        for i in  0 ..< 16 {
            if positions[i] == 2048 {
                insert(entity: displayWinBackground, at: .front)
                insert(entity: displayWinText, at: .front)
            }
        }
    }
    
    // Check if you are able to combine any blocks on the board and if there is any space left
    func checkLose(positions: [Int]) {
        var availableSpace : Int = 0
        var gameOver : Bool = true
        for i in 0 ..< positions.count {
            if positions[i] == 0 {
                availableSpace += 1
            }
        }
        // Combine Row Right Check
        for i in 0 ..< 15 {
            if (i != 11 && i != 7 && i != 3) {
                if positions[i] == positions[i + 1] {
                    gameOver = false
                }
            }
        }
        // Combine Row Left Check
        for i in 1 ..< 16 {
            if (i != 4 && i != 8 && i != 12) {
                if positions[i] == positions[i - 1] {
                    gameOver = false
                }
            }
        }
        // Combine Column Down Check
        for i in 0 ..< 12 {
            if positions[i] == positions[i + 4] {
                gameOver = false
            }
        }
        // Combine Column Up Check
        for i in 4 ..< 16 {
            if positions[i] == positions[i - 4] {
                gameOver = false
            }
        }
        if gameOver == true && availableSpace == 0 {
            isLost = true
            insert(entity: displayLoseBackground, at: .front)
            insert(entity: displayLoseText, at: .front)
        }
    }
    
    // Listen to key presses and react accordingly
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        if key == "w" || code == "ArrowUp" {
            prevPos = positions
            prevScr = score
            moveUp(positions: &positions) // Check if it will be the same positions
            combineColumnUp(positions: &positions)
            moveUp(positions: &positions)
            let currPos = positions
            if prevPos != currPos {
                undobutton().prevPosition = prevPos
                undobutton().prevScore = prevScr
                generateRandomBlock(positions: &positions)
            }
        } else if key == "a" || code == "ArrowLeft" {
            prevPos = positions
            prevScr = score
            moveLeft(positions: &positions) // Check if it will be the same positions
            combineRowLeft(positions: &positions)
            moveLeft(positions: &positions)
            let currPos = positions
            if prevPos != currPos {
                undobutton().prevPosition = prevPos
                undobutton().prevScore = prevScr
                generateRandomBlock(positions: &positions)
            }
        } else if key == "s" || code == "ArrowDown" {
            prevPos = positions
            prevScr = score
            moveDown(positions: &positions) // Check if it will be the same positions
            combineColumnDown(positions: &positions)
            moveDown(positions: &positions)
            let currPos = positions
            if prevPos != currPos {
                undobutton().prevPosition = prevPos
                undobutton().prevScore = prevScr
                generateRandomBlock(positions: &positions)
            }
        } else if key == "d" || code == "ArrowRight" {
            prevPos = positions
            prevScr = score
            moveRight(positions: &positions) // Check if it will be the same positions
            combineRowRight(positions: &positions)
            moveRight(positions: &positions)
            let currPos = positions
            if prevPos != currPos {
                undobutton().prevPosition = prevPos
                undobutton().prevScore = prevScr
                generateRandomBlock(positions: &positions)
            }
        }
    }
    
    func resetbutton() -> ResetButton {
        guard let mainScene = scene as? MainScene else {
            fatalError("mainScene of type MainScene is required")
        }
        let backgroundLayer = mainScene.backgroundLayer
        let ResetButton = backgroundLayer.resetButton
        return ResetButton
    }
    
    func undobutton() -> UndoButton {
        guard let mainScene = scene as? MainScene else {
            fatalError("mainScene of type MainScene is required")
        }
        let backgroundLayer = mainScene.backgroundLayer
        let UndoButton = backgroundLayer.undoButton
        return UndoButton
    }
    
    // When the resetButton is pressed, execute
    func resetButtonClickHandler(control: Control, localLocation: Point) {
        isLost = false
        remove(entity: displayLoseBackground)
        remove(entity: displayLoseText)
        remove(entity: displayWinBackground)
        remove(entity: displayWinText)
        insert(entity: clearAlpha, at: .front)
        dispatcher.unregisterKeyDownHandler(handler: self) // Unregister KeyDownHandler if it's already registered
        dispatcher.registerKeyDownHandler(handler: self)
        resetbutton().pressedButton()
    }
    
    // When the undoButton is pressed, execute
    func undoButtonClickHandler(control: Control, localLocation: Point) {
        isLost = false
        remove(entity: displayLoseBackground)
        remove(entity: displayLoseText)
        remove(entity: displayWinBackground)
        remove(entity: displayWinText)
        insert(entity: clearAlpha, at: .front)
        dispatcher.unregisterKeyDownHandler(handler: self) // Unregister KeyDownHandler if it's already registered
        dispatcher.registerKeyDownHandler(handler: self)
        undobutton().pressedButton()
    }

    init() {
        super.init(name:"Interaction")
        
        insert(entity: renderAll, at: .back)
        insert(entity: music, at: .front)
        if positions.allSatisfy({$0 == 0}) { // If all of elements of positions is 0, continue
            generateRandomBlock(positions: &positions)
            generateRandomBlock(positions: &positions)
        }
    }
    
    override func preSetup(canvasSize: Size, canvas: Canvas) {
        let resetButton = Button(name: "resetButton", labelString: "New Game", topLeft: Point(x: canvasSize.center.x - 225, y: canvasSize.center.y - 257), fixedSize: Size(width: 120, height: 30),
                                 controlStyle: ControlStyle(foregroundStrokeStyle: StrokeStyle(color: Color(red: 251, green: 249, blue: 239)),
                                                            backgroundFillStyle: FillStyle(color: Color(red: 143, green: 122, blue: 102)),
                                                            backgroundHoverFillStyle: FillStyle(color: Color(red: 143, green: 122, blue: 102)),
                                                            roundingPercentage: 0.0))
        resetButton.clickHandler = resetButtonClickHandler
        insert(entity: resetButton, at: .front)
        let undoButton = Button(name: "undoButton", labelString: "Undo", topLeft: Point(x: canvasSize.center.x - 103, y: canvasSize.center.y - 257), fixedSize: Size(width: 60, height: 30),
                                controlStyle: ControlStyle(foregroundStrokeStyle: StrokeStyle(color: Color(red: 251, green: 249, blue: 239)),
                                                           backgroundFillStyle: FillStyle(color: Color(red: 143, green: 122, blue: 102)),
                                                           backgroundHoverFillStyle: FillStyle(color: Color(red: 143, green: 122, blue: 102)),
                                                           roundingPercentage: 0.0))
        undoButton.clickHandler = undoButtonClickHandler
        insert(entity: undoButton, at: .front)
        dispatcher.registerKeyDownHandler(handler: self)
    }
    
    override func postSetup(canvasSize: Size, canvas: Canvas) {
        checkWin(positions: positions)
        checkLose(positions: positions)
    }
    
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
}
