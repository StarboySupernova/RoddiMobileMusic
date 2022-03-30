//
//  Home.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 3/30/22.
//

import SwiftUI

struct Home: View {
    //Animation properties
    @State var expandCards = false //test these with private var
    @State var currentCard: Album?
    @State var showDetail = false
    
    var body: some View {
        VStack {
            HStack {
                Button{
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title2)
                }
                
                Spacer()
                
                Button{
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                }

            }
            .overlay {
                Text("My Playlist")
                    .fontWeight(.semibold)
            }
            .padding(.horizontal)
            .foregroundColor(.black)
            
            GeometryReader { geometry in
                let size = geometry.size //necessary to make calling frame cleaner
                stackPlayerView(size: size)
                    .frame(width: size.width, height: size.height, alignment: .center)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Recently Played")
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(albums){ album in
                            Image(album.albumImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 95, height: 95)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
            }
            
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Color.offWhite
                .ignoresSafeArea()
        }
    }
    
    //Stack player view
    @ViewBuilder func stackPlayerView (size: CGSize) -> some View {
        let offsetHeight = size.height * 0.1
        
        ZStack {
            ForEach(stackAlbums.reversed()) { album in
                
                let index = getIndex(album: album) //used to help calculate unique values for each album card imagesize, and unique tapped & untapped offset values in the y-plane
                let imageSize = (size.width - CGFloat(index) * 20)
                
                
                Image(album.albumImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize/2, height: imageSize/2)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .offset(y: CGFloat(index) * -20)
                    .offset(y: expandCards ? -CGFloat(index) * offsetHeight : 0)
                    .onTapGesture {
                        if expandCards {
                            // selecting currentCard
                        } else {
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                expandCards = true
                            }
                        }
                    }
            }
        }
        .offset(y: expandCards ? offsetHeight : 0)
    }
    
    //Array Index
    func getIndex(album: Album) -> Int {
        return stackAlbums.firstIndex { currentAlbum in
            return album.id == currentAlbum.id
        } ?? 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MusicStackView()
    }
}
