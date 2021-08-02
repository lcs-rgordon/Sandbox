//
//  ContentView.swift
//  Sandbox
//
//  Created by Russell Gordon on 2021-08-02.
//

import SwiftUI

func test() {
    // Swift compiler will silently do this CGFloat(first)
    let first: CGFloat = 42
    let second: Double = 19
    let result = Double(first) + second
    print(result)
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
