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
    
    func move(currentMove: String, currentArrow: String, offsetX: inout Int, offsetY: inout Int) {
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
    
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        print(positions)
        if key == "w" || code == "ArrowUp" {
            print("Detected 'w' key!")
            insert(entity: numBlock, at: .front)
            let test = Board.generateRandomBlock(positions: positions)
            print(test)
            move(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
        } else if key == "a" || code == "ArrowLeft" {
            print("Detected 'a' key!")
            _ = Board.generateRandomBlock(positions: positions)
            move(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
        } else if key == "s" || code == "ArrowDown" {
            print("Detected 's' key!")
            _ = Board.generateRandomBlock(positions: positions)
            move(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
        } else if key == "d" || code == "ArrowRight" {
            print("Detected 'd' key!")
            _ = Board.generateRandomBlock(positions: positions)
            move(currentMove: key, currentArrow: code, offsetX: &offsetX, offsetY: &offsetY)
            numBlock.move(to: Point(x: offsetX, y: offsetY))
        } else {
            print("Detected an unusable key!")
        }
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
