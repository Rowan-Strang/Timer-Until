//
//  AppShortcuts.swift
//  Timer Until
//
//  Created by MacRow on 10/10/2025.
//
import AppIntents

struct TimerUntilShortcuts: AppShortcutsProvider {
    static var shortcutTileColor: ShortcutTileColor = .orange

    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddEventIntent(),
            phrases: [
                "Add a timer in \(.applicationName)",
                "Create countdown in \(.applicationName)",
                "Add event in \(.applicationName)"
            ],
            shortTitle: "Add Event",
            systemImageName: "timer"
        )
    }
}
