import Scenes
import Igis

  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity {
    var positionArr : [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    let fillStyleLightGray = FillStyle(color: Color(.lightgray))
    let fillStyleDarkGray = FillStyle(color: Color(.darkgray))    
    // Make all different types of blocks here
    
    func board(canvas: Canvas, biggerSquare: Rect, square: Rect) {
        var currentRect = square
        let bigBoiSquare = Rectangle(rect: biggerSquare, fillMode: .fill)
        var Square = Rectangle(rect: square, fillMode: .fill)

/*  ARRAY ELEMENT DEFINITIONS
        0 means EMPTY
        2 means 2-block
        4 means 4-block
        8 means 8-block
        16 means 16-block
        32 means 32-block
        64 means 64-block
        128 means 128-block
        (The index of the array represents the POSITION of the block, the value of the index represent what KIND OF BLOCK it is)
*/        
        canvas.render(fillStyleDarkGray, bigBoiSquare)
        for _ in 0 ..< 4 {
            for _ in 0 ..< 4 {
                Square = Rectangle(rect: currentRect, fillMode: .fill)
                canvas.render(fillStyleLightGray, Square)
                currentRect.topLeft.x += currentRect.size.width + 10 // Make a space of 10 units between squares horizontally
            }
            currentRect.topLeft.y += currentRect.size.height + 10 // Make a space of 10 units between squares vertically
            currentRect.topLeft.x = 110 // Reset x position and render the next row
        }
    }
    // Add 
    func generateRandomBlock(positions: [[Int]]) -> Int {
        var availableSlots : [Int] = []
         // This function is meant to be executed at the end once we have done all calculations on block movement (Board.generateBlock, in InteractiveLayer.swift)
        for i in 0 ..< 4 {
            for j in 0 ..< 4 {
                if positions[i][j] == 0 {
                    availableSlots.append((i*10)+j)                      
                 /* Available Slots meaning
                  
                    First Row: [0, 1, 2, 3]
                  Second Row:  [10, 11, 12, 13]
                   Third Row:  [20, 21, 22, 23]
                 Fourth Row:   [30, 31, 32, 33]
                 */
                }
            }
        }
        let chosenSlot = availableSlots.randomElement()!
        return chosenSlot
    }
    // Add a function that can read and change the 'position' array based on key movements
    // Then add another function that can read the 'position' array and display on IGIS
    func positions(canvas: Canvas, positions: [Int]) {
        for i in 0 ..< positions.count {
            if positions[i] == 2 {
                // Need to position these renders
                //canvas.render()
                print()
            } else if positions[i] == 4 {
                //canvas.render()
                print()
            } else if positions[i] == 8 {
                //canvas.render()
                print()
            } else if positions[i] == 16 {
                //canvas.render()
                print("works!")
            } else if positions[i] == 32 {
                //canvas.render()
                print()
            } else if positions[i] == 64 {
                //canvas.render()
                print()
            } else if positions[i] == 128 {
                //canvas.render()
                print()
            } // Contuine till 2048
        }
    }
      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")
      }
      // THE POSITIONS ARRAY WILL BE MOVED TO THE INTERACTION LAYER
      override func setup(canvasSize: Size, canvas: Canvas) {
          let bigBoiSqr = Rect(topLeft: Point(x: 100, y: 100), size: Size(width: 450, height: 450))
          let Sqr = Rect(topLeft: Point(x: 110, y: 110), size: Size(width: 100, height: 100))
          board(canvas: canvas, biggerSquare: bigBoiSqr, square: Sqr)
      }
}
