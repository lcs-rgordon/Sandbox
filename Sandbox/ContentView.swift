//
//  ContentView.swift
//  Sandbox
//
//  Created by Russell Gordon on 2021-08-02.
//

import SwiftUI

// Don't worry if not understanding at first – Paul indicates that these concepts are tricky.
// Use the YouTube chat to ask questions
// What is the difference between parallel vs. concurrency?

/*
 Parallel – different pieces of code running, for example, running on different cores of a multi-core CPU at the same time. This is parallelism.
 
 Concurrency - running multiple tasks on say, a single core CPU but managing the running of different tasks using time-slicing – this process gets 10 ms, this process gets 10 ms – etc. One CPU core juggles many tasks, from the user perspective many are running at the same time, but the CPU is just being very clever about sharing it's resources across many tasks that really are running one at a time.
 
 In Swift 5.5, these ideas get pushed up into the app level. We can take one program and divide it into multiple parts that can be run on multiple cores. Now we must think – how do we divide up the program? Swift 5.5 lets us make these decisions.
 
 We can push slow work somewhere else, so that the UI work on the main thread doesn't get choppy.
 
 A thread is a little bit of a program, perhaps one function. At the same time, we also have the concept of queues – slices of your program that can run independently of one another – example of parallelism.
 
 Threads are a level of detail we don't really care about most often (aside from avoiding putting slow things like network requests on the main thread). Instead of dealing with threads directly, we can set up a queue and let the system decide what thread to put that queue on.
 
 NOTE TO SELF: Review video and check these notes for accuracy.
 */

extension URLSession {
    
    // Decode SOMETHING... it just needs to be Decodable... <T: Decodable>
    // Download from any URL and decode to any Decodable type
    // If you can figure out the type, do it... _ type: T.Type = T.self,
    // What URL to decode from? from url: URL,
    // "async" keyword to make function support concurrency
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws -> T {
        
        // Tell Swift that calling this next line of code might take some time
        // Wait for the response to come back befor we can use it
        // so, "await"
        // The line of code might throw errors
        // so, "try"
        let (data, _) = try await data(from: url)
        
        // Set up the decoder with the options the user passed in
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy
        
        // Whatever type the user asked for, decode to that
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
        
    }
    
}

struct Message: Codable, Identifiable {
    let id: Int
    let user: String
    let text: String
}


struct ContentView: View {
    
    // You can write to @State from anywhere in your program, even a background thread, and it will safely allow pushes to the main thread... synchronization is being done for us.
    @State private var inbox = [Message]()
    @State private var sent = [Message]()
    
    let messageBoxes = ["Inbox", "Sent"]
    
    @State private var selectedBox = "Inbox"
    
    var messages: [Message] {
        if selectedBox == "Inbox" {
            return inbox
        } else {
            return sent
        }
    }
    
    var body: some View {
        NavigationView {
            // Show a list of messages
            List(messages) { message in
                Text("\(message.user):").bold() +
                Text(message.text)
            }
            .navigationTitle("Inbox")
            .toolbar {
                Picker("Select a message box", selection: $selectedBox) {
                    ForEach(messageBoxes, id:\.self, content: Text.init)
                }
                .pickerStyle(.segmented)
            }
            // Modifier that lets us use asynchronous task from a synchronous program
            // Adds a task to perform when this view appears.
            // The task will be cancelled when this view disappears.
            // async-await prepares our code to be able to split up – only when we use .task does it get split up.
            // It doesn't actually become a thread here – tasks are an abstraction on top of threads. You can have multiple tasks running on one thread – the system decides what is best.
            .task {
                do {
                    // Now the tasks run concurrently (side by side)
                    // Swift remembers which async let values throw errors, so we don't need to use "try" here
                    // Started in parallel...
                    // Must use a constant (let) otherwise (if it was a variable) there is potential for the data used by an asyncrhonous task to be changed while the asynchronous task, which could create havoc with data races, et cetera
                    let inboxURL = URL(string: "https://hws.dev/inbox.json")!
                    async let inboxItems: [Message] = URLSession.shared.decode(from: inboxURL)
                    let sentURL = URL(string: "https://hws.dev/inbox.json")!
                    async let sentItems: [Message] = URLSession.shared.decode(from: sentURL)

                    // At some, read the items that have come back
                    // We must use await here to get the values back
                    // We wait for the results sequentially
                    inbox = try await inboxItems // It will wait here for inbox to finish..
                    sent = try await sentItems // Before getting sent (but at least the tasks are started concurrently)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
