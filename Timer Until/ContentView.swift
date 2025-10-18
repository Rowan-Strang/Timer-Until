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
            EventsStore.save(items)
        }
    }
    
    init() {
        items = EventsStore.load()
        NotificationCenter.default.addObserver(
            forName: .eventsStoreDidChange,
            object: nil,
            queue: .main
        ) {[weak self] _ in
            guard let self else {return}
            self.items = EventsStore.load()
        }
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
                            event in NavigationLink(destination: EventView(event: event)){
                                HStack{
                                    Text(event.emoji)
                                        .font(.largeTitle)
                                    
                                    VStack(alignment: .leading){
                                        Text(event.title)
                                            .font(.title3)
                                        if Calendar.current.isDateInToday(event.dateTime) {
                                            Text("Today at \(event.dateTime.formatted(date: .omitted, time: .shortened))")
                                                .font(.footnote)
                                        }
                                    }
                                    Spacer()
                                    var totalSeconds: Int {
                                        max(0, Int(event.dateTime.timeIntervalSince(Date())))
                                    }
                                    var remainingHours: Int {
                                        totalSeconds / 60 / 60
                                    }
                                    
                                    var remainingMinutes: Int {
                                        (totalSeconds / 60) % 60
                                    }
                                    
                                    TimelineView(.periodic(from: .now, by: 1)) { context in
                                        HStack(spacing: 0) {
                                            Text("\(String(format: "%02d",remainingHours)):\(String(format: "%02d",remainingMinutes))")
                                                .font(.title).fontWeight(.semibold)
//                                            Text(String(format: "%02d",remainingHours))
//                                            Text(":")
//                                            Text(String(format: "%02d",remainingMinutes))
                                            //                                        Text(event.dateTime.formatted(date: .omitted, time: .shortened))
                                        }
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .onDelete(perform: removeEvent)
                    }
                }
            }
            .navigationTitle("Timer Until")
            .toolbar {
                Button("Add Countdown", systemImage: "plus"){
//                    let event = CountdownEvent(title: "Catch the Bus", dateTime: Date().addingTimeInterval(1.2 * 60 * 60), id: UUID(), emoji: "🚌")
//                    events.items.append(event)
//                    let event2 = CountdownEvent(title: "Meet Loran for Lunch", dateTime: Date().addingTimeInterval(2 * 60 * 60), id: UUID(), emoji: "🙆🏼‍♀️")
//                    events.items.append(event2)
//                    let event3 = CountdownEvent(title: "Wedding Meeting", dateTime: Date().addingTimeInterval(5.1 * 60 * 60), id: UUID(), emoji: "👨🏻‍💻")
//                    events.items.append(event3)
                    showingAddNewEvent = true
//                    UserDefaults.standard.removeObject(forKey: "Events")
                }
            }
            .sheet(isPresented: $showingAddNewEvent) {
                AddNewEvent(events: events)
            }
        }
        
    }
    
    func removeEvent(at offsets: IndexSet){
//        eventsSorted.remove(atOffsets: offsets)
        withAnimation{
            let idsToDelete = offsets.map {eventsSorted[$0].id }
            events.items.removeAll {idsToDelete.contains($0.id) }
            for eventId in idsToDelete {
                LiveActivityManager.shared.endActivity(id: eventId)
            }
        }
    }
}

#Preview {
    ContentView()
}
