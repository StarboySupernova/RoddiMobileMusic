//
//  Home.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 3/30/22.
//

import SwiftUI

struct PlaylistView: View {
    //Animation properties
    @State var expandCards = false //test these with private var
    @State var currentCard: Album?
    //Storing current card index for animating cards
    @State var currentIndex: Int = -1
    @State var showDetail = false
    //For Hero animation
    @Namespace var animation
    //Current album image size
    @State var cardSize: CGSize = .zero
    //Detail Card Animation Properties
    @State var animateDetailView: Bool = false
    @State var rotateCards: Bool = false
    @State var showDetailContent: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Button{
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                }
                
            }
            .padding(.horizontal)
            .foregroundColor(.black)
            
            GeometryReader { geometry in
                let size = geometry.size //necessary to make calling frame cleaner
                StackPlayerView(size: size)
                    .frame(width: size.width, height: size.height, alignment: .center)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Recently Played")
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(albums){ album in //true recently played functionality to be added
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
        .overlay {
            //Detail View
            if let currentCard = currentCard, showDetail {
                ZStack {
                    LinearGradient(mycolors: .white.opacity(0.95), Color.BG.opacity(0.985))
                        .ignoresSafeArea()
                    
                    DetailView(currentCard: currentCard)
                }
                
            }
        }
    }
    
    //Stack player view
    @ViewBuilder func StackPlayerView (size: CGSize) -> some View {
        let offsetHeight = size.height * 0.1
        
        ZStack {
            //we need to use reversed so that it comes out as needed
            ForEach(stackAlbums.reversed()) { album in
                
                let index = getIndex(album: album) //used to help calculate unique values for each album card imagesize, and unique tapped & untapped offset values in the y-plane
                let imageSize = (size.width - CGFloat(index) * 20)
                
                
                Image(album.albumImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize / 2, height: imageSize / 2)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                //3D Rotation
                    .rotation3DEffect(.init(degrees: expandCards && currentIndex != index ? -10 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                //Rotating current card 360°
                    .rotation3DEffect(.init(degrees: showDetail && currentIndex == index && rotateCards ? 360 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                    .matchedGeometryEffect(id: album.id, in: animation)
                    .offset(y: CGFloat(index) * -20)
                    .offset(y: expandCards ? -CGFloat(index) * offsetHeight : 0)
                    .onTapGesture {
                        if expandCards {
                            // selecting currentCard
                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                                cardSize = CGSize(width: imageSize / 2, height: imageSize / 2)
                                currentCard = album
                                currentIndex = index
                                showDetail = true
                                rotateCards = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation(.spring()) {
                                        animateDetailView = true
                                    }
                                }
                                
                            }
                        } else {
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                expandCards = true
                            }
                        }
                    }
                //Current card will stay center, top card will move to the top, bottom card will move to the bottom
                    .offset(y: showDetail && currentIndex != index ? size.height * (currentIndex < index ? -1 : 1) : 0)
            }
        }
        .offset(y: expandCards ? offsetHeight * 2 : 0)
        .frame(width: size.width, height: size.height)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                expandCards.toggle()
            }
        }
    }
    
    //Detail View
    @ViewBuilder func DetailView(currentCard: Album) -> some View {
        VStack(spacing: 0) {
            Button {
                rotateCards = true
                withAnimation {
                    showDetailContent = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                        self.currentIndex = -1
                        self.currentCard = nil
                        showDetail = false
                        animateDetailView = false
                    }
                }
            } label: {
                
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.horizontal, .top])
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 25) {
                    Image(currentCard.albumImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: cardSize.width, height: cardSize.height)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    //Initial rotation
                        .rotation3DEffect(.init(degrees: showDetail && rotateCards ? -180 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                        .rotation3DEffect(.init(degrees: animateDetailView && rotateCards ? 180 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                        .matchedGeometryEffect(id: currentCard.id, in: animation)
                        .padding(.top, 50)
                    
                    VStack(spacing: 20){
                        Text(currentCard.albumName)
                            .font(.title3)
                            .bold()
                            .padding(.top, 10)
                        
                        HStack(spacing: 50){
                            Button {
                                
                            } label: {
                                Image(systemName: "shuffle")
                                    .font(.title2)
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "pause.fill")
                                    .font(.title3)
                                    .frame(width: 55, height: 55)
                                    .background {
                                        Circle()
                                            .fill(Color.BG)
                                    }
                                    .foregroundColor(.white)
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "arrow.2.squarepath")
                                    .font(.title2)
                            }
                            
                        }
                        .foregroundColor(.black)
                        .padding(.top, 10)
                        
                        Text("Upcoming Song")
                            .font(.title3)
                            .bold()
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(albums) { album in
                            AlbumCardView(album: album)
                        }
                    }
                    .padding(.horizontal)
                    .offset(y: showDetailContent ? 0 : 300)
                    .opacity(showDetailContent ? 1 : 0)
                }
                .frame(maxWidth: .infinity)
            }
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.easeInOut){
                    showDetailContent = true
                }
            }
        }
    }
    
    //Album Card View
    @ViewBuilder func AlbumCardView(album: Album) -> some View {
        HStack(spacing: 12){
            Image(album.albumImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(album.albumName)
                    .fontWeight(.semibold)
                
                Label {
                    Text("144k")
                } icon: {
                    Image(systemName: "beats.headphones")
                }
                .font(.caption)
                .foregroundColor(.gray)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            
            Button {
                
            } label: {
                Image(systemName: album.isLiked ? "suit.heart.fill" : "suit.heart")
                    .font(.title3)
                    .foregroundColor(album.isLiked ? .red : .gray)
            }
            
            
        }
    }
    
    //Array Index
    func getIndex(album: Album) -> Int {
        return stackAlbums.firstIndex { currentAlbum in
            return album.id == currentAlbum.id
        } ?? 0
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}
