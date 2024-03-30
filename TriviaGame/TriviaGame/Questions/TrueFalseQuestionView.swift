//
//  TrueFalseQuestionView.swift
//  TriviaGame
//
//  Created by Admin on 3/30/24.
//


import SwiftUI

struct TrueFalseQuestionView: View {
    
    @State private var userAnswer: Int?
    
    let question: String
    
    var body: some View {
        VStack {
            Text("\(question)")
            
            // Loop through the answer choices
            // For each answer choice (you need the index and the answer choice)
            // Create a button component
            // inside the action
            // if the button is clicked, then set the state variable = index
            //
            
            Button {
                Task {
                    try await NetworkManager.shared.getCategories()
                }
            } label: {
                Text("A. True")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            Button {
                Task {
                    try await NetworkManager.shared.getCategories()
                }
            } label: {
                Text("B. False")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
          
        }
        .padding()
        .cornerRadius(5)
        .background(.red)
        
    }
}
