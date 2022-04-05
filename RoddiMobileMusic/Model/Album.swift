//
//  Album.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 3/29/22.
//

import SwiftUI

//viewmodels will be created to manage uploading to firebase
struct Album: Identifiable {
    var id = UUID().uuidString
    var albumName: String
    var albumImage: String //should be made optional later
    var isLiked: Bool = false
    var albumArtistName: String
    var trackNames: [String]
    var releaseYear: String?
    var genre: String?
}

extension Album {
    var albumArtist: Artist {
        get {
            //var album = Album(albumName: self.albumName, albumImage: self.albumImage, isLiked: self.isLiked, albumArtistName: self.albumArtistName, trackNames: self.trackNames, releaseYear: self.releaseYear ?? nil, genre: self.genre ?? nil)
            var artist: Artist = Artist(artistName: albumArtistName)
            artist.discography = artist.addNewAlbum(self)
            return artist
        }
    }
    
    var tracks: [Track] {
        get {
            var albumTracks: [Track] = []
            for trackName in trackNames {
                let i = trackNames.firstIndex(of: trackName)
                albumTracks.append(Track(trackName: trackName, trackNumber: i ?? 1, genre: self.genre ?? nil, parentAlbumName: self.albumName, artist: self.albumArtistName))
            }
            return albumTracks
        }
    }
}

//ZStack albums
var stackAlbums: [Album] = [
    Album(albumName: "Colours of Divinity", albumImage: "neonalbumcover", albumArtistName: "Didier Thauvin", trackNames: ["Sacre Bleu", "Monet", "Mademoiselle", "Monsieur Jacques", "L'Amour", "Je te Séduis", "Dame de la Nuit", "Je t'aime", "Langue du Ciel", "Chanson Paresseuse"], releaseYear: "2022", genre: "Soca"),
    Album(albumName: "Mother Touch", albumImage: "maryalbumcover", albumArtistName: "Selena Jones", trackNames: ["God's Love", "Flowers", "Guide Me", "Water of Life", "Tomorrow's Victory", "Outro"], releaseYear: "2019", genre: "Gospel"),
    Album(albumName: "Stairway to Heaven", albumImage: "banisteralbumcover", isLiked: true, albumArtistName: "Rui Silva", trackNames: ["Iluminação", "Metafísica", "Extratos Filosóficos", "Mente Sobre a Matéria", "Controle de Raiva"], releaseYear: "2022", genre: "Ambient/Classical"),
    Album(albumName: "Fragments", albumImage: "afternoonalbumcover", albumArtistName: "Todd Kyle MacDonald", trackNames: ["Afternoon", "Lazy Song", "Interlude", "Southern Comfort", "Outro"], releaseYear: "2020", genre: "Pop"),
]

var albums: [Album] = [
    Album(albumName: "Colours of Divinity", albumImage: "neonalbumcover", albumArtistName: "Didier Thauvin", trackNames: ["Sacre Bleu", "Monet", "Mademoiselle", "Monsieur Jacques", "L'Amour", "Je te Séduis", "Dame de la Nuit", "Je t'aime", "Langue du Ciel", "Chanson Paresseuse"], releaseYear: "2022", genre: "Soca"),
    Album(albumName: "Mother Touch", albumImage: "maryalbumcover", albumArtistName: "Selena Jones", trackNames: ["God's Love", "Flowers", "Guide Me", "Water of Life", "Tomorrow's Victory", "Outro"], releaseYear: "2019", genre: "Gospel"),
    Album(albumName: "Stairway to Heaven", albumImage: "banisteralbumcover", isLiked: true, albumArtistName: "Rui Silva", trackNames: ["Iluminação", "Metafísica", "Extratos Filosóficos", "Mente Sobre a Matéria", "Controle de Raiva"], releaseYear: "2022", genre: "Ambient/Classical"),
    Album(albumName: "Fragments", albumImage: "afternoonalbumcover", albumArtistName: "Todd Kyle MacDonald", trackNames: ["Afternoon", "Lazy Song", "Interlude", "Southern Comfort", "Outro"], releaseYear: "2020", genre: "Pop"),
    Album(albumName: "Gathering Clouds", albumImage: "sunsetalbumcover", isLiked: true, albumArtistName: "Francine Smith", trackNames: ["Intro", "Tall Stories", "Heart of Stone", "Man from Timbuktu", "Talk to Me", "Jesus is Coming"], releaseYear: "2022", genre: "Jazz"),
    Album(albumName: "Memories: Alsace", albumImage: "1935albumcover", albumArtistName: "Jacques Deschamps", trackNames: ["Jésus est Roi", "La Joie Vient le Matin", "Pierre Simon", "Entracte", "Règne Vienne", "Peuple de Dieu", "Dernière Cène"], releaseYear: "2014", genre: "Gospel"),
    Album(albumName: "GreyScale", albumImage: "couplealbumcover", isLiked: true, albumArtistName: "Kwame Dawson", trackNames: ["Intro", "Pain", "Diversion", "Lock-Up","Tommy's Interlude", "Fraternity", "Lonely Night", "Intermission", "Giant", "Memory Fades", "Outro"], releaseYear: "2019", genre: "Blues"),
    Album(albumName: "God is Love", albumImage: "heartalbumcover", albumArtistName: "Thabo Molefe", trackNames: ["Rapture's Delight", "Sing Glory", "Joy", "Judgement Day", "Christ Reigns", "Salvation Army", "Conquerors", "Happy", "Redeemer", "I Was Lost (Now I am Found)", "God is Love", "King of Glory"]),
    Album(albumName: "La résistance", albumImage: "teargasalbumcover", isLiked: true, albumArtistName: "Didier Thauvin", trackNames: ["Chanson de Protestation", "Deuxième Acte", "Pleurer", "2016", "Chemin du Monde", "Interlude", "Outro"], releaseYear: "2016", genre: "Rock"),
]
