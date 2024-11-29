//
//  URLCache+Extension.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 05/07/2024.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
