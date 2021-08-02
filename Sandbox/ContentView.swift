//
//  ContentView.swift
//  Sandbox
//
//  Created by Russell Gordon on 2021-08-02.
//

import SwiftUI

struct User: Identifiable {
    let id = UUID()
    let name: String
    var isContacted = false
}

struct ContentView: View {
    @State private var users = [
        User(name: "Taylor"),
        User(name: "Austin"),
        User(name: "Adele"),
    ]
    
    var body: some View {
        List($users) { $user in
            HStack {
                Text(user.name)
                Spacer()
                Toggle("Users has been contacted",
                       isOn: $user.isContacted)
                    .labelsHidden()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
