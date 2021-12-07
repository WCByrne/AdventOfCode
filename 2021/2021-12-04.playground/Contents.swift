import UIKit


let useExample = false

guard let inputFileUrl = Bundle.main.url(forResource: useExample ? "exampleInput" : "input",
                                         withExtension: "txt") else {
    print("Error")
    abort()
}
//guard let inputFileUrl = Bundle.main.url(forResource: "input", withExtension: "txt") else {
//    print("Error")
//    abort()
//}
let inputString = try! String(contentsOf: inputFileUrl)
var data = inputString
    .split(separator: "\n")

let calledNumbers = data.removeFirst()
    .split(separator: ",")
    .map { Int($0)! }



class Board: CustomDebugStringConvertible {
    let rows: [[Int]]
    let columns: [[Int]]
    
    init(data: [String]) {
        print(data)
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
        return self.rows.map { row in
            return row.map { String($0) }
            .map { $0.count < 2 ? " \($0)" : $0 }
            .joined(separator:  " ")
        }.joined(separator: "\n")
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
print("The boards -------")
print(boards
        .map { $0.debugDescription }
        .joined(separator: "\n\n")
)

func part1() {
    print("Part 1 -------")
    var verifySet = Set<Int>()
    for num in calledNumbers {
        verifySet.insert(num)
        print("Called numbers: \(verifySet)")
        for board in boards {
            let score = board.verify(with: verifySet)
            if score > 0  {
                print(board)
                print("Winner: \(score)")
                print(score * num)
                return
            }
        }
    }
}
part1()


func part2() {
    print("Part 2 -------")
    var remainingBoards = boards
    
    var verifySet = Set<Int>()
    for num in calledNumbers {
        verifySet.insert(num)
        if remainingBoards.count > 1 {
            print("Called numbers: \(verifySet)")
            remainingBoards.removeAll { $0.isComplete(with: verifySet) }
        }
        
        
        if remainingBoards.count == 1 {
            let board = remainingBoards[0]
            let score = board.verify(with: verifySet)
            if score > 0  {
                print(board)
                print("Last winner: \(score)")
                print(score * num)
                return
            }
        } else if remainingBoards.isEmpty {
            print("Something went wrong....")
            return
        }
    }
}
part2()