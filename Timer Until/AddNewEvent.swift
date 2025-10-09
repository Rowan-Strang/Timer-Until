//
//  AddNewEvent.swift
//  Timer Until
//
//  Created by MacRow on 09/10/2025.
//

import SwiftUI

struct AddNewEvent: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var dateTime = Date()
    @State private var emoji = "🚍"
    
//    init(events: Events) {
//        self.events = events
//        UIDatePicker.appearance().minuteInterval = 15
//    }
    
    var events: Events
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("title", text: $title)
                DatePicker("When", selection: $dateTime, displayedComponents: .hourAndMinute)
            }
            .navigationTitle("Add Event")
            .toolbar {
                Button("Save") {
                    let event = CountdownEvent(title: title, dateTime: dateTime, id: UUID(), emoji: emoji)
                    events.items.append(event)
                    dismiss()
                    
                }
            }
        }
    }
}

#Preview {
    AddNewEvent(events: Events())
}
