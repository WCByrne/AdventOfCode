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

func part1() {
    let overallIncreases = numIncreases(values: data)
    print("Overall increases: \(overallIncreases)")
}
part1()

func part2() {
    var cohorts = [Int]()
    let cohortSize = 3
    var parts: [[Int]] = [[]]
    
    for (_, v) in data.enumerated() {
        for i in 0..<parts.count {
            parts[i].append(v)
        }
        print(parts)
        if parts[0].count == cohortSize {
            let full = parts.removeFirst()
            let newCohort = full.reduce(0) { res, val in
                return res + val
            }
            
            cohorts.append(newCohort)
        }
        if parts.count < 3 {
            parts.append([])
        }
    }
    let cohortIncreases = numIncreases(values: cohorts)
    print("Overall increases: \(cohortIncreases)")
}
part2()
