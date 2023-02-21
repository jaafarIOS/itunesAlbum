//
//  Favorite.swift
//  iTunesAlbum
//
//  Created by Jaafar Zubaidi  on 2/14/23.
//

import SwiftUI

struct Favorite: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @ObservedObject var vm: CoreDataViewModel = CoreDataViewModel()
    
    //@State
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                
                
                List {
                    ForEach(vm.saveResults){ entity in
                        
                        
                        NavigationLink(entity.name ?? ""){
                            detailView(album: entity)
                            
                        }
                        
                    }//.onDelete(perform: vm.deleteFavorite)
                    
                }
                .listStyle(PlainListStyle())
                VStack{
                    Button {
                        vm.clearAllData()
                    } label: {
                        Text("Clear")
                    }
                }

            }
                .onAppear {
                    vm.fetchResult()
                    
                }
              .navigationTitle("Favorite")
             .background(Image("watercolor-2681039__480").resizable()
            .blur(radius: 50))
           
            
            
        }
      
    }
}

struct Favorite_Previews: PreviewProvider {
    static var previews: some View {
        Favorite()
    }
}

