//
//  NetworkManager.swift
//  TriviaGame
//
//  Created by Admin on 3/29/24.
//
import Foundation
import UIKit
import SwiftUI



enum TriviaError: Error {
    case INVALID_RESPONSE
    case INVALID_DATA
    case UNABLE_TO_DECODE
    case UNABLE_TO_CREATE_IMAGE
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://opentdb.com/api.php"
    private init() {}
    
    // amount, category, difficult, type
    func getQuestions(amount: Int, difficultyText: String, selectedCategoryId: Int, selectedType: String) async throws -> TriviaResponse {
        var urlComps = URLComponents(string: baseURL)!
        
        var queryItems = [
            URLQueryItem(name: "amount", value: "\(amount)"), // question count
            URLQueryItem(name: "difficulty", value: "\(difficultyText)"),
            URLQueryItem(name: "type", value: "\(selectedType)")
        ]
        
        if selectedCategoryId != -1 {
            queryItems.append(
                URLQueryItem(name: "category", value: "\(selectedCategoryId)") //category
            )
        }
        
        
        
        urlComps.queryItems = queryItems
        
            
        guard let url = urlComps.url else {
            fatalError("Missing URL")
        }
        
        print("\n\nURL: \(url)\n\n")
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
        let triviaResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)
        return triviaResponse
    }
    
    func getCategories() async throws -> CategoriesResponse{
        guard let url = URL(string: "https://opentdb.com/api_category.php") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
        let categories = try JSONDecoder().decode(CategoriesResponse.self, from: data)
        return categories
    }
    
}
