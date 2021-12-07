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


func simulate(days: Int) {
    
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
    print("Fish after \(days) days: \(count)")
}

simulate(days: 80)
simulate(days: 256)
