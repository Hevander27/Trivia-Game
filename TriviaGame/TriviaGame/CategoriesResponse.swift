//
//  CategoriesResponse.swift
//  TriviaGame
//
//  Created by Admin on 3/29/24.
//

import Foundation

struct CategoriesResponse: Codable, Hashable {
    
    let trivia_categories: [Categories]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(trivia_categories)
    }
}

struct Categories: Codable, Hashable {
    let id: Int
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
