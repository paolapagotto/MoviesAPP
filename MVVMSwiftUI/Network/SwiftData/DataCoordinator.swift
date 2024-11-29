//
//  DataCoordinator.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 18/04/2024.
//

import Foundation
import SwiftData
import SwiftUI
import UIKit

@MainActor
class DataCoordinator: ObservableObject {
    static let identifier: String = "[DataCoordinator]"
    static let shared: DataCoordinator = DataCoordinator()
    //let configuration: Configuration = Configuration()
    
    let persistantContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: Item.self,
                configurations: ModelConfiguration()
            )
            return container
        } catch {
            fatalError("Failed to create a container")
        }
    }()
}
