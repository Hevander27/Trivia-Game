//
//  TrueFalseQuestionView.swift
//  TriviaGame
//
//  Created by Admin on 3/30/24.
//


import SwiftUI

struct TrueFalseQuestionView: View {
    
    @State private var userAnswer: String?
    
    let question: String
    let correctAnswer: Bool
    let isCorrectHandler: (Bool) -> Void
    
    init(userAnswer: String? = nil, question: String, correctAnswer: Bool, isCorrectHandler: @escaping (Bool) -> Void) {
        self.userAnswer = userAnswer
        self.question = question
        self.correctAnswer = correctAnswer
        self.isCorrectHandler = isCorrectHandler
    }
    
    var body: some View {
        VStack {
            Text("\(question)")
            
            Button(action: {
                userAnswer = "true"
                isCorrectHandler(isCorrectAnswer())

            }) {
                HStack {
                    Text("A. True")
                    Spacer()
                    if userAnswer == "true" {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }
                }
                .foregroundColor(.black)
                .padding()
                .frame(width: 300)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(10)
            }
            
            Button(action: {
                userAnswer = "false"
                isCorrectHandler(isCorrectAnswer())
            }) {
                HStack {
                    Text("B. False")
                    Spacer()
                    if userAnswer == "false" {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }
                }
                .foregroundColor(.black)
                .padding()
                .frame(width: 300)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(10)
            }
            
          
        }
        .padding()
        .cornerRadius(5)
        .background(.white)
        
    }
    func isCorrectAnswer() -> Bool {
        return userAnswer == (correctAnswer ? "true": "false")
    }
}
