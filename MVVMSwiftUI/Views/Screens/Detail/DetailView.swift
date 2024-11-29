//
//  ProfileView.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 15/04/2024.
//

import SwiftUI

//MARK: - VIEW
struct DetailView: View {
    //(1)@State var viewModel: ProfileViewModel = ProfileViewModel()
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            //(1)(2)ProfileInfoView(viewModel: //(1)$viewModel //(2)viewModel)
            //(1)(2)ProfileActionsView(viewModel: //(1)$viewModel //(2)viewModel))
            DetailInfoView(viewModel: viewModel)
            DetailActionsView(viewModel: viewModel)
        }
        .animation(.easeInOut, value: viewModel.hasWatched)
        //(3).environmentObject(viewModel)
        .navigationTitle(viewModel.movie.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailInfoView: View {
    //(1)@Binding var viewModel: DetailViewModel
    /*(2)*/@ObservedObject var viewModel: DetailViewModel
    //(3)@EnvironmentObject var viewModel: DetailViewModel
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .background(.black)
                .padding(0)
            
            VStack(spacing: 8) {
                HStack {
                    CachedAsyncImage(url: viewModel.movie.poster, urlCache: .imageCache) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            //.scaledToFill()
                            .frame(height: 480)
                            .padding(.bottom, 10)
                        
                    } placeholder: {
                        ProgressView()
                            .frame(height: 480)
                    }
                    
//                    AsyncImage(url: viewModel.movie.poster) { image in
//                        image.resizable()
//                            .aspectRatio(contentMode: .fit)
//                            //.scaledToFill()
//                            .frame(height: 480)
//                            .padding(.bottom, 10)
//                        
//                    } placeholder: {
//                        ProgressView()
//                            .frame(height: 480)
//                    }
                }
                
                
                VStack {
                    Text(viewModel.movie.title ?? "")
                        .font(.system(size: 24, weight: .bold))
                    
                    Text(viewModel.movie.year ?? "")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                }
            }
            .padding([.leading, .trailing], 16)
            
        }
    }
}

struct DetailActionsView: View {
    //(1)@Binding var viewModel: DetailViewModel
    /*(2)*/@ObservedObject var viewModel: DetailViewModel
    //(3)@EnvironmentObject var viewModel: DetailViewModel
    
    var body: some View {
        VStack {
            Button {
                viewModel.watchedToogle()
            } label: {
                Label(viewModel.hasWatched ? "watched": "already watched",
                      systemImage: viewModel.hasWatched ? "checkmark.circle.fill" : "checkmark.circle")
                    .font(.title3)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .controlSize(.large)
            .padding([.leading, .trailing], 16)
            .tint(viewModel.hasWatched ? .green : .blue)
            
            Button { } label: {
                Label("review", systemImage: "star.fill")
                    .font(.title3)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .controlSize(.large)
            .padding([.leading, .trailing], 16)
            .disabled(!viewModel.hasWatched)
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(viewModel: DetailViewModel(
            movie: MovieDTO(imdbId: "", title: "SpiderMan", year: "2002"))
        )
    }
}
