import Foundation
import AOCUtils
/*:
 # Day 8
 [https://adventofcode.com/2021/day/8](https://adventofcode.com/2021/day/8)
 */
typealias DataSet = (codes: [String], output: [String])

func parse(input: String) -> DataSet {
    let components = input.split(separator: "|")
    let codes = components[0]
        .split(separator: " ")
        .map(String.init)
    let output = components[1]
        .split(separator: " ")
        .map(String.init)
    return (codes: codes, output: output)
}

let data = try! loadData(example: false)
    .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    .split(separator: "\n")
    .filter { !$0.isEmpty }
    .map { parse(input: String($0)) }


let knownCounts = [
    7: 8,
    4: 4,
    3: 7,
    2: 1
]

run(part: 1) {
    let allOutput = data.reduce(into: [String]()) {
        $0.append(contentsOf: $1.output)
    }
    let result = allOutput
        .filter { knownCounts[$0.count] != nil }
        .count
    return "The result is \(result)"
}

extension String {
    func join(_ other: String) -> String {
        let new = other.filter { !self.contains($0) }
        return self.appending(new)
    }
    func removing(_ other: String) -> String {
        return self.filter { !other.contains($0) }
    }
    func intersection(_ other: String) -> String {
        return self.filter { other.contains($0) }
    }
    func characterMatch(_ other: String) -> Bool {
        
        return self.count == other.count && !self.contains { !other.contains($0) }
    }
}

run(part: 2) {
    
    func decode(input: DataSet) -> Int {
        
        let one = input.codes.first { $0.count == 2 }!
        let four = input.codes.first { $0.count == 4 }!
        let seven = input.codes.first { $0.count == 3 }!
        let eight = input.codes.first { $0.count == 7 }!
        
        let partialNine =  seven.join(four)
        let nine = input.codes.first { $0.count == 6 && $0.intersection(partialNine).count == 5 }!
        
        let six = input.codes.first { $0.count == nine.count && $0 != nine && $0.intersection(one).count == 1 }!
        let zero = input.codes.first { $0.count == nine.count && $0 != nine && $0.intersection(one).count == 2 }!
        
        let e = eight.removing(nine)
        let c = eight.removing(six)
        let b = four.removing(seven).intersection(zero)
        let f = one.intersection(six)
        
        let five = eight.removing(e).removing(c)
        let three = eight.removing(b).removing(e)
        let two = eight.removing(b).removing(f)
        
        let map = [
            zero,
            one,
            two,
            three,
            four,
            five,
            six,
            seven,
            eight,
            nine,
        ]
        
        let intValues = input.output.map { code -> Int in
            return map.firstIndex { code.characterMatch($0) } ?? 0
        }
        let res = intValues.map(String.init).joined()
        return Int(res)!
    }
    
    let result = data
        .map { decode(input: $0) }
        .reduce(0, +)
    return "The result is \(result)"
}
