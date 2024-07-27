//
//  ImageModel.swift
//  ImageSearch
//
//  Created by Denis Raiko on 27.07.24.
//

import Foundation

struct Image: Identifiable, Codable {
    let id: String
    let description: String?
    let urls: URLs
    
    struct URLs: Codable {
        let small: String
    }
}
