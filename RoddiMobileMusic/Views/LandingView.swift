//
//  ContentView.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 3/29/22.
//

import SwiftUI

struct LandingView: View {
    @Binding var selectedTab: String
    
    //hiding tab bar
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true //experiment with isTranslucent
    }
    
    var body: some View {
        //Tab view with tabs
        TabView(selection: $selectedTab) {
            //Views
            HomePage()
                .tag("Home")
            Playlists()
                .tag("My Playlists")
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//Sub views
struct HomePage: View {
    var body: some View {
        NavigationView {
            Text("Home")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Home")
        }
    }
}

struct Playlists: View {
    var body: some View {
        NavigationView {
            PlaylistView()
                .navigationTitle("My Playlists")
        }
    }
}
