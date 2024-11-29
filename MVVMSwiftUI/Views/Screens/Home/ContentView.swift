//
//  ContentView.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 15/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        List {
            if viewModel.movies.isEmpty {
                VStack(alignment: .center) {
                    Spacer()
                    Text("🍿 🎬")
                    Spacer()
                    Text("Use the search bar to find your movie")
                        .padding(.leading, 4)
                    Spacer()
                }.frame(height: 90)
            } else {
                ForEach(viewModel.movies, id:\.self) { movie in
                    NavigationLink(
                        destination: DetailView(
                            viewModel: DetailViewModel(movie: movie)),
                        label: {
                            HStack(spacing: 4) {
                                HStack {
                                    CachedAsyncImage(url: movie.poster, urlCache: .imageCache) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            //.scaledToFill()
                                            .frame(height: 48)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(height: 48)
                                            
                                    }
                                }
                            }
                            Text(movie.title ?? "")
                                .padding(.leading, 4)
                    })
                }
            }
        }
        .searchable(text: $viewModel.search)
        .onAppear {
            viewModel.setupSearchPublisher()
        }
        .onChange(of: viewModel.search) {
            viewModel.searchSubject.send(viewModel.search)
        }
        .navigationTitle("Movies")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    NavigationStack {
        ContentView()
            //.modelContainer(for: Item.self, inMemory: true)
    }
    
}
