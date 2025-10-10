//
//  EventsStore.swift
//  Timer Until
//
//  Created by MacRow on 10/10/2025.
//
import Foundation

extension Notification.Name {
    static let eventsStoreDidChange = Notification.Name("EventsStoreDidChange")
}

enum EventsStore {
    private static let key = "Events"

    static func load() -> [CountdownEvent] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([CountdownEvent].self, from: data)
        } catch {
            print("Decoding Failed", error)
            UserDefaults.standard.removeObject(forKey: key)
            return []
        }
//        return (try? JSONDecoder().decode([CountdownEvent].self, from: data)) ?? []
    }

    static func save(_ items: [CountdownEvent]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
//            NotificationCenter.default.post(name: .eventsStoreDidChange, object: nil)
        }
    }

    static func add(_ event: CountdownEvent) {
        var items = load()
        items.append(event)
        save(items)
        NotificationCenter.default.post(name: .eventsStoreDidChange, object: nil)
    }

    static func remove(ids: [UUID]) {
        var items = load()
        items.removeAll { ids.contains($0.id) }
        save(items)
        NotificationCenter.default.post(name: .eventsStoreDidChange, object: nil)
    }
}
