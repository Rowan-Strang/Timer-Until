//
//  LiveActivityAttributes.swift
//  Timer Until
//
//  Created by MacRow on 16/10/2025.
//

import Foundation
import ActivityKit

struct LiveActivityAttributes: ActivityAttributes {
    public typealias LiveActivityStatus = ContentState
    public struct ContentState: Codable, Hashable {
        var dateTime: Date
    }
    var eventTitle: String
}
