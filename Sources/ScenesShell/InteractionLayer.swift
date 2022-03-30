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
    var offsetX = 110, offsetY = 110
    
    func moveCoord(currentMove: String, currentArrow: String, offsetX: inout Int, offsetY: inout Int, positions: inout [Int]) {
        // Same concept, just apply to multiple blocks. (Only works as intended for 1 block on the board)
        // W Key
        if currentMove == "w" || currentArrow == "ArrowUp"{
            offsetY = 110
        } else if currentMove == "a" || currentArrow == "ArrowLeft" {
            offsetX = 110
        } else if currentMove == "s" || currentArrow == "ArrowDown" {
            offsetY = 440
        } else if currentMove == "d" || currentArrow == "ArrowRight" {
            offsetX = 440
        } else {
            // Do nothing here
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
        // This function is meant to be executed at the end once we have done all calculations on block movement (Board.generateBlock, in InteractiveLayer.swift)
        let randNum = Int.random(in: 0 ..< 16)
        let randPercent = Int.random(in: 1 ... 10)
        if positions[randNum] == 0 {
            if randPercent == 10 {
                positions[randNum] = 4
                checkLose(positions: positions)
            } else {
                positions[randNum] = 2
                checkLose(positions: positions)
            }
        } else {
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
                let total1 = positions[i]
                let total2 = positions[i + 1]
                let total3 = positions[i + 2]
                let total4 = positions[i + 3]
                let row = [total1, total2, total3, total4]
                let filteredRow = row.filter({$0 > 0})
                let missing = 4 - filteredRow.count
                let zeros = Array(repeating: 0, count: missing)
                let newRow = zeros + filteredRow
                positions[i] = newRow[0]
                positions[i + 1] = newRow[1]
                positions[i + 2] = newRow[2]
                positions[i + 3] = newRow[3]
                // Doesn't work, troubleshoot filteredRow, etc
            }
        }
    }
    func moveLeft(positions: inout [Int]) {
        for i in 0 ..< positions.count {
            if i % 4 == 0 {
                let total1 = positions[i]
                let total2 = positions[i + 1]
                let total3 = positions[i + 2]
                let total4 = positions[i + 3]
                let row = [total1, total2, total3, total4]
                let filteredRow = row.filter({$0 > 0})
                let missing = 4 - filteredRow.count
                let zeros = Array(repeating: 0, count: missing)
                let newRow = filteredRow + zeros
                positions[i] = newRow[0]
                positions[i + 1] = newRow[1]
                positions[i + 2] = newRow[2]
                positions[i + 3] = newRow[3]
            }
        }
    }
    func combineRow(positions: inout [Int]) {
        for i in 0 ..< 15 {
            if positions[i] == positions[i + 1] {
                let combinedTotal = positions[i] + positions[i + 1]
                positions[i] = combinedTotal
                positions[i + 1] = 0
                // Add score here
                // This works!!!
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
        var availableSpace = 0
        var gameOver = true
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
        if (gameOver == true) && (availableSpace == 0) {
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
            generateRandomBlock(positions: &positions)
            printPos(positions: positions)
        } else if key == "a" || code == "ArrowLeft" {
            print("Detected 'a' key!")
            moveCoord(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
            generateRandomBlock(positions: &positions)
            moveLeft(positions: &positions)
            combineRow(positions: &positions)
            moveLeft(positions: &positions)
            printPos(positions: positions)
        } else if key == "s" || code == "ArrowDown" {
            print("Detected 's' key!")
            moveCoord(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
            generateRandomBlock(positions: &positions)
            printPos(positions: positions)
        } else if key == "d" || code == "ArrowRight" {
            print("Detected 'd' key!")
            moveCoord(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
            moveRight(positions: &positions)
            combineRow(positions: &positions)
            moveRight(positions: &positions)
            generateRandomBlock(positions: &positions)
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
          dispatcher.registerKeyDownHandler(handler: self)
      }
      override func postTeardown() {
          dispatcher.unregisterKeyDownHandler(handler: self)
      }
  }
