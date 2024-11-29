//
//  ProfileViewModel.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 15/04/2024.
//

import Foundation
import SwiftUI
import SwiftData

//MARK: - VIEW MODEL
class DetailViewModel: ObservableObject {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @Published var hasWatched = false
    @Published var userFollowers: String = ""
    @Published var movie: MovieDTO
    
    init(movie: MovieDTO) {
        self.movie = movie
        loadFollowers()
    }
    
    func getObject(id: String) {
         
    }
    
    func watchedToogle() {
        self.hasWatched.toggle()
        //addItem(with: movie.id)
        self.updateFollowerCount()
        self.loadFollowers()
    }
    
    func updateFollowerCount() {
        //self.isFollowing ? (self.movie.followers += 1) : (self.movie.followers -= 1)
    }
    
    func loadFollowers() {
        self.userFollowers = customizerNumber(value: movie.followers ?? 0)
    }
    
    private func addItem(with id: String) {
        withAnimation {
            let newItem = Item(timestamp: Date(), id: id, watched: self.hasWatched)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    private func customizerNumber(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "pt_BR")
        let shorten = formatter.string(for: value) ?? "0"
        return "\(shorten)K"
    }
}
