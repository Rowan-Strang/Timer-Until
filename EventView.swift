//
//  EventView.swift
//  Timer Until
//
//  Created by MacRow on 10/10/2025.
//

import SwiftUI

struct EventView: View {
    
    let event: CountdownEvent
    
    private var remainingSecondsTotal: Int {
        max(0, Int(event.dateTime.timeIntervalSince(Date())))
    }
    
    private var remainingHours: Int {
        remainingSecondsTotal / 60 / 60
    }
    
    private var remainingMinutes: Int {
        (remainingSecondsTotal / 60) % 60
    }
    
    var body: some View {
        VStack{
            Spacer()
            Text(event.emoji)
                .font(.largeTitle)
            Text(event.title)
                .font(.title)
            Text(event.dateTime.formatted(date: .abbreviated, time: .shortened))
                .font(.subheadline)
            TimelineView(.periodic(from: .now, by: 1)) { context in
                HStack(spacing: 0) {
                    Text(String(format: "%02d",remainingHours))
                        .font(.system(size: 96, weight: .bold, design: .rounded))
                        .monospacedDigit()
                    Text(":")
                        .font(.system(size: 96, weight: .bold, design: .rounded))
                        .monospacedDigit()
                        .baselineOffset(96*0.12)
                        .opacity(context.date.timeIntervalSince1970.truncatingRemainder(dividingBy: 2) < 1 ? 1 : 0)
                    Text(String(format: "%02d", remainingMinutes))
                        .font(.system(size: 96, weight: .bold, design: .rounded))
                        .monospacedDigit()
                }
                .kerning(2)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
                .padding(.vertical, 24)
                .padding(.horizontal, 32)
                .background(
                    .ultraThinMaterial,
                    in: RoundedRectangle(cornerRadius: 24, style: .continuous)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.white.opacity(0.28), lineWidth: 1)
                )
                .shadow(radius: 12)
                .padding(.horizontal, 24)
        }
            TimelineView(.periodic(from: .now, by: 1)) { _ in
                Text("Total Seconds: \(String(remainingSecondsTotal))")
                    .font(.subheadline)
                    .padding()
            }
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
