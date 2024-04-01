//
//  MultipleChoiceQuestionView.swift
//  TriviaGame
//
//  Created by Admin on 3/29/24.
//

import SwiftUI

struct MultipleChoiceQuestionView: View, Identifiable {
    let id: UUID = UUID()
    
    
    @State private var userAnswer: String?
    //@State var isCorrect: Bool
    
    let question: Trivia
    let answerChoices: [String]
    let correctAnswer: String
    
    let isCorrectHandler: (Bool) -> Void
    
    var body: some View {
        VStack {
            Text("\(question.question)")
            ForEach(answerChoices, id: \.self) { choice in
                Button(action: {
                    userAnswer = choice
                    isCorrectHandler(isCorrectAnswer())
                    
                }) {
                    HStack {
                        Text("\(choice)")
                        Spacer()
                        if userAnswer == choice {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green) // Change color to green

                        }
                    }
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 300)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                }
            }
        }
        .padding()
        .cornerRadius(5)
        .background(.white)
        
    }
    
    func isCorrectAnswer() -> Bool {
        return userAnswer == correctAnswer
    }
}
