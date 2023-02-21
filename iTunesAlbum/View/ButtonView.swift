//
//  ButtonView.swift
//  iTunesAlbum
//
//  Created by Jaafar Zubaidi  on 2/17/23.
//

import SwiftUI
//import CoreData
//struct ButtonView: View {
//    @ObservedObject var vm: CoreDataViewModel = CoreDataViewModel()
//    var album: Results
//
//    var body: some View {
//        Button {
//            let fetchRequest: NSFetchRequest<ResultEntity> = ResultEntity.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "id = %@", album.id ?? "")
//
//            do {
//                let result = try vm.container.viewContext.fetch(fetchRequest)
//                let favoriteAlbum = result.first
//                if vm.selectedAlbumId == album.id {
//                    vm.selectedAlbumId = nil
//                    vm.deleteFavorite(album: album)
//                } else {
//                    vm.selectedAlbumId = album.id
//                    vm.addFavorite(text: album.name , id: album.id ?? "", releaseDate: album.releaseDate ?? "" , kind: album.kind , artworkUrl100: album.artworkUrl100 , artistName: album.artistName ?? "")
//                }
//                let isAlbumFavorite = vm.isFavorite(album: album, favoriteAlbum: favoriteAlbum)
//            } catch {
//                print("Error fetching favorite album: \(error)")
//            }
//        }
//        label: {
//            Image(systemName: vm.selectedAlbumId == album.id ? "suit.heart.fill" : "suit.heart")
//                .resizable()
//                .frame(width: 50, height: 50)
//                .shadow(radius: 30)
//        }
//    }
//}

struct ButtonView: View {
    @ObservedObject var vm: CoreDataViewModel = CoreDataViewModel()
    var album: Results
    @State var isFavorite: Bool = false

    var body: some View {
        Button {
          
            if vm.isFavorite(album: album) {
                vm.deleteFavorite(album: album)
            } else {
                vm.addFavorite(text: album.name , id: album.id ?? "", releaseDate: album.releaseDate ?? "" , kind: album.kind , artworkUrl100: album.artworkUrl100 , artistName: album.artistName ?? "")
            }
            
            isFavorite.toggle()
        }
        label: {
            Image(systemName: isFavorite ? "suit.heart.fill" : "suit.heart")
                .resizable()
                .frame(width: 50, height: 50)
                .shadow(radius: 30)
        }
        .onAppear {
            isFavorite = vm.isFavorite(album: album)
        }
    }
}


