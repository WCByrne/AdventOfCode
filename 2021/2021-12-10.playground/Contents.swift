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

// MARK: - Part 1
/*-------------------------------------------------------------------------------*/
func part1() {
    print("Part 2 ----")
    
    let result = 0
    print("The result is \(result)")
}
part1()

// MARK: - Part 1
/*-------------------------------------------------------------------------------*/
func part2() {
    print("Part 2 ----")
    
    let result = 0
    print("The result is \(result)")
}
part2()
