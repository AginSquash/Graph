//
//  main.swift
//  Graph
//
//  Created by Vlad Vrublevsky on 08.12.2020.
//

import Foundation

var _start_node = 0
var total_cyclecs = [[Int]]()

func addBeatyEnter(n: Int = 2) {
    for _ in 0..<n {
        print()
    }
}

func tree( startNode: Int, matrix: [[Int]], levelOfTree: Int = 0, toForget: [Int] = [Int]() ) {
    var lvl = levelOfTree + 1
    
    var newForget = toForget
    if lvl == 1 {
        newForget.removeAll()
    }
    
    if lvl > 2 {
        newForget.removeAll(where: { $0 == _start_node })
    }
    
    newForget.removeAll(where: { $0 == 0 })
    
    newForget.append(startNode)
    
    var nodes = matrix[startNode-1]
    
    for (i, element) in nodes.enumerated() {
        if element != 0 {
            if (!newForget.contains(i+1)) && ( i+1 == _start_node ) {
                newForget.append(_start_node)
                newForget.sort()
                total_cyclecs.append(newForget)
            } else if !newForget.contains(i+1) {
                tree(startNode: i+1, matrix: matrix, levelOfTree: lvl, toForget: newForget)
            }
        }
        
        
    }
}

func main() {
    print("Enter number of tops:")
    guard var n = Int(readLine()!) else { fatalError("Number must be int!") }

    var matrix = [[Int]]()
    for _ in (0..<n) {
        matrix.append( readLine()!.split(separator: " ").map({ Int($0)! }) )
    }
    
    addBeatyEnter()
    
    print("Graph:")
    for i in 0..<n {
        print(matrix[i])
    }

    addBeatyEnter()
    
    for i in (1..<n+1) {
        _start_node = i
        tree(startNode: i, matrix: matrix)
    }
    
    
    var out = [String]()
    for m in total_cyclecs {
        var yes = ""
        
        for e in m {
            yes += String(e)
        }
        out.append(yes)
    }
    
    let unique_out = Set(out)
    
    print("Cycles count: \(unique_out.count)")
    
}

main()
