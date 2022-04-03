//
//  Album.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 3/29/22.
//

import SwiftUI

struct Album: Identifiable {
    var id = UUID().uuidString
    var albumName: String
    var albumImage: String
    var isLiked: Bool = false
}

//ZStack albums
var stackAlbums: [Album] = [
    Album(albumName: "Colours of Divinity", albumImage: "neonalbumcover"),
    Album(albumName: "Stairway to Heaven", albumImage: "banisteralbumcover"),
    Album(albumName: "Fragments", albumImage: "afternoonalbumcover"),
    Album(albumName: "GreyScale", albumImage: "couplealbumcover")
]

var albums: [Album] = [
    Album(albumName: "Colours of Divinity", albumImage: "neonalbumcover"),
    Album(albumName: "Mother Touch", albumImage: "maryalbumcover"),
    Album(albumName: "Stairway to Heaven", albumImage: "banisteralbumcover", isLiked: true),
    Album(albumName: "Fragments", albumImage: "afternoonalbumcover"),
    Album(albumName: "Gathering Clouds", albumImage: "sunsetalbumcover", isLiked: true),
    Album(albumName: "Memories: Alsace", albumImage: "1935albumcover"),
    Album(albumName: "GreyScale", albumImage: "couplealbumcover", isLiked: true),
    Album(albumName: "God is Love", albumImage: "heartalbumcover")
]
