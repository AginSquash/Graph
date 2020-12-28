//
//  main.swift
//  Graph
//
//  Created by Vlad Vrublevsky on 08.12.2020.
//


// Написать программу, считающую количество простых циклов в графе.

import Foundation

var first_node = 0
var total_cyclecs = [[Int]]()

func addBeatyEnter(n: Int = 2) {
    for _ in 0..<n {
        print()
    }
}

func tree( startNode: Int, matrix: [[Int]], treeLevel: Int = 0, allreadyPassedPath: [Int] = [Int]() ) {
    
    var newPassedPath = allreadyPassedPath
    if treeLevel == 0 {
        newPassedPath.removeAll()
    }
        
    if treeLevel > 1 {
        newPassedPath.removeAll(where: { $0 == first_node })
    }
    
    let newTreeLevel = treeLevel + 1
    
    newPassedPath.append(startNode)
    
    let nodes = matrix[startNode-1]
    
    for (i, element) in nodes.enumerated() {
        if element != 0 {
            if (!newPassedPath.contains(i+1)) && ( i+1 == first_node ) {
                newPassedPath.append(first_node)
                newPassedPath.sort()
                total_cyclecs.append(newPassedPath)
            } else if !newPassedPath.contains(i+1) {
                tree(startNode: i+1, matrix: matrix, treeLevel: newTreeLevel, allreadyPassedPath: newPassedPath)
            }
        }
        
        
    }
}

func main() {
    print("Enter number of tops:")
    /*
    guard var n = Int(readLine()!) else { fatalError("Number must be int!") }

    var matrix = [[Int]]()
    for _ in (0..<n) {
        matrix.append( readLine()!.split(separator: " ").map({ Int($0)! }) )
    }
    */
    
    let n = 6
    let matrix: [[Int]] = [[0, 1, 1, 1, 0, 0],
                          [1, 0, 0, 1, 1, 0],
                          [1, 0, 0, 1, 0, 1],
                          [1, 1, 1, 0, 1, 1],
                          [0, 1, 0, 1, 0, 0],
                          [0, 0, 1, 1, 0, 0]]

    
    /*
    let matrix: [[Int]] = [[0, 1, 0, 1, 0, 0],
                          [0, 0, 0, 0, 1, 0],
                          [1, 0, 0, 1, 0, 0],
                          [0, 1, 0, 0, 1, 0],
                          [0, 0, 0, 0, 0, 0],
                          [0, 0, 1, 1, 0, 0]]
    */
    
    
    addBeatyEnter()
    
    print("Graph:")
    for i in 0..<n {
        print(matrix[i])
    }

    addBeatyEnter()
    
    for i in (1..<n+1) {
        first_node = i
        tree(startNode: i, matrix: matrix)
    }
    
    
    var out = [String]()
    for m in total_cyclecs {
        var finalString = ""
        for e in m {
            finalString += String(e)
        }
        out.append(finalString)
    }
    
    let unique_out = Set(out)
    
    print("Cycles count: \(unique_out.count)")
    
}

main()
