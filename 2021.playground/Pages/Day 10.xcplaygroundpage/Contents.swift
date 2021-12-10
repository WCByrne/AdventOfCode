import Foundation
import AOCUtils
/*:
 # Day 10
 [https://adventofcode.com/2021/day/10](https://adventofcode.com/2021/day/10)
 */
let data = try! loadData(example: false)
    .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    .split(separator: "\n")

let characters = [
    "(": ")",
    "[": "]",
    "{": "}",
    "<": ">"
]
let openingCharacters = Set(characters.keys)
let closingCharacters = Set(characters.values)

// MARK: - Part 1
/*-------------------------------------------------------------------------------*/
run(part: 1) {
    let scores = [
        ")": 3,
        "]": 57,
        "}": 1197,
        ">": 25137,
    ]
    let badElements = data.compactMap { line -> String? in
        var openElements = [String]()
        
        for _c in line {
            let c = String(_c)
            if openingCharacters.contains(c) {
                openElements.append(c)
            } else if let last = openElements.last, let closer = characters[last], c == closer {
                openElements.popLast()
            } else {
                return c
            }
        }
        return nil
    }
    print(badElements)
    let result = badElements.reduce(0) { res, element in
        return res + (scores[element] ?? 0)
    }
    return "The result is \(result)"
}


run(part: 2) {
    let scores = [
        ")": 1,
        "]": 2,
        "}": 3,
        ">": 4,
    ]
    let unterminatedLines = data.compactMap { line -> String? in
        var openElements = [String]()
        for _c in line {
            let c = String(_c)
            if openingCharacters.contains(c) {
                openElements.append(c)
            } else if let last = openElements.last, let closer = characters[last], c == closer {
                openElements.popLast()
            } else {
                return nil
            }
        }
        return openElements.reversed().joined()
    }
    let results = unterminatedLines
        .map { completion in
            completion
                .map { characters[String($0)]! }
                .reduce(0, { ($0 * 5) + scores[String($1)]! })
        }.sorted()
    
    let result = results[Int(results.count / 2)]
    return "The result is \(result)"
}
