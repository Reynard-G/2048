import Scenes
import Igis
import Foundation

  /*
        This class is responsible for the interaction Layer.
        Internally, it maintains the RenderableEntities for this layer.
   */

class InteractionLayer : Layer, KeyDownHandler {
    let Board = Background()
    let numBlock = block(rect: Rect(size: Size(width: 100, height: 100)))
    var positions : [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var offsetX : Int = 110, offsetY : Int = 110

    func moveCoord(currentMove: String, currentArrow: String, offsetX: inout Int, offsetY: inout Int, positions: inout [Int]) {
        for i in 0 ..< 16 {
            
        }
    }
    /*    func updateArr(positions: [[Int]], value: Int, offsetX: Int, offsetY: Int) {
                  i = offsetY / 110
                          j = offsetX / 110
                                  i -= 1 // Make it so it doesn't go outside of the array
                                          j -= 1
                                                  positions[i][j] = value
                                                  }*/

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
        /*func coordToArr(positions: [[Int]], x: Int, y: Int) -> (Int, Int) {
                  var xCoord = x, yCoord = y
                          var i : Int, j : Int
                                  i = (yCoord / 110) - 1
                                          j = (xCoord / 110) - 1
                                                  return (i, j)
                                                  }*/
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
        for i in 0 ..< 15 {
            if positions[i] == positions[i + 1] {
                let combinedTotal : Int = positions[i] + positions[i + 1]
                positions[i] = combinedTotal
                positions[i + 1] = 0
                // Add score here
            }
        }
        checkWin(positions: positions)
    }
    func combineRowRight(positions: inout [Int]) {
        for i in (0 ..< 15).reversed() {
            if positions[i] == positions[i + 1] {
                let combinedTotal : Int = positions[i] + positions[i + 1]
                positions[i] = 0
                positions[i + 1] = combinedTotal
            }
        }
    }
    func combineColumnUp(positions: inout [Int]) {
        for i in 0 ..< 12 {
            if positions[i] == positions[i + 4] {
                let combinedTotal : Int = positions[i] + positions[i + 4]
                    positions[i] = combinedTotal
                    positions[i + 4] = 0
                    // Add score here
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
            }
        }
        checkWin(positions: positions)
    }
    func checkWin(positions: [Int]) {
        for i in  0 ..< 16 {
            if positions[i] == 2048 {
                // Add a "You Win" sign here
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
        // Combine Row Check
        for i in 0 ..< 15 {
            if positions[i] == positions[i + 1] {
                gameOver = false
            }
        }
        // Combine Column Check
        for i in 0 ..< 12 {
            if positions[i] == positions[i + 4] {
                gameOver = false
            }
        }
        if gameOver && availableSpace == 0 {
            // Add a "You Lose" sign here
            dispatcher.unregisterKeyDownHandler(handler: self)
        }
    }
    func printPos(positions: [Int]) {
        print("[", positions[0], ",", positions[1], ",", positions[2], ",", positions[3], "]")
        print("[", positions[4], ",", positions[5], ",", positions[6], ",", positions[7], "]")
        print("[", positions[8], ",", positions[9], ",", positions[10], ",", positions[11], "]")
        print("[", positions[12], ",", positions[13], ",", positions[14], ",", positions[15], "]")
    }
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        if key == "w" || code == "ArrowUp" {
            print("Detected 'w' key!")
            moveCoord(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
            let prevPos = positions
            moveUp(positions: &positions) // Check if it will be the same positions
            //moveUp(positions: &positions)
            combineColumnUp(positions: &positions)
            let currPos = positions
            moveUp(positions: &positions)
            if prevPos != currPos {
                generateRandomBlock(positions: &positions)
            }
            printPos(positions: positions)
        } else if key == "a" || code == "ArrowLeft" {
            print("Detected 'a' key!")
            moveCoord(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
            let prevPos = positions
            moveLeft(positions: &positions) // Check if it will be the same positions
            //moveLeft(positions: &positions)
            combineRowLeft(positions: &positions)
            let currPos = positions
            moveLeft(positions: &positions)
            if prevPos != currPos {
                generateRandomBlock(positions: &positions)
            }
            printPos(positions: positions)
        } else if key == "s" || code == "ArrowDown" {
            print("Detected 's' key!")
            moveCoord(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
            let prevPos = positions
            moveDown(positions: &positions) // Check if it will be the same positions
           // moveDown(positions: &positions)
            combineColumnDown(positions: &positions)
            let currPos = positions
            moveDown(positions: &positions)
            if prevPos != currPos {
                generateRandomBlock(positions: &positions)
            }
            printPos(positions: positions)
        } else if key == "d" || code == "ArrowRight" {
            print("Detected 'd' key!")
            moveCoord(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
            let prevPos = positions
            moveRight(positions: &positions) // Check if it will be the same positions
            //moveRight(positions: &positions)
            combineRowRight(positions: &positions)
            let currPos = positions
            moveRight(positions: &positions)
            if prevPos != currPos {
                generateRandomBlock(positions: &positions)
            }
            printPos(positions: positions)
        } else {
            print("Detected an unusable key!")
        }
        insert(entity: numBlock, at: .front)
    }
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        // We insert our RenderableEntities in the constructor
    }
    override func preSetup(canvasSize: Size, canvas: Canvas) {
        generateRandomBlock(positions: &positions)
        generateRandomBlock(positions: &positions)
        dispatcher.registerKeyDownHandler(handler: self)
    }
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
}
