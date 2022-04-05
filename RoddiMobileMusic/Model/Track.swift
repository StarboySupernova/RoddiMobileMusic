//
//  Track.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/3/22.
//

import Foundation

struct Track: Identifiable {
    var id: String = UUID().uuidString
    var trackName: String
    var isLiked: Bool = false
    var trackNumber: Int?
    var diskNumber: UInt8? = 1
    var genre: String?
    var parentAlbumName: String
    var artist: String
}
