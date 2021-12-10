import Foundation
import AOCUtils
/*:
 # Day 9
 [https://adventofcode.com/2021/day/9](https://adventofcode.com/2021/day/9)
 */
let data = try! loadData(example: false)
    .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    .split(separator: "\n")
    .map { str in str.map { Int(String($0))! } }

struct Point: Hashable {
    let x: Int
    let y: Int
}

func adjacentPoints(to point: Point) -> [Point] {
    var res = [Point]()
    if point.x > 0 {
        res.append(Point(x: point.x - 1, y: point.y))
    }
    if point.x < data[point.y].count - 1 {
        res.append(Point(x: point.x + 1, y: point.y))
    }
    if point.y > 0 {
        res.append(Point(x: point.x, y: point.y - 1))
    }
    if point.y < data.count - 1 {
        res.append(Point(x: point.x, y: point.y + 1))
    }
    return res
}

func value(at point: Point) -> Int {
    return data[point.y][point.x]
}

let lowPoints = { () -> [Point] in
    var res = [Point]()
    for (yIdx, row) in data.enumerated() {
        for (xIdx, val) in row.enumerated() {
            
            let p = Point(x: xIdx, y: yIdx)
            let adjescentValues = adjacentPoints(to: p).map {
                value(at: $0)
            }
            let isLowest = !adjescentValues.contains { $0 <= val }
            if isLowest {
                res.append(p)
            }
        }
        
    }
    return res
}()


run(part: 1) {
    let result = lowPoints
        .map { value(at: $0) }
        .map { $0 + 1 }
        .reduce(0, +)
    return "The result is \(result)"
}


// MARK: - Part 1
/*-------------------------------------------------------------------------------*/
run(part: 2) {
    var basins = [Int]()
    
    for p in lowPoints {
        var points = Set<Point>()
        func crawl(from p: Point) {
            if points.contains(p) { return }
            if value(at: p) == 9 { return }
            points.insert(p)
            for adj in adjacentPoints(to: p) {
                crawl(from: adj)
            }
        }
        crawl(from: p)
        basins.append(points.count)
    }
    
    let sorted = basins.sorted().reversed()
    print(sorted)
    
    let result = sorted.prefix(3).reduce(1, *)
    return "The result is \(result)"
}


