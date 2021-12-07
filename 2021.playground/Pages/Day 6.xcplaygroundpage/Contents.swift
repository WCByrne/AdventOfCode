import UIKit
import AOCUtils
/*:
 # Day 6
 [https://adventofcode.com/2021/day/6](https://adventofcode.com/2021/day/6)
 */
let data = try! loadData(example: false)
    .split(separator: ",")
    .map { $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    .compactMap { Int($0) }

func fishAfter(days: Int) -> String {
    var generations = data.reduce(into: [Int:Int](), { res, age in
        res[age] = (res[age] ?? 0) + 1
    })
    
    for _ in 0..<days {
        let reset = generations[0] ?? 0
        let newFish = reset
        var nextGen = [Int:Int]()
        for age in generations.keys where age > 0 {
            nextGen[age - 1] = generations[age]
        }
        nextGen[6] = (nextGen[6] ?? 0) + reset
        nextGen[8] = newFish
        generations = nextGen
    }
    
    let count = generations.values.reduce(0) { res, count in
        return res + count
    }
    return "Fish after \(days) days: \(count)"
}


run(part: 1) { fishAfter(days: 80) }
run(part: 2) { fishAfter(days: 256) }

