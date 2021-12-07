//
//  utilities.swift
//  AdventOfCode
//
//  Created by Wes Byrne on 12/7/21.
//

import Foundation

public func loadData(example: Bool) throws -> String {
    let resourceName = example ? "exampleInput" : "input"
    guard let inputFileUrl = Bundle.main.url(forResource: resourceName, withExtension: "txt") else {
        print("Unable to load resource named \(resourceName)")
        abort()
    }
    return try String(contentsOf: inputFileUrl)
}
