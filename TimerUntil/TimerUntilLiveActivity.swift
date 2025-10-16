//
//  TimerUntilLiveActivity.swift
//  TimerUntil
//
//  Created by MacRow on 16/10/2025.
//

import Foundation
import ActivityKit
import WidgetKit
import SwiftUI

struct TimerUntilLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                MainActivityContent(eventName: context.attributes.eventTitle, targetDate: context.state.dateTime)
            }
            .activityBackgroundTint(Color.black)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
//                DynamicIslandExpandedRegion(.leading) {
//                    AppLogo()
//                }
//                DynamicIslandExpandedRegion(.trailing) {
//                    Text(context.attributes.eventTitle)
//                        .font(.system(size: 12))
//                        .fontWeight(.medium)
//                        .foregroundColor(.green)
//                        .lineLimit(1)
//                }
                DynamicIslandExpandedRegion(.center) {
                    TimerMain(targetDate: context.state.dateTime)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.attributes.eventTitle)
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(.green)
                        .lineLimit(1)
                }
            } compactLeading: {
                AppLogo()
            } compactTrailing: {
                TimerLight(targetDate: context.state.dateTime)
            } minimal: {
                TimerTiny(targetDate: context.state.dateTime)
            }
//            .widgetURL(URL(string: "http://www.apple.com"))
//            .keylineTint(Color.red)
        }
    }
}



#Preview("Notification", as: .content, using:
            LiveActivityAttributes.init(eventTitle: "Time to Leave")) {
   TimerUntilLiveActivity()
} contentStates: {
    LiveActivityAttributes.ContentState(dateTime: Date().addingTimeInterval(3603))
}
