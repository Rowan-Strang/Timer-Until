//
//  EventView.swift
//  Timer Until
//
//  Created by MacRow on 10/10/2025.
//

import SwiftUI

struct EventView: View {
    
    let event: CountdownEvent
    
    var body: some View {
        VStack{
            Spacer()
            Text(event.emoji)
                .font(.largeTitle)
            Text(event.title)
                .font(.title)
            Text(event.dateTime.formatted(date: .abbreviated, time: .shortened))
                .font(.subheadline)
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    EventView(event: CountdownEvent(
        title: "Birthday Party", dateTime: Date().addingTimeInterval(3600), id: UUID(), emoji: "🥳"
    ))
}
