//
//  main.swift
//  Graph3
//
//  Created by Vlad Vrublevsky on 19.12.2020.
//

import Foundation

class Graph {
    var n: Int
    var matrix: [Bool]
    var chain: [Int]
    var index_chain: Int

    init(n: Int, matrix: [Bool]) {
        self.n = n
        self.matrix = matrix
        self.index_chain = 0
        self.chain = repeatElement(0, count: n).map( { Int($0) } )
    }
    
    func SearchWay(b: Int, top: Int) -> Bool {
        var k = false
        
        let index = index_chain
        for i in 0..<n {
            if matrix[n*(top - 1) + i] == false {
                print("continue")
                continue
            }
            if ( i+1 == b ) {
                return true
            }
            for j in 0..<index_chain {
                if (i+1 == chain[j]) {
                    k = true
                }
            }
            if (k) {
                k = false
                continue
            }
            chain[index_chain] = i + 1
            index_chain += 1
            if SearchWay(b: b, top: i+1) {
                return true
            }
            index_chain = index
            chain[index] = 0
        }
        return false
    }
    
    func SearchExistWays() {
        var counter: Int = 0
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
                chain[0] = i + 1
                index_chain = 1
                if SearchWay(b: j+1, top: i+1) {
                    array[j] = 0
                }
            }
            array[i] = 0
            counter += 1
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
        print("The number of graph connectivity components: \(counter)")
        
    }
}

func main() {
    print("Enter the number of grapth tops: ")
    guard let n = Int(readLine()!) else { fatalError("Number must be int!") }
    var matrix = [Bool]()
    for _ in (0..<n) {
        matrix.append( contentsOf: readLine()!.split(separator: " ").map({ getBoolByString($0) }) )
    }
    
    for i in 0..<n {
        for j in 0..<n {
            if (matrix[n * i + j] == true) {
                matrix[n * j + i] = matrix[n * i + j];
            }
        }
    }
    
    let graph = Graph(n: n, matrix: matrix)
    graph.SearchExistWays()
}

func getBoolByString(_ s: Substring) -> Bool {
    return s != "0"
}

main()
