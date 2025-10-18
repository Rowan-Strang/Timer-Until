//
//  LiveActivityContent.swift
//  Timer Until
//
//  Created by MacRow on 16/10/2025.
//

import SwiftUI
import WidgetKit

struct MainActivityContent: View {
    let eventName: String
    var targetDate: Date
    
    var body: some View {
        VStack {
            VStack {
                Text(timerInterval: Date.now...targetDate, countsDown: true)
                    .monospacedDigit()
                    .contentTransition(.numericText(countsDown: true))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.green)
                Text(eventName)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(.green)
                    .lineLimit(1)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Time remaining until \(eventName)")
            .accessibilityValue(Text(targetDate, style: .timer))
        }
    }
}

struct eventEmoji: View {
    let emoji: String
    var body: some View {
        Text(emoji)
            .font(.system(size: 34))
            .minimumScaleFactor(0.5)
            .lineLimit(1)
        
    }
}

struct TimerMain: View {
    var targetDate: Date
    var size: CGFloat
    
    var body: some View {
        Text(timerInterval: Date.now...targetDate, countsDown: true)
            .monospacedDigit()
            .contentTransition(.numericText(countsDown: true))
            .multilineTextAlignment(.center)
            .font(.system(size: size, weight: .semibold))
            .foregroundColor(.green)
    }
}

struct TimerLight: View {
    var targetDate: Date
    
    var body: some View {
        Text(timerInterval: Date.now...targetDate, countsDown: true)
            .monospacedDigit()
            .multilineTextAlignment(.center)
            .font(.system(size: 15, weight: .light))
            .foregroundColor(.green)
            .frame(width: 55, alignment: .trailing)
    }
}

struct TimerTiny: View {
    var targetDate: Date
    
    var body: some View {
        Text(timerInterval: Date.now...targetDate, countsDown: true)
            .monospacedDigit()
            .multilineTextAlignment(.center)
            .font(.system(size: 9, weight: .light))
            .foregroundColor(.green)
            .frame(width: 55, alignment: .trailing)
    }
}
