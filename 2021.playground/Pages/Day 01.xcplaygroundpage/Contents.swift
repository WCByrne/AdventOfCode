import Foundation
import AOCUtils
/*:
 # Day 1
 [https://adventofcode.com/2021/day/1](https://adventofcode.com/2021/day/1)
*/
let inputString = try! loadData(example: false)
let data = inputString
    .split(separator: "\n")
    .map { Int($0)! }

func numIncreases(values: [Int]) -> Int {
    var count = 0
    var prev: Int?
    for v in values {
        if let p = prev, v > p { count += 1 }
        prev = v
    }
    return count
}

run(part: 1) {
    let overallIncreases = numIncreases(values: data)
    return "Overall increases: \(overallIncreases)"
}

run(part: 2) {
    var cohorts = [Int]()
    let cohortSize = 3
    var parts: [[Int]] = [[]]
    
    for (_, v) in data.enumerated() {
        for i in 0..<parts.count {
            parts[i].append(v)
        }
        if parts[0].count == cohortSize {
            let newCohort = parts.removeFirst().reduce(0, +)
            cohorts.append(newCohort)
        }
        if parts.count < 3 {
            parts.append([])
        }
    }
    let cohortIncreases = numIncreases(values: cohorts)
    return "Overall increases: \(cohortIncreases)"
}
