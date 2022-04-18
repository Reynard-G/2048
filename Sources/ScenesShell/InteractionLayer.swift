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
    let displayLose = Lose()
    let displayWin = Win()
    let clearAlpha = resetAlpha()    

    func generateRandomBlock(positions: inout [Int]) {
        let randNum : Int = Int.random(in: 0 ..< 16)
        let randPercent : Int = Int.random(in: 1 ... 10)
        if positions[randNum] == 0 {
            if randPercent == 10 {
                positions[randNum] = 4
                checkLose(positions: positions)
            } else {
                positions[randNum] = 2
                checkLose(positions: positions)
            }
        } else if positions.contains(where: {$0 == 0}) { // If there is an available space on the board, continue
            generateRandomBlock(positions: &positions)
        }
    }
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
            checkWin(positions: positions)
        }
    }
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
            checkWin(positions: positions)
        }
    }
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
    func checkWin(positions: [Int]) {
        for i in  0 ..< 16 {
            if positions[i] == 2048 {
                insert(entity: displayWin, at: .front)
                dispatcher.unregisterKeyDownHandler(handler: self)
            }
        }
    }
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
            insert(entity: displayLose, at: .front)
        }
    }
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        if key == "w" || code == "ArrowUp" {
            let prevPos = positions
            moveUp(positions: &positions) // Check if it will be the same positions
            combineColumnUp(positions: &positions)
            moveUp(positions: &positions)
            let currPos = positions
            if prevPos != currPos {
                generateRandomBlock(positions: &positions)
            }
        } else if key == "a" || code == "ArrowLeft" {
            let prevPos = positions
            moveLeft(positions: &positions) // Check if it will be the same positions
            combineRowLeft(positions: &positions)
            moveLeft(positions: &positions)
            let currPos = positions
            if prevPos != currPos {
                generateRandomBlock(positions: &positions)
            }
        } else if key == "s" || code == "ArrowDown" {
            let prevPos = positions
            moveDown(positions: &positions) // Check if it will be the same positions
            combineColumnDown(positions: &positions)
            moveDown(positions: &positions)
            let currPos = positions
            if prevPos != currPos {
                generateRandomBlock(positions: &positions)
            }
        } else if key == "d" || code == "ArrowRight" {
            let prevPos = positions
            moveRight(positions: &positions) // Check if it will be the same positions
            combineRowRight(positions: &positions)
            moveRight(positions: &positions)
            let currPos = positions
            if prevPos != currPos {
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
    func resetButtonClickHandler(control: Control, localLocation: Point) {
        remove(entity: displayLose)
        remove(entity: displayWin)
        insert(entity: clearAlpha, at: .front)
        dispatcher.unregisterKeyDownHandler(handler: self) // Unregister KeyDownHandler if it's already registered
        dispatcher.registerKeyDownHandler(handler: self)
        resetbutton().pressedButton()
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        // We insert our RenderableEntities in the constructor
        insert(entity: renderAll, at: .front)
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
