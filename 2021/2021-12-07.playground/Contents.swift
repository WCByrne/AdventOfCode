import UIKit
import AOCUtils
/*:
 # Day 7
 [https://adventofcode.com/2021/day/7](https://adventofcode.com/2021/day/7)
 */
let data = try! loadData(example: false)
    .split(separator: ",")
    .map { $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    .compactMap { Int($0) }

run(part: 1) {
    let lowerBound = data.min()!
    let upperBound = data.max()!
    
    var lowestConsumption = (lowerBound, Int.max)
    for target in lowerBound...upperBound {
        
        let consumption = data.reduce(0) { res, startingPosition in
            return res + abs(startingPosition - target)
        }
        if consumption < lowestConsumption.1 {
            lowestConsumption = (target, consumption)
        }
    }
    return "The most efficient position is \(lowestConsumption.0) which will consume \(lowestConsumption.1) fuel"
}

run(part: 2) {
    let lowerBound = data.min()!
    let upperBound = data.max()!
    
    var costCache = [Int:Int]()
    
    var lowestConsumption = (lowerBound, Int.max)
    for target in lowerBound...upperBound {
        
        let consumption = data.reduce(0) { res, startingPosition in
            let delta = abs(startingPosition - target)
            if let c = costCache[delta] {
                return res + c
            } else if delta > 0 {
                let cost = costCache[delta] ?? (1...delta).reduce(0) { partialResult, step in
                    return partialResult + step
                }
                costCache[delta] = cost
                return res + cost
            } else {
                return res
            }
        }
        if consumption < lowestConsumption.1 {
            lowestConsumption = (target, consumption)
        }
    }
    
    return "The most efficient position is \(lowestConsumption.0) which will consume \(lowestConsumption.1) fuel"
}
