//
//  ContentView.swift
//  Timer Until
//
//  Created by MacRow on 08/10/2025.
//

import SwiftUI

struct CountdownEvent: Identifiable, Codable {
    let title: String
    let dateTime: Date
    var id : UUID
    let emoji: String
}

@Observable
class Events {
    var items = [CountdownEvent](){
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Events")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Events") {
            if let decodedItems = try? JSONDecoder().decode([CountdownEvent].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    
    @State private var events = Events()
    @State private var now = Date()
    @State private var showingAddNewEvent = false
    
    var eventsSorted: [CountdownEvent] {
        events.items.sorted { $0.dateTime < $1.dateTime}
    }
    
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
                        ForEach(eventsSorted){
                            item in NavigationLink(value: "add later"){
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
    
//    func removeEvent(at offsets: IndexSet){
//        events.items.remove(atOffsets: offsets)
//    }
    func removeEvent(at offsets: IndexSet){
//        eventsSorted.remove(atOffsets: offsets)
        let idsToDelete = offsets.map {eventsSorted[$0].id }
        events.items.removeAll {idsToDelete.contains($0.id) }
    }
}

#Preview {
    ContentView()
}
