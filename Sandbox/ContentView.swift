//
//  ContentView.swift
//  Sandbox
//
//  Created by Russell Gordon on 2021-08-02.
//

import SwiftUI

func test() {
    let names = ["Keely", "Roy", "Ted"]
    // Member of names, postfix (afterward)
    // Can now use release vs. debug # modifiers
    let selected = names
    #if DEBUG
        .first
    #else
        .randomElement()
    #endif
    print(selected ?? "Anonymous")
}

struct ContentView: View {
    var body: some View {
        Text("Hello world")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
