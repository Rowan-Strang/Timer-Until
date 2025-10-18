//
//  AddEventIntent.swift
//  Timer Until
//
//  Created by MacRow on 10/10/2025.
//
import AppIntents
import Foundation
import ActivityKit

struct AddEventIntent: AppIntent, LiveActivityIntent {
    static var title: LocalizedStringResource = "Add Timer Event"
    static var description = IntentDescription("Adds a new countdown event to Timer Until.")
    static var openAppWhenRun = false
    static var authenticationPolicy: IntentAuthenticationPolicy = .alwaysAllowed
    
    @Parameter(title: "Title")
    var title: String

    @Parameter(title: "Time")
    var time: Date

    @Parameter(title: "Emoji", default: "⏲️")
    var emoji: String

    static var parameterSummary: some ParameterSummary {
        Summary("Add \(\.$title) at \(\.$time) \(\.$emoji)")
    }
@MainActor
    func perform() async throws -> some IntentResult {
        let event = CountdownEvent(title: title, dateTime: time, id: UUID(), emoji: emoji)
        EventsStore.add(event)
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            LiveActivityManager.shared.startActivity(eventTitle: title, dateTime: time, id: event.id, emoji: emoji)
        }
        return .result()
    }
}
