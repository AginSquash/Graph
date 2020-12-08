//
//  main.swift
//  Graph
//
//  Created by Vlad Vrublevsky on 08.12.2020.
//

import Foundation

var first_start_node = 0
var global_cyclecs = [[Int]]()

func addBeatyEnter(n: Int = 2) {
    for _ in 0..<n {
        print()
    }
}

func tree( startNode: Int, matrix: [[Int]], levelOfTree: Int = 0, memory_of_forgetting: [Int] = [Int]() ) {
    var lvl = levelOfTree + 1
    
    var newMoM = memory_of_forgetting
    if lvl == 1 {
        newMoM.removeAll()
    }
    
    if lvl > 2 {
        newMoM.removeAll(where: { $0 == first_start_node })
    }
    
    newMoM.removeAll(where: { $0 == 0 })
    
    newMoM.append(startNode)
    
    var nodes = matrix[startNode-1]
    
    for (i, element) in nodes.enumerated() {
        if element != 0 {
            if (!newMoM.contains(i+1)) && ( i+1 == first_start_node ) {
                newMoM.append(first_start_node)
                newMoM.sort()
                global_cyclecs.append(newMoM)
            } else if !newMoM.contains(i+1) {
                tree(startNode: i+1, matrix: matrix, levelOfTree: lvl, memory_of_forgetting: newMoM)
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
        first_start_node = i
        tree(startNode: i, matrix: matrix)
    }
    
    //print("CG: \(global_cyclecs)")
    
    var out = [String]()
    for m in global_cyclecs {
        var yes = ""
        
        for e in m {
            yes += String(e)
        }
        out.append(yes)
    }
    
    //print(out)
    let unique_out = Set(out)
    
    print("Cycles count: \(unique_out.count)")
    
}

main()
