//
//  Artist.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/3/22.
//

import Foundation

struct Artist: Identifiable {
    var id: String = UUID().uuidString
    var artistName: String
    var discography: [Album]?
    var biography: String = "This is the artist biography"
}

extension Artist {
    func addNewAlbum (_ newAlbum: Album) -> [Album] {
        var albums: [Album] = self.discography ?? []
        albums.append(newAlbum)
        return albums
    }
}
