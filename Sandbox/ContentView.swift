//
//  ContentView.swift
//  Sandbox
//
//  Created by Russell Gordon on 2021-08-02.
//

import SwiftUI

@propertyWrapper struct Clamped<T: Comparable> {
    let wrappedValue: T
    
    init(wrappedValue: T, range: ClosedRange<T>) {
        self.wrappedValue = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }
}

func setScore1(to score: Int) {
    print("setting score to \(score)")
}

func setScore2(@Clamped(range: 0...100) to score: Int) {
    print("setting score to \(score)")
}

func test() {
    setScore1(to: 50)
    setScore1(to: -50)
    setScore1(to: 500)
    setScore2(to: 50)
    setScore2(to: -50)
    setScore2(to: 500)

}


struct ContentView: View {
    
    var body: some View {
        Text("Hello world!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
