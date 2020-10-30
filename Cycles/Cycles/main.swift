//
//  main.swift
//  Cycles
//
//  Created by Vlad Vrublevsky on 30.10.2020.
//

import Foundation

var first_node: Int = 0
var global_cycles: [[Int]] = []

print("Started")

func tree(start_node: Int, matrix: [[Int]], level_tree: Int = 0, memory_of_forgetting: [Int] = []) {
    let level_of_tree = level_tree +  1
    
    var mem_forget = [Int]()
    if level_of_tree != 1 { mem_forget = memory_of_forgetting }
    
    if level_of_tree > 2 {
        mem_forget.removeAll(where: { $0 == first_node })
    }
    
    mem_forget.append(start_node)
    
    let nodes = matrix[start_node - 1] // change this
    
    for (num, element) in nodes.enumerated() {
        if element != 0 {
            if (mem_forget.contains(num+1) == false) && (num+1 == first_node) {
                mem_forget.append(first_node)
                mem_forget.sort()
                global_cycles.append(mem_forget)
            } else if (mem_forget.contains(num + 1) == false) {
                tree(start_node: num+1, matrix: matrix, level_tree: level_of_tree, memory_of_forgetting: mem_forget)
            }
        }
    }
}

func main() {
    guard let N = Int(readLine() ?? "") else { fatalError("N is not Int") }
    var matrix: [[Int]] = []
    for _ in 0..<N {
        let splited = (readLine() ?? "").split(separator: " ").map({ Int($0)! })
        matrix.append(splited)
    }
    
    print("Matrix:")
    print("----------")
    for str in matrix {
        print(str)
    }
    print("----------")
    
    
    for i in 1...N {
        first_node = i
        tree(start_node: i, matrix: matrix)
    }
    
    let cycles = Set(global_cycles)
    //print("CG \(global_cycles)")
    //print("Cycles: \(cycles)")
    print("Cycles count: \(cycles.count)")
}

main()
