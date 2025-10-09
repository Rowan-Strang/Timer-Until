//
//  AddNewEvent.swift
//  Timer Until
//
//  Created by MacRow on 09/10/2025.
//

import SwiftUI

struct AddNewEvent: View {
    @Environment(\.dismiss) var dismiss
    
    enum Field: Hashable {
        case title
        case dateTime
        case emoji
    }
    
    @State private var title = ""
    @State private var dateTime = Date()
    @State private var emoji = "🚍"
    
    @FocusState private var focusedField: Field?
    
//    init(events: Events) {
//        self.events = events
//        UIDatePicker.appearance().minuteInterval = 15
//    }
    
    var events: Events
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Title"){
                    TextField("", text: $title)
                        .focused($focusedField, equals: .title)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .dateTime
                        }
                }
                Section(){
                    DatePicker("When", selection: $dateTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .focused($focusedField, equals: .dateTime)
                }
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
        .onAppear{
            focusedField = .title
        }
    }
}

#Preview {
    AddNewEvent(events: Events())
}
