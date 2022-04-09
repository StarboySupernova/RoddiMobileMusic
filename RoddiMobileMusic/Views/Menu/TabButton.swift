//
//  TabButton.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/6/22.
//

import SwiftUI

struct TabButton: View {
    var image: String
    var title: String
    
    //Selected tab
    @Binding var selectedTab: String
    //For hero animation slide
    var animation: Namespace.ID
    
    var body: some View {
        Button {
            withAnimation(.spring()) {selectedTab = title}
        } label: {
            HStack(spacing: 15) {
                Image(systemName: image)
                    .font(.title2)
                    .frame(width: 30)
                
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedTab == title ? Color.BG : .white)
            .padding(.vertical, 12)
            .padding(.horizontal, 10)
            //max available frame
            .frame(maxWidth: getRect().width - 170, alignment: .leading)
            .background {
               //hero animation
                ZStack {
                    if selectedTab == title {
                        Color.white
                            .opacity(selectedTab == title ? 1 : 0)
                            .cornerRadius(12, corners: [.topRight,.bottomRight])
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            }
        }
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
