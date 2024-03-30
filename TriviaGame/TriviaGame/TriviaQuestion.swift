//
//  TriviaQuestion.swift
//  TriviaGame
//
//  Created by Admin on 3/25/24.
//

import Foundation
import SwiftUI


// Card data model
struct Question: Equatable {
    let question: String
    let answer: String
    let isMultipleChoice: Bool // Boolean variable to indicate if it's a multiple choice question
    let multipleChoiceOptions: [String]? // Optional array of multiple choice options
}

struct TriviaQuestion: View {
    let question: Question

    var body: some View {
        VStack {
            
            Text(question.question)
                .padding()
            
            if question.isMultipleChoice {
                // Display multiple choice options
                ForEach(question.multipleChoiceOptions ?? [], id: \.self) { option in
                    Button(action: {
                        // Handle selection of multiple choice option
                        // Example: you can check if the selected option is the correct answer
                    }) {
                        Text(option)
                            .padding()
                    }
                    .foregroundColor(.black)
                }
            } else {
                // Display true/false options
                VStack {
                    Button(action: {
                        // Handle selection of true option
                    }) {
                        Text("True")
                            .padding()
                    }
                    .foregroundColor(.black)
                    

                    
                    Button(action: {
                        // Handle selection of false option
                    }) {
                        Text("False")
                            .padding()
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
    
}

// Example usage:
let sampleQuestion = Question(question: "Is the sky blue?", answer: "Yes", isMultipleChoice: false, multipleChoiceOptions: nil)
let multipleChoiceQuestion = Question(question: "What is the capital of France?", answer: "Paris", isMultipleChoice: true, multipleChoiceOptions: ["London", "Berlin", "Paris", "Madrid"])

struct TriviaQuestion_Previews: PreviewProvider {
    static var previews: some View {
        TriviaQuestion(question: sampleQuestion)
    }
}

