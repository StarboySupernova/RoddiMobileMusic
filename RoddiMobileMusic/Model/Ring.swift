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
    Ring(progress: 98, value: "Total Minutes", keyIcon: "clock", keyColor: Color.mint, rawData: 27946),
    Ring(progress: 36, value: "Minutes Today", keyIcon: "hourglass.tophalf.filled", keyColor: Color.purple, rawData: 102),
    Ring(progress: 98, value: "Total Tracks Played", keyIcon: "rectangle.stack.badge.play.fill", keyColor: Color.blue, rawData: 9147),
    Ring(progress: 59, value: "Tracks Played Today", keyIcon: "music.quarternote.3", keyColor: Color.yellow, rawData: 34),
]
