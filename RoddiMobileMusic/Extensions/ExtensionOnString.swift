//
//  ExtensionOnString.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/5/22.
//

import Foundation
import SwiftUI

//String conformance to Identifiable
extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
