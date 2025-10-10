//
//  AddEventIntent.swift
//  Timer Until
//
//  Created by MacRow on 10/10/2025.
//
import AppIntents
import Foundation

struct AddEventIntent: AppIntent {
    static var title: LocalizedStringResource = "Add Timer Event"
    static var description = IntentDescription("Adds a new countdown event to Timer Until.")

    @Parameter(title: "Title")
    var title: String

    @Parameter(title: "Time")
    var time: Date

    @Parameter(title: "Emoji", default: "⏲️")
    var emoji: String

    static var parameterSummary: some ParameterSummary {
        Summary("Add \(\.$title) at \(\.$time) \(\.$emoji)")
    }

    func perform() async throws -> some IntentResult & ProvidesDialog {
        let event = CountdownEvent(title: title, dateTime: time, id: UUID(), emoji: emoji)

        EventsStore.add(event)

        return .result(dialog: "Event added.")
    }
}
