import UIKit
import AOCUtils
/*:
 # Day 3
 [https://adventofcode.com/2021/day/3](https://adventofcode.com/2021/day/3)
 */
let data = try! loadData(example: false)
    .split(separator: "\n")
    .filter { !$0.isEmpty }

func countElements(in array: [Int]) -> [Int: Int] {
    var counts = [Int: Int]()
    for v in array {
        counts[v] = (counts[v] ?? 0) + 1
    }
    return counts
}

func mostComonValue(in array: [Int]) -> Int {
    let counts = countElements(in: array)
    var max: (key: Int, value: Int) = (1, counts[1] ?? 0)
    for (k, v) in counts {
        if v > max.value {
            max = (k, v)
        }
    }
    return max.key
}

func leastCommentValue(in array: [Int]) -> Int {
    let counts = countElements(in: array)
    var max: (key: Int, value: Int) = (0, counts[0] ?? Int.max)
    for (k, v) in counts {
        if v < max.value {
            max = (k, v)
        }
    }
    return max.key
}

func generateColumns(from data: [String]) -> [[Int]] {
    let entryLength = data[0].count
    var columns = [[Int]](repeating: [], count: entryLength)
    for entry in data {
        let numericValues = entry.map { Int(String($0))! }
        for (idx, num) in numericValues.enumerated() {
            columns[idx].append(num)
        }
    }
    return columns
}


func part1() {
    print("Part 1 ----")
    let columns = generateColumns(from: data)
    let gamma = columns.reduce("") { partialResult, col in
        partialResult.appending("\(mostComonValue(in: col))")
    }
    let epsilon = columns.reduce("") { partialResult, col in
        partialResult.appending("\(leastCommentValue(in: col))")
    }
    
    let gInt = Int(gamma, radix: 2)!
    let eInt = Int(epsilon, radix: 2)!
    
    print("\(gamma) - \(gInt)")
    print("\(epsilon) - \(eInt)")
          
    print("Answer: \(gInt * eInt)")
}
part1()

func part2() {
    print("Part 2 ----")
    
    func calculateRating(validator: ([Int]) -> Int) -> String {
        var entries = data
        var idx = 0
        while entries.count > 1 {
            let columns = generateColumns(from: entries)
            let col = columns[idx]
            let validElement = validator(col)
            // Get the index of invalid elements
            let drop = col.enumerated().compactMap { element in
                return element.element == validElement ? nil : element.offset
            }
            for idx in drop.reversed() {
                entries.remove(at: idx)
            }
            idx += 1
        }
        return entries[0]
    }
    
    let o2 = calculateRating { mostComonValue(in: $0) }
    let scrubber = calculateRating { leastCommentValue(in: $0) }
    
    let o2Int = Int(o2, radix: 2)!
    let scrubberInt = Int(scrubber, radix: 2)!
    
    print("\(o2) - \(o2Int)")
    print("\(scrubber) - \(scrubberInt)")
          
    print("Answer: \(o2Int * scrubberInt)")
}

part2()
