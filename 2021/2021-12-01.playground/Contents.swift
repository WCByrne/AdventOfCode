import Foundation
guard let inputFileUrl = Bundle.main.url(forResource: "input", withExtension: "txt") else {
    print("Error")
    abort()
}
let inputString = try! String(contentsOf: inputFileUrl)
let data = inputString
    .split(separator: "\n")
    .map { Int($0)! }

print(data)
func numIncreases(values: [Int]) -> Int {
    var count = 0
    var prev: Int?
    for v in values {
        if let p = prev, v > p { count += 1 }
        prev = v
    }
    return count
}

let overallIncreases = numIncreases(values: data)
print("Overall increases: \(overallIncreases)")


var cohorts = [Int]()
var cohortSize = 3
var parts: [[Int]] = [[]]

for (idx, v) in data.enumerated() {
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

print(cohorts)
let cohortIncreases = numIncreases(values: cohorts)
print("Overall increases: \(cohortIncreases)")
