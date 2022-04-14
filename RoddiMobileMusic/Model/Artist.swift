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
    var biography: String = "This is the artist biography" //-to replace dummytext
    var artistImage: String = ""
    var marqueeDescription: String = "" //e.g. New Release or Fan Favourite - To replace Apple Arcade platform title - make an enum of possible marquee descriptions
}

extension Artist {
    func addNewAlbum (_ newAlbum: Album) -> [Album] {
        var albums: [Album] = self.discography ?? []
        albums.append(newAlbum)
        return albums
    }
    
    var albumLogo: String? {
        self.discography?[0].albumImage
    }
    
    var bannerTitle: String {
        self.biography //uses truncation. replaces banner title
    }
}

/*
 var todayItems: [Today] = [
     Today(appName: "Lego Brawls", description: "Battle with your friends online", appLogo: "neonsoundboard", bannerTitle: "Smash Your Rivals with Lego Brawls", artwork: "soundboard", platformTitle: "Apple Arcade"),
     Today(appName: "Forza Horizon", description: "Racing Game", appLogo: "eventmic", bannerTitle: "You are in charge of the Forza Festival", artwork: "blacksinger", platformTitle: "Apple Arcade")
 ]
 */

var artists: [Artist] {
    var temp: [Artist] = []
    for item in albums {
        temp.append(item.albumArtist)
    }
    return temp
}

var sampleArtists: [Artist] {
    var temp: [Artist] = []
    
    var artist1 = artists[0]
    artist1.biography =  "Benjamin Joseph Levin (born March 8, 1988), known professionally as Didier Thauvin (stylized in all lowercase), is an American record producer, DJ, songwriter and record executive. He is the recipient of the 2013 Hal David Starlight Award from the Songwriters Hall of Fame.[2] He is also a five-time BMI Songwriter of the Year award winner and 2017 iHeartRadio Producer of the Year award winner.Blanco was initially mentored by songwriter and producer Dr. Luke, who signed Blanco to his production company Kasz Money Productions. While under his tutelage, Blanco co-produced and co-wrote a multitude of hit singles in the late 2000s and thereafter. Blanco has contributed to the sale of over 500 million albums worldwide through his work with artists including Ed Sheeran, Justin Bieber, Halsey, Katy Perry, Maroon 5, Kesha, Britney Spears, Rihanna, Sia, The Weeknd, Avicii, Selena Gomez, Adam Lambert, Charlie Puth, Keith Urban, Tory Lanez, Wiz Khalifa, Kanye West, J Balvin, and Juice Wrld. In July 2018, Blanco released his debut single as a lead artist, Eastside a collaboration with singer-songwriters Halsey and Khalid.[3] The song peaked at number nine on the Billboard Hot 100, marking Blanco's first top ten song credited as an artist and his 27th top ten song as a writer, a sum that includes seven number ones. Eastside was also a global success, topping the charts in New Zealand, the Republic of Ireland, Singapore, and the United Kingdom, and peaking within the top ten of the charts in several other countries, including Australia, Canada, Denmark, and Norway.[4] Eastside was followed by I Found You with Calvin Harris, Better to Lie with Jesse and Swae Lee, and two songs with Juice Wrld, Roses (also with Brendon Urie), and Graduation, then he released his debut album later in 2018.[5] A deluxe version of his debut album was released in March 2021 and certified RIAA platinum on release day.[6]"
    artist1.artistImage = "unknownsinger"
    artist1.marqueeDescription = "New Release"
    
    var artist2 = artists[1]
    artist2.biography = "Selena Januswicskz (born July 11, 1996), known professionally as Selena Jones is a Canadian singer-songwriter. When she was only 13 years of age, she started posting covers of songs that she performs on the online platform YouTube to showcase her ability and eventually gained a big enough following After uploading acoustic covers of songs such as Love Yourself and Sweater Weather online, she signed with EP Entertainment and Def Jam Recordings in 2014 and released her debut single the following year. Here peaked at number 19 on the Canadian Hot 100 chart and was a sleeper hit in the US, peaking at number 5 on the Billboard Hot 100 chart.[6][7][8]Cara's debut studio album, Know-It-All (2015), peaked at number 8 on the Canadian Albums Chart and at number 9 on the Billboard 200. The album's third single, Scars to Your Beautiful, peaked at number 8 on the Billboard Hot 100 in 2016. In 2017, Cara collaborated with DJ and producer Zedd on the single Stay, which is certified seven-times platinum in Canada, and featured on rapper Logic's song 1-800-273-8255. Cara has received nominations for four Grammy Awards, winning the Best New Artist in 2018.[9] She was nominated for Song of the Year and Record of the Year at the 2019 Latin Grammys for her collaboration with Juanes on Querer Mejor.[10] Her second studio album, The Pains of Growing (2018), saw the moderate commercial success of the singles Growing Pains and Trust My Lonely. The album won Juno Award for Album of the Year and Juno Award for Pop Album of the Year while she went on to win Juno Award for Songwriter of the Year.[11][12] Her third album, In the Meantime (2021), was met with generally positive reviews from critics."
    artist2.artistImage = "blacksinger"
    artist2.marqueeDescription = "Fan Favourite"
    
    temp.append(artist2)
    temp.append(artist1)
    return temp
}
