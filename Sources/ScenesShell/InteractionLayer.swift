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
    var positions = Array(repeating: Array(repeating: 0, count: 4), count: 4)
    var offsetX = 110, offsetY = 110
    
    func moveCoord(currentMove: String, currentArrow: String, offsetX: inout Int, offsetY: inout Int, positions: inout [[Int]]) {
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

    func generateRandomBlock(positions: [[Int]]) -> Int {
        var availableSlots : [Int] = []
        // This function is meant to be executed at the end once we have done all calculations on block movement (Board.generateBlock, in InteractiveLayer.swift)
        for i in 0 ..< 4 {
            for j in 0 ..< 4 {
                if positions[i][j] == 0 {
                    availableSlots.append((i*10)+j)
                     /* Available Slots meaning

                       First Row: [0, 1, 2, 3]
                      Second Row: [10, 11, 12, 13]
                       Third Row: [20, 21, 22, 23]
                      Fourth Row: [30, 31, 32, 33]
                     */
                }
            }
        }
        let chosenSlot = availableSlots.randomElement()!
        let x = chosenSlot % 10 // Find last digit of integer
        let y = Int(chosenSlot / 10) // Find first digit of integer
        print(x, ", ", y)
        //insert(entity: numBlock, at: .front)
        return chosenSlot
    }
    /*func coordToArr(positions: [[Int]], x: Int, y: Int) -> (Int, Int) {
        var xCoord = x, yCoord = y
        var i : Int, j : Int
        i = (yCoord / 110) - 1
        j = (xCoord / 110) - 1
        return (i, j)
        }*/

    func checkWin() {
        for i in  0 ..< 4 {
            for j in 0 ..< 4 {
                if positions[i][j] == 2048 {
                    // Add a "You Win" sign here
                    dispatcher.unregisterKeyDownHandler(handler: self)
                }
            }
        }
    }
    
    func checkLose() {
        var availableSpace = 0
        for i in 0 ..< 4 {
            for j in 0 ..< 4 {
                if positions[i][j] == 0 {
                    availableSpace += 1
                }
            }
        }
        if availableSpace == 0 {
            // Add a "You Lose" sign here
            dispatcher.unregisterKeyDownHandler(handler: self)
        }
    }
    
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        print(positions)
        if key == "w" || code == "ArrowUp" {
            print("Detected 'w' key!")
            moveCoord(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
            print(generateRandomBlock(positions: positions))
        } else if key == "a" || code == "ArrowLeft" {
            print("Detected 'a' key!")
            _ = generateRandomBlock(positions: positions)
            moveCoord(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
        } else if key == "s" || code == "ArrowDown" {
            print("Detected 's' key!")
            _ = generateRandomBlock(positions: positions)
            moveCoord(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
        } else if key == "d" || code == "ArrowRight" {
            print("Detected 'd' key!")
            _ = generateRandomBlock(positions: positions)
            moveCoord(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
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
