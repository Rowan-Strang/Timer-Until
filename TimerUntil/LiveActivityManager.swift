//
//  LiveActivityManager.swift
//  Timer Until
//
//  Created by MacRow on 16/10/2025.
//

import Foundation
import ActivityKit

class LiveActivityManager {
    
    static let shared = LiveActivityManager()
    private var activity: Activity<LiveActivityAttributes>?
    
    private init() {}
    
    func startActivity(eventTitle: String, dateTime: Date, id: UUID) {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            let attributes = LiveActivityAttributes(eventTitle: eventTitle)
            let initialState = LiveActivityAttributes.LiveActivityStatus(dateTime: dateTime, id: id)
            
            do {
                let activity = try Activity<LiveActivityAttributes>.request(
                    attributes: attributes,
                    content: .init(state: initialState, staleDate: nil))
                self.activity = activity
                print("Live activity started: \(activity.id) for \(id)")
            } catch {
                print("failed to start live activity: \(error)")
            }
        } else {
            print("Live Activites are Disabled")
        }
    }
    
    func endActivity(id: UUID) {
        // Find the system activity whose contentState.id matches our app's UUID
        guard let activity = Activity<LiveActivityAttributes>.activities.first(where: { $0.content.state.id == id }) else {
            print("No Live Activity found for app id \(id)")
            return
        }

        // Use the current content state as the final state when ending
        let finalState = activity.content.state

        
        Task {
            await activity.end(
                ActivityContent(state: finalState, staleDate: nil),
                dismissalPolicy: .immediate
            )
            print("Live Activity ended \(activity.id) (event id: \(id))")
        }
    }
}
