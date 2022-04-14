//
//  TrackHistoryCardView.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/9/22.
//

import SwiftUI

struct TrackHistoryCardView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("History")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 20) {
                //Progress ring
                ZStack {
                    ForEach(rings.indices, id: \.self) { index in
                            AnimatedRingView(ring: rings[index], index: index)
                    }
                }
                .frame(width: 130, height: 130)
                
                VStack(alignment: .leading, spacing: 12) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ForEach(rings){ ring in
                            //use getRect solution for iPhone SE
                            Label {
                                HStack(alignment: .bottom, spacing: 6) {
                                    Text("\(Int(ring.rawData))")
                                        .font(.title2)
                                        .fontWeight(.light)
                                        .padding(.trailing, 10)
                                    
                                    Text(ring.value)
                                        .font(.callout)
                                        .fontWeight(.thin)
                                    
                                    Spacer()
                                }
                            } icon: {
                                Group {
                                    if ring.isText {
                                        Text(ring.keyIcon)
                                            .font(.title2)
                                    } else {
                                        Image(systemName: ring.keyIcon)
                                            .font(.callout)
                                    }
                                }
                                .frame(width: 30)
                            }

                        }
                    }
                }
                .padding(.leading, 10)
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.ultraThinMaterial)
        }
    }
}

struct TrackHistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryWrappingView()
    }
}

//Animating rings
struct AnimatedRingView: View {
    var ring: Ring
    var index: Int
    @State var showRing: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray.opacity(0.3), lineWidth: 10)
            
            Circle()
                .trim(from: 0, to: showRing ? rings[index].progress / 100 : 0)
                .stroke(rings[index].keyColor, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(.init(degrees: -90))
        }
        .padding(CGFloat(index * 16))
        .onAppear {
            //shows after initial animation has finished
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.interactiveSpring(response: 1, dampingFraction: 1, blendDuration: 1).delay(Double(index) * 0.1)) {
                    showRing = true
                }
            }
        }
    }
}
