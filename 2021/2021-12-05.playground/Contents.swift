import UIKit

let useExample = false
guard let inputFileUrl = Bundle.main.url(forResource: useExample ? "exampleInput" : "input",
                                         withExtension: "txt") else {
    print("Error")
    abort()
}

let inputString = try! String(contentsOf: inputFileUrl)
var data = inputString
    .split(separator: "\n")

struct Point: Hashable, CustomDebugStringConvertible {
    let x: Int
    let y: Int
    
    var debugDescription: String {
        return "[\(x),\(y)]"
    }
}

struct Line: CustomDebugStringConvertible {
    var start: Point
    var end: Point
    
    init(string: String) {
        let comps = string.split(separator: " ")
        let p1 = comps[0]
            .split(separator: ",")
            .map { Int($0)! }
        let p2 = comps[2]
            .split(separator: ",")
            .map { Int($0)! }
        
        self.start = Point(x: p1[0], y: p1[1])
        self.end = Point(x: p2[0], y: p2[1])
    }
    var debugDescription: String {
        return "\(start) -> \(end)"
    }
    
    var isDiagonal: Bool {
        return !(start.x == end.x || start.y == end.y)
    }
    
    var points: [Point] {
        if self.start.x == self.end.x {
            let move = [self.start.y, self.end.y].sorted()
            return (move[0]...move[1]).map { Point(x: self.start.x, y: $0) }
        } else if self.start.y == self.end.y {
            let move = [self.start.x, self.end.x].map { Int($0) }.sorted()
             return (move[0]...move[1]).map { Point(x: $0, y: self.start.y) }
        } else {
            let points = start.x > end.x ? [end, start] : [start, end]
            var y = points[0].y
            let yInc = y < points[1].y ? 1 : -1
            let xRange = points[0].x...points[1].x
            
            return xRange.map {
                let p = Point(x: $0, y: y)
                y += yInc
                return p
            }
        }
    }
}

let lines = data.map { Line(string: String($0)) }

func part1() {
    print("Part 1 ---")
    
    var points = [Point: Int]()
    let validLines = lines.filter { !$0.isDiagonal }
    for line in validLines {
        for p in line.points {
            points[p] = (points[p] ?? 0) + 1
        }
    }
    let count = points.values.reduce(0) { partialResult, pointCount in
        return partialResult + (pointCount > 1 ? 1 : 0)
    }
    print("Points with intersections: \(count)")
}
part1()

func part2() {
    print("Part 2 ---")
    var points = [Point: Int]()
    for line in lines {
        for p in line.points {
            points[p] = (points[p] ?? 0) + 1
        }
    }
    let count = points.values.reduce(0) { partialResult, pointCount in
        return partialResult + (pointCount > 1 ? 1 : 0)
    }
    print("Points with intersections: \(count)")
}
part2()

