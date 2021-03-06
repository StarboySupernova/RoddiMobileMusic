//
//  ArtistHome.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/1/22.
//

import SwiftUI

struct ArtistHome: View {
    
    @Binding var artist: Artist?  //binding still to be worked out
    
    @State private var currentTab = TabHeadings.Popular
    //Binding to artist stored elsewhere to be added
    @State private var artistAlbums: [Album] = []
    
    @State private var tracks: [Track] = []
    
    @State private var allAlbums = albums
    @State private var listeners: Int = 144
    
    //Smooth sliding effect
    @Namespace var animation
    @State private var headerOffsets: (CGFloat, CGFloat) = (0,0)
    
    var sortedAlbumYears: [String] {
        var releaseYears: [String] = []
        for album in artistAlbums {
            if album.releaseYear == nil {
                continue
            } else {
                releaseYears.append(album.releaseYear!)
            }
        }
        return releaseYears.sorted(by: >)
    }
    
    func getAlbums(){
        let albums = albums.filter { selected in
            selected.albumArtistName == self.artist?.artistName
        }
        self.artistAlbums = albums
    }
    
    func getTracks(){
        let tracks = albums.flatMap { album in
            album.tracks.filter { track in
                track.artist == self.artist?.artistName //binding to be added here too
            }
        }
        self.tracks = tracks
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0){
                HeaderView()
                
                //Pinned header with content
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        switch currentTab {
                        case .Popular :
                            PopularList()
                        case .Songs :
                            SongList()
                        case .Albums :
                            AlbumList()
                                .padding(.horizontal, 10)
                        case .Suggested :
                            SuggestedList()
                        default :
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                        }

                    } header: {
                        PinnedHeaderView()
                            .background {
                                Color.black
                            }
                            .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
                            .modifier(OffsetModifier(offset: $headerOffsets.0, returnFromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                    }
                }
            }
        }
        .onAppear(perform: {
            getAlbums()
            getTracks()
        })
        .background {
            LinearGradient(mycolors: Color.darkStart, Color.darkEnd)
                .frame(height: getRect().height)
        }
        .overlay(content: {
            Rectangle()
                .fill(.black)
                .frame(height: 50)
                .frame(maxHeight: .infinity, alignment: .top)
                .opacity(headerOffsets.0 < 5 ? 1 : 0)
        })
        .coordinateSpace(name: "SCROLL")
        .ignoresSafeArea(.container, edges: .vertical)
    }
    
    //Pinned content
    @ViewBuilder
    func PopularList() -> some View {
        VStack(spacing: 20) {
            ForEach($artistAlbums) { $artistAlbum in
                VStack {
                    HStack(spacing: 12) {
                        
                        Text("\(getIndex(album: artistAlbum) + 1)")
                            .fontWeight(.light)
                            .foregroundColor(.white)
                        
                        Image(artistAlbum.albumImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55, height: 55)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(artistAlbum.albumName)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Label {
                                HStack {
                                    Text("\(listeners)k listeners")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text(artistAlbum.releaseYear ?? "new")
                                        .kerning(3)
                                        .padding(.trailing, 5)
                                        .foregroundColor(.white)
                                }
                            } icon: {
                                Image(systemName: "headphones")
                                    .foregroundColor(.orange)
                            }
                            .foregroundColor(.gray)
                            .font(.caption)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            artistAlbum.isLiked.toggle()
                        } label: {
                            Image(systemName: artistAlbum.isLiked ? "heart.circle" : "suit.heart")
                                .font(.title3)
                                .foregroundColor(artistAlbum.isLiked ? .orange : .white)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title3)
                                .foregroundColor(.orange)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .padding()
        .padding(.top, 25)
        .padding(.bottom, 150)
    }
    
    @ViewBuilder
    func AlbumList() -> some View {
        ForEach(sortedAlbumYears) { albumYear in
            
            Section(content: {
                VStack(spacing: 20) {
                    ForEach($artistAlbums.filter({ currentAlbum in
                        currentAlbum.releaseYear.wrappedValue! == albumYear //potential for runtime error here, solution needed
                    })) { $artistAlbum in
                        HStack(spacing: 12) {
                            Image(artistAlbum.albumImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(artistAlbum.albumName)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                
                                Label {
                                    Text("\(listeners)k listeners")
                                } icon: {
                                    Image(systemName: "headphones")
                                        .foregroundColor(.orange)
                                }
                                .foregroundColor(.gray)
                                .font(.caption)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                artistAlbum.isLiked.toggle()
                            } label: {
                                Image(systemName: artistAlbum.isLiked ? "heart.circle" : "suit.heart")
                                    .font(.title3)
                                    .foregroundColor(artistAlbum.isLiked ? .orange : .white)
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.title3)
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 10)
                .background {
                    Background()
                        .cornerRadius(15, corners: [.topRight, .topLeft, .bottomLeft])
                        .opacity(0.2)
                }
            }, header: {
                Text(albumYear)
                    .fontWeight(.ultraLight)
                    .kerning(2)
                    .foregroundColor(.white)
                    .padding()
            })
        }
    }

    
    @ViewBuilder
    func SongList() -> some View {
        /*
         Bug: When user scrolls down to end of songs list and attempts to move to new tab on iPhone SE, the screen blacks out
         */
        VStack(spacing: 20) {
            ForEach($tracks) { $track in
                HStack(spacing: 12) {
                    
                    Text("\(track.trackNumber != nil ? track.trackNumber! + 1 : 1)")
                        .fontWeight(.ultraLight)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(track.trackName)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        //might want to put a for each to create sections for each album
                        Text(track.parentAlbumName)
                            .fontWeight(.ultraLight)
                            .foregroundColor(.white)
                        
                        Label {
                            Text("Genre: " + (track.genre ?? "Generic"))
                                .foregroundColor(.white)
                        } icon: {
                            Image(systemName: "music.note")
                                .foregroundColor(.white)
                        }
                        .foregroundColor(.gray)
                        .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        track.isLiked.toggle()
                    } label: {
                        Image(systemName: track.isLiked ? "heart.circle" : "suit.heart")
                            .font(.title3)
                            .foregroundColor(track.isLiked ? .orange : .white)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .foregroundColor(.orange)
                    }
                }
            }
        }
        .padding()
        .padding(.top, 25)
        .padding(.bottom, 150)
    }
    
    @ViewBuilder
    func SuggestedList() -> some View {
        VStack(spacing: 20) {
            ForEach($allAlbums) { $baseAlbum in
                
                Section {
                    HStack(spacing: 12) {
                        Image(baseAlbum.albumImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55, height: 55)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(baseAlbum.albumName)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Label {
                                HStack {
                                    Text("\(listeners)k listeners")
                                    Spacer()
                                    Text(baseAlbum.releaseYear ?? "new")
                                        .kerning(3)
                                        .padding(.trailing, 5)
                                }
                            } icon: {
                                Image(systemName: "headphones")
                                    .foregroundColor(.orange)
                            }
                            .foregroundColor(.gray)
                            .font(.caption)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            baseAlbum.isLiked.toggle()
                        } label: {
                            Image(systemName: baseAlbum.isLiked ? "heart.circle" : "suit.heart")
                                .font(.title3)
                                .foregroundColor(baseAlbum.isLiked ? .orange : .white)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title3)
                                .foregroundColor(.orange)
                        }
                    }
                    .padding(.vertical, 35)
                    .padding(.horizontal, 10)
                    .background {
                        Background()
                            .cornerRadius(15, corners: [.topRight, .topLeft, .bottomRight])
                            .opacity(0.1)
                    }
                } header: {
                    Text(baseAlbum.albumArtistName)
                        .foregroundColor(.BG)
                }
            }
        }
        .padding()
        .padding(.top, 25)
        .padding(.bottom, 150)
    }
    
    func getIndex(album: Album) -> Int {
        return artistAlbums.firstIndex { currentAlbum in
            album.id == currentAlbum.id
        } ?? 0 //should be sorted by popularity
    }
    
    //Header view
    @ViewBuilder func HeaderView() -> some View {
        GeometryReader{ geometry in
            let minY = geometry.frame(in: .named("SCROLL")).minY
            let size = geometry.size
            let height = (size.height + minY) // using this value for height makes the image stretch when pulled down
            
            Image(artist?.artistImage ?? "singer") // enum of image names to be added
                .resizable()
                .aspectRatio(4/3, contentMode: .fill)
                .frame(width: size.width, height: height > 0 ? height : 0, alignment: .top)
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        //Dimming out the text content
                        LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Artist")
                                .font(.callout)
                                .foregroundColor(.orange)
                                .shadow(color: .black, radius: 10, x: 2, y: 2)
                            
                            HStack(alignment: .bottom, spacing: 10) {
                                Text(artist?.artistName ?? "unknown artist")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.orange)
                                    .background {
                                        Circle()
                                            .fill(.white)
                                    }
                            }
                            
                            Label {
                                Text("Monthly Listeners")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white.opacity(0.7))
                            } icon: {
                                Text("144k")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.orange)
                            }
                            .font(.caption)
                            
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                })
                .cornerRadius(25)
                .background {
                    Color.black
                }
                .offset(y: -minY) //makes image adapt its size to content onscreen
        }
        .frame(height: 250)
    }
    
    //Pinned header
    @ViewBuilder
    func PinnedHeaderView() -> some View {
        
        let headers = TabHeadings.allCases
        
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { value in
                
                HStack(spacing: 25) {
                    
                    ForEach(headers, id: \.self) { tabHeader in
                        VStack(spacing: 12) {
                            Text(tabHeader.rawValue)
                                .fontWeight(.semibold)
                                .foregroundColor(currentTab == tabHeader ? .white : .gray)
                            
                            
                            ZStack {
                                if currentTab == tabHeader {
                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                        .fill(.orange)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                } else {
                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                        .fill(.clear)
                                }
                            }
                            .padding(.horizontal, 8)
                            .frame(height: 4)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                currentTab = tabHeader
                                value.scrollTo(tabHeader, anchor: .center)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 25)
                .padding(.bottom, 5)
            }
        }
    }
}

struct ArtistHome_Previews: PreviewProvider {
    static var previews: some View {
        ArtistHome(artist: .constant(sampleArtists[1]))
    }
}
