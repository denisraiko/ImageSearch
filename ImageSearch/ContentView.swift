//
//  ContentView.swift
//  ImageSearch
//
//  Created by Denis Raiko on 27.07.24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = ImageSearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Введите ключевое слово", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: {
                        viewModel.searchImages(query: searchText)
                    }) {
                        Text("Поиск")
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                if viewModel.images.isEmpty {
                    Text("Нет результатов")
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                            ForEach(viewModel.images, id: \.id) { image in
                                VStack {
                                    AsyncImage(url: URL(string: image.urls.small)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .cornerRadius(10)
                                    
                                    Text(image.description ?? "Без описания")
                                        .font(.caption)
                                        .padding(.horizontal, 5)
                                        .padding(.vertical, 5)
                                        .background(.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                }
                            }
                        }
                        .padding()
                    }
                }
                Spacer()
            }
            .navigationTitle("Поиск изображений")
        }
    }
}

#Preview {
    ContentView()
}
