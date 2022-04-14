//
//  HistoryWrappingView.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/8/22.
//

import SwiftUI

struct HistoryWrappingView: View {
    @State var showView: Bool = true
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            if showView {
                HistoryView()
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            ZStack {
                LinearGradient(mycolors: Color.darkStart, Color.BG)
                
                VStack {
                    Circle()
                        .fill(Color.BG)
                        .scaleEffect(0.6)
                        .offset(x: 20)
                        .blur(radius: 120)
                    
                    Circle()
                        .fill(Color.red)
                        .scaleEffect(0.6, anchor: .leading)
                        .offset(y: -20)
                        .blur(radius: 120)

                }
                
                Rectangle()
                    .fill(.ultraThinMaterial)
            }
            .ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                showView = true
            }
        }
    }
}

struct HistoryWrappingView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryWrappingView()
    }
}
