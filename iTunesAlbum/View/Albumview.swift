//
//  Albumview.swift
//  iTunesAlbum
//
//  Created by Jaafar Zubaidi  on 2/14/23.


import SwiftUI

struct Albumview: View {
    private let adaptiveColumns = [GridItem(.adaptive(minimum: 150))]
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @StateObject var vm: CoreDataViewModel = CoreDataViewModel()
    @State var textFieldText: String = ""
    @State var isPressed: Bool = false
    @State private var isButtonEnabled = false
   
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(viewModel.album) { value in
                    VStack {
                        Spacer()
                        AsyncImage(url: URL(string: value.artworkUrl100))
                            .cornerRadius(20)
                            .frame(width: 100, height: 100)
                            .padding(.bottom)
                        
                        ButtonView(album: value)
                            .foregroundColor(.red)
                        
//                        NavigationLink {
//
//                        } label: {
//
//                        }

                        
                        NavigationLink(value.name) {
                            AsyncImage(url: URL(string: value.artworkUrl100)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            List {
                                Section{
                                    Text("Name: \(value.name)")
                                    Text("kind: \(value.kind)")
                                    Text("artistName: \(value.artistName ?? " ")")
                                    Text("ReleaseDate: \(value.releaseDate ?? " ")")
                                    Text("ID: \(value.id ?? " ")")
                                }
                                
                                ButtonView(album: value).foregroundColor(.red)
                                    .padding(.horizontal, 200.0)
                            }
                            
                        }.foregroundColor(.black)
                            .bold()
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                        Divider()
                            .overlay(.black)

                    }
                    
                }
              
            }
            //.animation(.easeInOut(duration: 0.3), value: viewModel.album.count)
            .navigationTitle("Album View")
           .navigationBarTitleDisplayMode(.inline)
            
            .onAppear {
                // Here you'll perform step 3
                viewModel.albumFatchList()
            }
            
        }
        .background(Image("backgroundImage2").resizable()
            .blur(radius: 50))
        
    }
    
}

struct Album_Previews: PreviewProvider {
    static var previews: some View {
        Albumview()
    }
}

