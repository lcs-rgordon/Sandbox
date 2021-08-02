//
//  ContentView.swift
//  Sandbox
//
//  Created by Russell Gordon on 2021-08-02.
//

import SwiftUI


func fibonacci(of number: Int) -> Int {
    var first = 0
    var second = 1
    for _ in 0..<number {
        let previous = first
        first = second
        second = previous + first
    }
    return first
}

func printFibonacci(of number: Int, allowAbsolute: Bool = false) {
    
    // Will only run the next line when it's needed; an efficiency tweak
    lazy var result = fibonacci(of: abs(number))
    if number < 0 {
        if allowAbsolute {
            print("The result for \(abs(number)) is \(result)")
        } else {
            print("That's not a valid number in the sequence.")
        }
    } else {
        print("The result for \(number) is \(result)")
    }
    
}

func test() {
    print(fibonacci(of: 7))
}

struct ContentView: View {
    
    var body: some View {
        Text("Hello world!")
            .onAppear {
                test()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
