import UIKit
import AOCUtils
/*:
 # Day 2
 [https://adventofcode.com/2021/day/2](https://adventofcode.com/2021/day/2)
 */
let data = try! loadData(example: false)
    .split(separator: "\n")
    .filter { !$0.isEmpty }

enum Direction: String {
    case forward, up, down
}

struct Move: CustomDebugStringConvertible {
    let direction: Direction
    let distance: Int
    
    var debugDescription: String {
        return "\(direction) - \(distance)"
    }
}

let moves: [Move] = data.map {
    let parts = $0.split(separator: " ").map { String($0) }
    return Move(direction: Direction(rawValue: parts[0])!,
        distance: Int(parts[1])!)
}

// part 1
func part1() {
    var depth = 0
    var position = 0
    
    for m in moves {
        switch m.direction {
        case .forward: position += m.distance
        case .up: depth -= m.distance
        case .down: depth += m.distance
        }
    }
    
    print("depth \(depth)")
    print("position \(position)")
    print("answer \(depth * position)")
}
part1()

func part2() {
    var depth = 0
    var aim = 0
    var position = 0

    for m in moves {
        switch m.direction {
        case .forward:
            position += m.distance
            depth += aim * m.distance
        case .up: aim -= m.distance
        case .down: aim += m.distance
        }
    }

    print("depth \(depth)")
    print("position \(position)")
    print("answer \(depth * position)")
}
part2()
