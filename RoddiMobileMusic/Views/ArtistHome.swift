//
//  ArtistHome.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/1/22.
//

import SwiftUI

struct ArtistHome: View {
    
    @State var currentTab: String = "Popular" //test private var here
    //Smooth sliding effect
    @Namespace var animation
    @State var artistAlbums: [Album] = albums
    
    @State var headerOffsets: (CGFloat, CGFloat) = (0,0)
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0){
                HeaderView()
                
                //Pinned header with content
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        SongList()
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
    func SongList() -> some View {
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
    
    func getIndex(album: Album) -> Int {
        return artistAlbums.firstIndex { currentAlbum in
            album.id == currentAlbum.id
        } ?? 0
    }
    
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
        
        let tabHeadings: [String] = ["Popular", "Albums", "Songs", "Fans Also Like", "About Artist"]
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(tabHeadings, id: \.self) { tab in
                    VStack(spacing: 12) {
                        Text(tab)
                            .fontWeight(.semibold)
                            .foregroundColor(currentTab == tab ? .white : .gray)
                        
                        ZStack {
                            if currentTab == tab {
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
                            currentTab = tab
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

struct ArtistHome_Previews: PreviewProvider {
    static var previews: some View {
        ArtistPage()
    }
}
