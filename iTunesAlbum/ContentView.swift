//
//  ContentView.swift
//  iTunesAlbum
//
//  Created by Jaafar Zubaidi  on 2/14/23.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader{ Geometry in
                }.background(.purple)
                
                TabView {
                    Albumview()
                        .tabItem {
                            Label("Albums", systemImage: "rectangle.stack.badge.play.fill")
                        }
                    
                    Favorite()
                        .tabItem {
                            Label("Favorite", systemImage: "star.square.fill")
                        }
                }
                .onAppear {
                    // Here you'll perform step 3
                    AlbumAPI().fetchData { results in
                        print("Results: \(results)")
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
       
    }
}

