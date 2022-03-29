import Scenes
import Igis

  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */

class InteractionLayer : Layer, KeyDownHandler {
    let Board = Background()
    let numBlock = block(rect: Rect(size: Size(width: 100, height: 100)))
    var positions = Array(repeating: Array(repeating: 0, count: 4), count: 4)
    var offsetX = 110, offsetY = 110
    
    func move(currentMove: String, currentArrow: String, offsetX: inout Int, offsetY: inout Int, positions: inout [[Int]]) {
        // Same concept, just apply to multiple blocks. (Only works as intended for 1 block on the board)
        // W Key
        if currentMove == "w" || currentArrow == "ArrowUp"{
            for i in 0 ..< 4 {
                
            offsetY = 110
            //            positions[i][j] = 0
            }
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
        return chosenSlot
    }
    
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        print(positions)
        if key == "w" || code == "ArrowUp" {
            print("Detected 'w' key!")
            print(generateRandomBlock(positions: positions))
            move(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
        } else if key == "a" || code == "ArrowLeft" {
            print("Detected 'a' key!")
            _ = generateRandomBlock(positions: positions)
            move(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
        } else if key == "s" || code == "ArrowDown" {
            print("Detected 's' key!")
            _ = generateRandomBlock(positions: positions)
            move(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
        } else if key == "d" || code == "ArrowRight" {
            print("Detected 'd' key!")
            _ = generateRandomBlock(positions: positions)
            move(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY, positions: &positions)
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
