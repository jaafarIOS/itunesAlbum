//
//  ViewModel.swift
//  iTunesAlbum
//
//  Created by Jaafar Zubaidi  on 2/14/23.
//

import Foundation
import CoreData
class ViewModel: ObservableObject {
    @Published var coreDataViewModel: CoreDataViewModel = CoreDataViewModel()
    @Published var album: [Results] = []
    var albumAPIView: AlbumAPI = AlbumAPI()
    func fatchImage(){
        
    }
    func albumFatchList() {
        albumAPIView.fetchData { albumlist in
            DispatchQueue.main.async {
                self.album = albumlist
            }
        }
    }
}
class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var saveResults: [ResultEntity] = []
    @Published var albumPressedStates: [String: Bool] = [:]

    init(){
        container = NSPersistentContainer(name: "ResultContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Data: \(error)")
            }else {
                print("Seccufully loading data")
            }
        }
        fetchResult()
    }
    func destroyPersistentStore() throws {
        let coordinator = container.persistentStoreCoordinator
        let persistentStore = coordinator.persistentStores.first
        try coordinator.destroyPersistentStore(at: persistentStore!.url!, ofType: persistentStore!.type, options: nil)
    }
    
    func fetchResult(){
        let request = NSFetchRequest<ResultEntity>(entityName: "ResultEntity")
        do{
            saveResults = try container.viewContext.fetch(request)
            
        } catch let error {
            print("Fatch the Error .\(error)")
        }
    }
 
    func addFavorite(text: String, id: String, releaseDate: String, kind: String, artworkUrl100: String, artistName: String) {
        // Check if a favorite with the same id already exists
        let fetchRequest: NSFetchRequest<ResultEntity> = ResultEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            if results.first != nil {
                // An existing favorite was found, you could choose to update its values here if needed
                return
            }
        } catch {
            print("Error fetching favorites: \(error)")
            return
        }
        
        // If no existing favorite was found, create a new one
        let newFavorite = ResultEntity(context: container.viewContext)
        newFavorite.name = text
        newFavorite.id = id
        newFavorite.releaseDate = releaseDate
        newFavorite.kind = kind
        newFavorite.artworkUrl100 = artworkUrl100
        newFavorite.artistName = artistName
        
        saveFavorite()
    }
//
//    func updatFavorite(entity: ResultEntity) {
//        let currentName = entity.name ?? ""
//        let currentID = entity.id ?? ""
//        let currentReleaseDate = entity.releaseDate ?? ""
//        let currentKind = entity.kind ?? ""
//        let currentArtworkUrl100 = entity.artworkUrl100 ?? ""
//        let currentArtistName = entity.artistName ?? ""
//        let newName = currentName + "!"
//        entity.name = newName
//        saveFavorite()
//    }

    func deleteFavorite(album: Results) {
        let fetchRequest: NSFetchRequest<ResultEntity> = ResultEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", album.id ?? "")
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            guard let favoriteAlbum = result.first else {
                return // No favorite album found with this id
            }
            
            container.viewContext.delete(favoriteAlbum)
            try container.viewContext.save()
        } catch {
            print("Error deleting favorite album: \(error)")
        }
    }
    func isFavorite(album: Results) -> Bool {
        // Find out if the album is favorite
        let fetchRequest = NSFetchRequest<ResultEntity>(entityName: "ResultEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", album.id ?? "")

        do {
            let result = try container.viewContext.fetch(fetchRequest)
           
            if result.first != nil {
                // Album is a favorite
               //try container.viewContext.save()
                return true
            } else {
                // Album is not a favorite
               
                return false
            }
           
        } catch {
            print("Error fetching favorite album: \(error)")
            return false
        }
    }


    func saveFavorite() {
        do {
            try container.viewContext.save()
            fetchResult()
        } catch let error {
            print("Error in Saving: \(error)")
        }
    }
    func clearAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ResultEntity")

        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            
            try container.viewContext.execute(batchDeleteRequest)
            saveResults = []
        } catch {
            // handle the error
        }
        
    }
}

