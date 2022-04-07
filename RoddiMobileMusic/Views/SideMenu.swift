//
//  SideMenu.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 4/6/22.
//

import SwiftUI

struct SideMenu: View {
    @Binding var selectedTab: String
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            //profile picture
            Image("profile")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .cornerRadius(10)
            //top padding for top close button
                .padding(.top, 50)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Simba Dombodzvuku") //user name comes here
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .shadow(radius: 10) //use glow from neumorphism
                
                Button {
                    
                } label: {
                    Text("View Profile")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.7)
                }
            }
            
            //tab buttons
            VStack(alignment: .leading, spacing: 10) {
                TabButton(image: "house", title: "Home", selectedTab: $selectedTab, animation: animation)
                TabButton(image: "music.note", title: "My Playlists", selectedTab: $selectedTab, animation: animation)
                TabButton(image: "clock", title: "History", selectedTab: $selectedTab, animation: animation)
                TabButton(image: "gear", title: "Settings", selectedTab: $selectedTab, animation: animation)
                TabButton(image: "questionmark.circle", title: "Help", selectedTab: $selectedTab, animation: animation)
                
            }
            .padding(.leading, -15)
            .padding(.top, 50)
            
            Spacer()
            
            //Sign out button
            VStack(alignment: .leading, spacing: 6) {
                TabButton(image: "rectangle.lefthalf.inset.fill.arrow.left", title: "Logout", selectedTab: .constant(""), animation: animation)
                    .padding(.leading, -15)
                
                Text("App version 1.2.17")
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .opacity(0.6)
                    .padding(.bottom, 10)
            }
        }
        .padding()
        .frame(maxWidth:.infinity, maxHeight:.infinity, alignment: .topLeading)

    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
