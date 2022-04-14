//
//  Ring.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/8/22.
//

import Foundation
import SwiftUI

//Progress ring model and sample data
struct Ring: Identifiable {
    var id = UUID().uuidString
    var progress: CGFloat
    var value: String
    var keyIcon: String
    var keyColor: Color
    var isText: Bool = false
    var rawData: CGFloat
}

var rings: [Ring] = [
    Ring(progress: 50, value: "Minutes Played Today", keyIcon: "hourglass.tophalf.filled", keyColor: Color.purple, rawData: 202),
    Ring(progress: 98, value: "Total Minutes Played", keyIcon: "clock", keyColor: Color.mint, rawData: 27946),
    Ring(progress: 50, value: "Played Today", keyIcon: "music.quarternote.3", keyColor: Color.yellow, rawData: 68),
    Ring(progress: 98, value: "Total Played", keyIcon: "rectangle.stack.badge.play.fill", keyColor: Color.blue, rawData: 9147),
]
