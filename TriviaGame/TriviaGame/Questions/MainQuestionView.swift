//
//  MainQuestionView.swift
//  TriviaGame
//
//  Created by Admin on 3/29/24.
//

import SwiftUI

struct MainQuestionView: View {
    
    // let questions 
    
    let amount: Int
    let difficultyText: String
    let selectedAmountString: String
    let selectedType: String
    
    @State private var questions: TriviaResponse?
    @Binding var timeRemaining: Int
    


//#Preview {
//    MainQuestionView()
//}


//        ScrollView(.vertical) {
//            ForEach(questions?.results ?? [], id: \.self) { question in
//                if question.type == "Multiple Choice" {
//                    MultipleChoiceQuestionView(question: question.question)
//                }else if question.type == "True False" {
//                    TrueFalseQuestionView(question:question.question)
//                }
//            }
//        }
//        .onAppear {
//            Task {
//                questions = try await NetworkManager.shared.getQuestions(amount: amount, difficultyText: difficultyText, selectedAmountString: selectedAmountString, selectedType: selectedType )
//            }
//        }



    var body: some View {
        
        NavigationStack {
            
            VStack {
                Text("Time Remaining:\(timeRemaining)") // This is your title
                    .font(.title)
                    //.padding(.top,)
                
                
           
                Section {
                    List {
                        ScrollView(.vertical) {
                            ForEach(questions?.results ?? [], id: \.self) { question in
                                if question.type == "Multiple Choice" {
                                    MultipleChoiceQuestionView(question: question.question)
                                }else if question.type == "True False" {
                                    TrueFalseQuestionView(question:question.question)
                                }
                            }
                        }
                        .onAppear {
                            Task {
                                questions = try await NetworkManager.shared.getQuestions(amount: amount, difficultyText: difficultyText, selectedAmountString: selectedAmountString, selectedType: selectedType )
                            }
                        }
                    }
                }
            
            
                .background(Color(UIColor.systemGray6))
                .padding()
                
                Button(action: {}) {
                      Text("Submit")
                          .padding()
                          .foregroundColor(.white)
                          .frame(width: 300)
                          .background(Color.green)
                          .cornerRadius(16)
                  }
            }
            .background(Color(UIColor.systemGreen).opacity(0.15))


        }
    }
}


