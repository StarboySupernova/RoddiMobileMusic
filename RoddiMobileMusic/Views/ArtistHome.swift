//
//  ArtistHome.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/1/22.
//

import SwiftUI

struct ArtistHome: View {
    
    @State private var currentTab = TabHeadings.Popular
    //Binding to artist stored elsewhere to be added
    @State private var artistAlbums: [Album] = albums.filter { music in
        music.albumArtistName == "Didier Thauvin" //binding to be added here
    }
    @State private var tracks: [Track] = albums.flatMap { album in
        album.tracks.filter { track in
            track.artist == "Didier Thauvin" //binding to be added here too
        }
    }
    
    //Smooth sliding effect
    @Namespace var animation
    @State private var headerOffsets: (CGFloat, CGFloat) = (0,0)
    
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
                        default :
                            VStack{}
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
                HStack(spacing: 12) {
                    
                    Text("\(getIndex(album: artistAlbum) + 1)")
                        .fontWeight(.ultraLight)
                        .foregroundColor(.white)
                    
                    Image(artistAlbum.albumImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(artistAlbum.albumName)
                            .fontWeight(.semibold)
                        
                        Label {
                            Text("144k")
                        } icon: {
                            Image(systemName: "beats.headphones")
                                .foregroundColor(.white)
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
                            .foregroundColor(artistAlbum.isLiked ? .green : .white)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .padding(.top, 25)
        .padding(.bottom, 150)
    }
    
    @ViewBuilder
    func SongList() -> some View {
        
        VStack(spacing: 20) {
            ForEach($tracks) { $track in
                HStack(spacing: 12) {
                    
                    Text("\(track.trackNumber != nil ? track.trackNumber! + 1 : 1)")
                        .fontWeight(.ultraLight)
                        .foregroundColor(.white)
                    
                    /*Image(artistAlbum.albumImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))*/
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(track.trackName)
                            .fontWeight(.semibold)
                        //might want to put a for each to create sections for each album
                        Text(track.parentAlbumName)
                            .fontWeight(.ultraLight)
                        
                        Label {
                            Text("144k")
                        } icon: {
                            Image(systemName: "beats.headphones")
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
                            .foregroundColor(track.isLiked ? .green : .white)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
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
        } ?? 0
    }
    
   /* func getIndex(song: Track) -> Int {
        return artistAlbums.firstIndex { currentSong in
            song.id == currentSong.id
        } ?? 0
    } */
    
    //Header view
    @ViewBuilder func HeaderView() -> some View {
        GeometryReader{ geometry in
            let minY = geometry.frame(in: .named("SCROLL")).minY
            let size = geometry.size
            let height = (size.height + minY) // using this value for height makes the image stretch when pulled down
            
            Image("unknownsinger")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: height > 0 ? height : 0, alignment: .top)
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        //Dimming out the text content
                        LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Artist")
                                .font(.callout)
                                .foregroundColor(.gray)
                            
                            HStack(alignment: .bottom, spacing: 10) {
                                Text("Didier Thauvin")
                                    .font(.title)
                                    .bold()
                                
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                                    .background {
                                        Circle()
                                            .fill(.white)
                                        //.padding(3)
                                    }
                            }
                            
                            Label {
                                Text("Monthly Listeners")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white.opacity(0.7))
                            } icon: {
                                Text("144k")
                                    .fontWeight(.semibold)
                            }
                            .font(.caption)
                            
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                })
                .cornerRadius(15)
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
                                        .fill(.white)
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
        ArtistPage()
    }
}
