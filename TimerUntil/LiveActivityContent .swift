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

struct AppLogo: View {
    var body: some View {
        Image(systemName: "timer.circle.fill")
            .resizable()
            .scaledToFit()
        
    }
}

struct TimerMain: View {
    var targetDate: Date
    
    var body: some View {
        Text(timerInterval: Date.now...targetDate, countsDown: true)
            .monospacedDigit()
            .multilineTextAlignment(.center)
            .font(.system(size: 22, weight: .semibold))
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
            .font(.system(size: 9, weight: .ultraLight))
            .foregroundColor(.green)
            .frame(width: 55, alignment: .trailing)
    }
}
