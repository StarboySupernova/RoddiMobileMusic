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
            Home()
                .tag("Home")
            PlaylistView()
                .tag("My Playlists")
            HistoryWrappingView()
                .tag("History")
            
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}

//Sub views - temporary use. To be removed and will call the respective views directly
struct HomePage: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("Welcome")
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

struct History: View {
    var body: some View {
        NavigationView {
            HistoryWrappingView()
                .navigationTitle("History")
        }
    }
}
