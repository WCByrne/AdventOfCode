import UIKit
import AOCUtils
/*:
 # Day 4
 [https://adventofcode.com/2021/day/4](https://adventofcode.com/2021/day/4)
 */
class Board: CustomDebugStringConvertible {
    let rows: [[Int]]
    let columns: [[Int]]
    
    init(data: [String]) {
        let rows = data.map { rowInput in
                    rowInput.split(separator: " ")
                        .map { Int($0)! }
        }
        let columns = (0..<rows.count).reduce(into: [[Int]](), { res, idx in
            var col = [Int]()
            for row in rows {
                col.append(row[idx])
            }
            res.append(col)
        })
        self.rows = rows
        self.columns = columns
    }
    
    var debugDescription: String {
        let str = self.rows.map { row in
            return row.map { String($0) }
            .map { $0.count < 2 ? " \($0)" : $0 }
            .joined(separator:  " ")
        }.joined(separator: "\n")
        return "\n--------------\n\(str)\n--------------\n"
    }
    
    func isComplete(with calledNumbers: Set<Int>) -> Bool {
        func containsWinInDataSetForDirection(dataSet: [[Int]]) -> Bool {
            dataSet.contains { row in
                !row.contains { element in !calledNumbers.contains(element) }
            }
        }
        return containsWinInDataSetForDirection(dataSet: self.rows) || containsWinInDataSetForDirection(dataSet: self.columns)
    }
    
    // Returns a positive number of the board has won
    func verify(with calledNumbers: Set<Int>) -> Int {
        guard isComplete(with: calledNumbers) else { return -1 }
        
        return self.rows.reduce(0) { res, row in
            return res + row.reduce(0, { rowResult, element in
                rowResult + (calledNumbers.contains(element) ? 0 : element)
            })
        }
    }
}

var data = try! loadData(example: false)
    .split(separator: "\n")

let calledNumbers = data.removeFirst()
    .split(separator: ",")
    .map { Int($0)! }


func createBoards() -> [Board] {
    var boards = [Board]()
    var previousLines = [String]()
    for line in data {
        // We have a full boarf
        if !line.isEmpty {
            previousLines.append(String(line))
        }
        if previousLines.count == 5 {
            boards.append(Board(data: previousLines))
            previousLines.removeAll()
        }
    }
    return boards
}

var boards = createBoards()

run(part: 1) {
    var verifySet = Set<Int>()
    for num in calledNumbers {
        verifySet.insert(num)
        for board in boards {
            let score = board.verify(with: verifySet)
            if score > 0  {
                print(board)
                print("The winning board had a score of: \(score)")
                print("The last number called was \(num)")
                return "Answer: \(score * num)"
            }
        }
    }
    return "Something went wrong. No board appears to have won"
}

run(part: 2) {
    var remainingBoards = boards
    
    var verifySet = Set<Int>()
    for num in calledNumbers {
        verifySet.insert(num)
        if remainingBoards.count > 1 {
            remainingBoards.removeAll { $0.isComplete(with: verifySet) }
        }
        
        if remainingBoards.count == 1 {
            let board = remainingBoards[0]
            let score = board.verify(with: verifySet)
            if score > 0  {
                print(board)
                print("The winning board had a score of: \(score)")
                print("The last number called was \(num)")
                return "Score: \(score * num)"
            }
        } else if remainingBoards.isEmpty {
            return "Something went wrong...."
        }
    }
    return "Something went wrong. No board appears to have won"
}
