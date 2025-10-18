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
            HStack{
                Text(context.state.emoji)
                    .font(.system(size: 42))
                    .offset(x: 20)
//                    .frame(width: 48)
//                    .clipped()
                    .accessibilityLabel("Event Emoji")
                VStack {
                    MainActivityContent(eventName: context.attributes.eventTitle, targetDate: context.state.dateTime)
                        .padding(15)
                }
                Text(context.state.emoji)
                    .font(.system(size: 42))
                    .offset(x: -20)
//                    .frame(width: 48)
//                    .clipped()
                    .accessibilityLabel("Event Emoji")
            }
            .activityBackgroundTint(Color.black)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    EmptyView()
                }
                DynamicIslandExpandedRegion(.trailing) {
                    EmptyView()
                }
                DynamicIslandExpandedRegion(.center) {
                    HStack(alignment: .center, spacing: 8){
                        Text(context.state.emoji)
                            .font(.system(size: 42))
                            .baselineOffset(13)
                            .offset(x: 6)
                            .frame(width: 48, height: 50)
                            .clipped()
                            .accessibilityLabel("Event Emoji")
                        VStack(spacing: 2) {
                            TimerMain(targetDate: context.state.dateTime, size: 42)
                                .lineLimit(1)
                                .minimumScaleFactor(0.9)
                            Text(context.attributes.eventTitle)
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(.green)
                                .lineLimit(1)
                        }
                        Text(context.state.emoji)
                            .font(.system(size: 42))
                            .baselineOffset(13)
                            .offset(x: -6)
                            .frame(width: 48, height: 50)
                            .clipped()
                            .accessibilityLabel("Event Emoji")
                    }
                    
//                        .layoutPriority(0)
//                        .padding(.horizontal, 6)
//                        .layoutPriority(0)
//                        .background(.red)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    EmptyView()
//                    Text(context.attributes.eventTitle)
//                        .font(.system(size: 12))
//                        .fontWeight(.medium)
//                        .foregroundColor(.green)
//                        .lineLimit(1)
                }
            } compactLeading: {
                eventEmoji(emoji: context.state.emoji)
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
    LiveActivityAttributes.ContentState(dateTime: Date().addingTimeInterval(3603), id: UUID(), emoji: "👨🏻‍💻")
}
