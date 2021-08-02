//
//  ContentView.swift
//  Sandbox
//
//  Created by Russell Gordon on 2021-08-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Welcome")
        #if os(macOS)
            .font(.largeTitle)
        #else
            .font(.title)
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
