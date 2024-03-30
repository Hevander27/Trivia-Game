//
//  TriviaResponse.swift
//  TriviaGame
//
//  Created by Admin on 3/25/24.
//

import Foundation

struct TriviaResponse: Codable {
    let response_code: Int
    let results: [Trivia]
}

struct Trivia: Codable, Hashable, Equatable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}
