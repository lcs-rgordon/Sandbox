//
//  ContentView.swift
//  Sandbox
//
//  Created by Russell Gordon on 2021-08-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Original method for setting toggle style
        Toggle("Example", isOn: .constant(true))
            .toggleStyle(SwitchToggleStyle())
        // New method for setting toggle style – much better
        Toggle("Example", isOn: .constant(true))
            .toggleStyle(.switch)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
