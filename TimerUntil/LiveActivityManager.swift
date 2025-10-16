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
    
    func startActivity(eventTitle: String, dateTime: Date) {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            let attributes = LiveActivityAttributes(eventTitle: eventTitle)
            let initalState = LiveActivityAttributes.LiveActivityStatus(dateTime: dateTime)
            
            do {
                let activity = try Activity<LiveActivityAttributes>.request(
                    attributes: attributes,
                    content: .init(state: initalState, staleDate: dateTime))
                self.activity = activity
                print("Live activity started: \(activity.id)")
            } catch {
                print("failed to start live activity: \(error)")
            }
        } else {
            print("Live Activites are Disabled")
        }
    }
}
