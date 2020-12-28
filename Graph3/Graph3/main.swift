//
//  main.swift
//  Graph3
//
//  Created by Vlad Vrublevsky on 19.12.2020.
//

// Написать программу, считающую количество компонент связности в произвольном графе.

import Foundation

class Graph {
    var n: Int
    var matrix: [Bool]
    var founded_chain: [Int]
    var current_index: Int

    init(n: Int, matrix: [Bool]) {
        self.n = n
        self.matrix = matrix
        self.current_index = 0
        self.founded_chain = repeatElement(0, count: n).map( { Int($0) } )
    }
    
    func SearchNewWayWithTop(start: Int, top: Int) -> Bool {
        var isSkipped = false
        
        let index = current_index
        for i in 0..<n {
            if matrix[n*(top - 1) + i] == false {
                continue
            }
            if ( i+1 == start ) {
                return true
            }
            for j in 0..<current_index {
                if (i+1 == founded_chain[j]) {
                    isSkipped = true
                }
            }
            if (isSkipped) {
                isSkipped = false
                continue
            }
            founded_chain[current_index] = i + 1
            current_index += 1
            if SearchNewWayWithTop(start: start, top: i+1) {
                return true
            }
            current_index = index
            founded_chain[index] = 0
        }
        return false
    }
    
    func SearchWays() {
        var connect_count: Int = 0
        var check: Bool = true
        var array: [Int] = [Int]()
        
        for i in 0..<n {
            array.append(i + 1)
        }
        
        for i in 0..<n {
            if array[i] == 0 {
                continue
            }
            for j in 0..<n {
                if (array[j]==0)||(j == i) {
                    continue
                }
                founded_chain[0] = i + 1
                current_index = 1
                if SearchNewWayWithTop(start: j+1, top: i+1) {
                    array[j] = 0
                }
            }
            array[i] = 0
            connect_count += 1
            for j in 0..<n {
                if array[j] != 0 {
                    check = false
                    break
                }
            }
            if check {
                break
            }
        }
        print("Connetcive count: \(connect_count)")
        
    }
}

func main() {
    /*
    print("Enter the number of grapth tops: ")
    guard let n = Int(readLine()!) else { fatalError("Number must be int!") }
    var matrix = [Bool]()
    for _ in (0..<n*2) {
        matrix.append( contentsOf: readLine()!.split(separator: " ").map({ getBoolByString($0) }) )
    }
    */
    let n = 6
    
    let intMatrix = [ 0, 1, 1, 1, 0, 0,
                      1, 0, 0, 1, 1, 0,
                      1, 0, 0, 1, 0, 1,
                      1, 1, 1, 0, 1, 1,
                      0, 1, 0, 1, 0, 0,
                      0, 0, 1, 1, 0, 0]
    /*
     let intMatrix =  [0, 1, 0, 1, 0, 0,
                       0, 0, 0, 0, 1, 0,
                       1, 0, 0, 1, 0, 0,
                       0, 1, 0, 0, 1, 0,
                       0, 0, 0, 0, 0, 0,
                       0, 0, 1, 1, 0, 0]
    */
    
    let matrix = intMatrix.map({ getBoolByInt($0) })
    
    let graph = Graph(n: n, matrix: matrix)
    graph.SearchWays()
}

func getBoolByString(_ s: Substring) -> Bool {
    return s != "0"
}

func getBoolByInt(_ s: Int) -> Bool {
    return s != 0
}

main()
