//
//  Background.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/10/22.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            LinearGradient(mycolors: Color.darkStart, Color.BG)

            VStack {
                Circle()
                    .fill(Color.BG)
                    .scaleEffect(0.6)
                    .offset(x: 20)
                    .blur(radius: 120)
                
                Circle()
                    .fill(Color.orange)
                    .scaleEffect(0.6, anchor: .leading)
                    .offset(y: -20)
                    .blur(radius: 120)

            }
                                    
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
