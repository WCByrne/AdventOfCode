import Foundation
import QuartzCore
import AOCUtils
/*:
 # Day 7
 [https://adventofcode.com/2021/day/7](https://adventofcode.com/2021/day/7)
 */
let data = try! loadData(example: false)
    .split(separator: ",")
    .map { $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    .compactMap { Int($0) }

let lowerBound = data.min()!
let upperBound = data.max()!
let range = lowerBound...upperBound

run(part: 1) {
    
    func cost(target: Int) -> Int {
        return data
            .map { abs($0 - target) }
            .reduce(0, +)
    }
    
    let lowestCost = range
        .lazy
        .map { ($0, cost(target: $0)) }
        .min { $0.1 < $1.1 }!
    
    return "The most efficient position is \(lowestCost.0) which will consume \(lowestCost.1) fuel"
}

run(part: 2) {
    var costCache = [Int:Int]()
    
    func cost(for moves: Int) -> Int {
        if (moves == 0) { return 0 }
        if let c = costCache[moves] {
            return c
        } else {
            let c = (1...moves).reduce(0, +)
            costCache[moves] = c
            return c
        }
    }
    
    let time = CACurrentMediaTime()
    let lowestCost = range.lazy.map { target -> (Int, Int) in
        let cost = data
            .lazy
            .map { abs($0 - target) }
            .map { cost(for: $0) }
            .reduce(0, +)
        return (target, cost)
    }.min { $0.1 < $1.1 }!
    
    print(CACurrentMediaTime() - time)
    
    return "The most efficient position is \(lowestCost.0) which will consume \(lowestCost.1) fuel"
}

