//
//  ImageSearchViewModel.swift
//  ImageSearch
//
//  Created by Denis Raiko on 27.07.24.
//

import SwiftUI
import Combine

class ImageSearchViewModel: ObservableObject {
    @Published var images = [Image]()
    private var cancellables = Set<AnyCancellable>()
    private let apiKey = "9GZuBgHf6ai88k15IzdyUqQ2wOWlm-bH-9-9jhp0FFM"
    
    func searchImages(query: String) {
        guard !query.isEmpty else { return }
        
        let urlString = "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ImageResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] images in
                self?.images = images
            }
            .store(in: &cancellables)
    }
}

struct ImageResponse: Codable {
    let results: [Image]
}


