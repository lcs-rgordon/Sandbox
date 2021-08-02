//
//  ContentView.swift
//  Sandbox
//
//  Created by Russell Gordon on 2021-08-02.
//

import SwiftUI

enum Vehicle: Codable {
    case bicycle(electric: Bool)
    case motorbike
    case car(seats: Int)
    case truck(wheels: Int)
}

func test() {
    let traffic: [Vehicle] = [
        .car(seats: 3),
        .bicycle(electric: false),
        .bicycle(electric: true),
        .motorbike
    ]
    
    do {
        let jsonData = try JSONEncoder().encode(traffic)
        let jsonString = String(decoding: jsonData, as: UTF8.self)
        print(jsonString)
    } catch {
        print("Something went wrong")
    }
}

struct ContentView: View {
    
    var body: some View {
        Text("Hello world!")
            .onAppear(perform: test)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
