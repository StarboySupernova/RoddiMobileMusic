//
//  Step.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/8/22.
//

import Foundation
import SwiftUI

//Steps Bar Graph Model and Sample Data
struct Step: Identifiable {
    var id = UUID().uuidString
    var value: CGFloat
    var key: String
    var color: Color = Color.purple.opacity(0.6)
}

var steps: [Step] = [
    Step(value: 50, key: "1-4 AM"),
    Step(value: 24, key: "5-8 AM", color: Color.mint),
    Step(value: 35, key: "9-11 AM"),
    Step(value: 43, key: "12-4 PM", color: Color.mint),
    Step(value: 69, key: "5-8 PM"),
    Step(value: 54, key: "9-12 PM", color: Color.mint),
]
