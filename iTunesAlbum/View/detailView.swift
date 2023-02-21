//
//  detailView.swift
//  iTunesAlbum
//
//  Created by Jaafar Zubaidi  on 2/14/23.
//

import SwiftUI

struct detailView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    var album: ResultEntity
    var body: some View {
        

        AsyncImage(url: URL(string: album.artworkUrl100 ?? "")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .background(.red)
        
            List {
                Section{
                    Text("Name: \(album.name ?? "")")
                    Text("kind: \(album.kind ?? " ")")
                    Text("artistName: \(album.artistName ?? " ")")
                    Text("ReleaseDate: \(album.releaseDate ?? " ")")
                    Text("ID: \(album.id ?? " ")")
                }
                
         
            
        }
    }
}


struct detailView_Previews: PreviewProvider {
    static var previews: some View {
        detailView( album: ResultEntity())
    }
}
