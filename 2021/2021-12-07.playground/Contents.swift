import UIKit

let useExample = false
guard let inputFileUrl = Bundle.main.url(forResource: useExample ? "exampleInput" : "input",
                                         withExtension: "txt") else {
    print("Error")
    abort()
}

let inputString = try! String(contentsOf: inputFileUrl)
var data = inputString
    .split(separator: ",")
    .map { $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    .compactMap { Int($0) }

// 343441
func part1() {
    print("Part 1 ----")
    
    
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
    
    print("The most efficient position is \(lowestConsumption.0) which will consume \(lowestConsumption.1) fuel")
}
part1()


//98925151
func part2() {
    print("Part 2 ----")
    
    
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
    
    print("The most efficient position is \(lowestConsumption.0) which will consume \(lowestConsumption.1) fuel")
}
part2()
