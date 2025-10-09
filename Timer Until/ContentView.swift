//
//  ContentView.swift
//  Timer Until
//
//  Created by MacRow on 08/10/2025.
//

import SwiftUI

struct CountdownEvent: Identifiable {
    let title: String
    let dateTime: Date
    let id : UUID
    let emoji: String
}

@Observable
class Events {
    var items = [CountdownEvent]()
}

struct ContentView: View {
    
    @State private var events = Events()
    @State private var now = Date()
    @State private var showingAddNewEvent = false
    
    var body: some View {
        NavigationStack {
            Group {
                if events.items.isEmpty {
                    VStack{
                        Text("No Timers or Events")
                            .font(.title)
                        Text("tap the + to add")
                            .font(.subheadline)
                    }
                } else {
                    List{
                        ForEach(events.items){
                            item in NavigationLink(value: "nothing"){
                                HStack{
                                    Text(item.emoji)
                                        .font(.largeTitle)
                                    
                                    VStack(alignment: .leading){
                                        Text(item.title)
                                            .font(.title2)
                                        if Calendar.current.isDateInToday(item.dateTime) {
                                            Text("Today")
                                                .font(.subheadline)
                                        }
                                    }
                                    Spacer()
                                    Text(item.dateTime.formatted(date: .omitted, time: .shortened))
                                }
                            }
                        }
                        .onDelete(perform: removeEvent)
                    }
                }
            }
            .navigationTitle("Timer Until")
            .toolbar {
                Button("Add Countdown", systemImage: "plus"){
//                    let event = CountdownEvent(title: "Catch the Bus", dateTime: Date().addingTimeInterval(2 * 60 * 60), id: UUID(), emoji: "🚌")
//                    events.items.append(event)
                    showingAddNewEvent = true
                }
            }
            .sheet(isPresented: $showingAddNewEvent) {
                AddNewEvent(events: events)
            }
        }
        
    }
    
    func removeEvent(at offsets: IndexSet){
        events.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
