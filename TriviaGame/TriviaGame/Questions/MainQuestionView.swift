//
//  MainQuestionView.swift
//  TriviaGame
//
//  Created by Admin on 3/29/24.
//

import SwiftUI

struct MainQuestionView: View {
    
    
    let amount: Int
    let difficultyText: String
    let selectedCategoryId: Int
    let selectedType: String
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var questions: TriviaResponse?
    @Binding var timeRemaining: Int
    @State var isCorrectDict: [String: Bool] = [:]
    //var isCorrectArray: [Bindable <Bool>] = []
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            
            Text("Time Remaining:\(timeRemaining)") // This is your title
                .font(.title)
            //.padding(.top,)
            
            ScrollView(.vertical) {
                ForEach(questions?.results ?? [], id: \.self) { (question: Trivia) in
                    if question.type == "multiple" {
                        MultipleChoiceQuestionView(
                            question: question,
                            answerChoices: getQuestionAnswerChoices(
                                incorrect_answers: question.incorrect_answers,
                                correct_answer: question.correct_answer
                            ),
                            correctAnswer: question.correct_answer, isCorrectHandler:{
                                isCorrect in
                                isCorrectDict[question.question] = isCorrect
                            }
                        )
                    } else if question.type == "boolean" {
                            TrueFalseQuestionView(userAnswer: nil, question: question.question, correctAnswer: question.correct_answer == "True") { isCorrect in
                                isCorrectDict[question.question] = isCorrect
                            }
                        }
                    }
                }
            .frame(maxWidth: .infinity)
                .onReceive(timer) { input in
                    //                                currentDate = input
                    
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
                .onAppear {
                    Task {
                        questions = try await NetworkManager.shared.getQuestions(amount: amount, difficultyText: difficultyText, selectedCategoryId: selectedCategoryId, selectedType: selectedType )
                        print("\n\nQuestions: \(questions)\n\n")
                    }
                }
                
                .background(Color(UIColor.systemGray6))
                .padding()
                
                Button(action: {
                    print(isCorrectDict)
                    var isCorrectCounter = 0
                    for (question, isCorrect) in isCorrectDict  {
                        if (isCorrect) {
                            isCorrectCounter += 1
                        }
                    }
                    alertMessage = "You scored \(isCorrectCounter) out of \(amount)"
                    showAlert = true
                    
                }) {
                    Text("Submit")
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 300)
                        .background(Color.green)
                        .cornerRadius(16)
                }
            }
            .background(Color(UIColor.systemGreen).opacity(0.15))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Title"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            //        }
            
        }
        
        private func getQuestionAnswerChoices(incorrect_answers: [String], correct_answer: String) -> [String] {
            var answerChoices: [String] = []
            answerChoices.append(contentsOf: incorrect_answers)
            answerChoices.append(correct_answer)
            return answerChoices//.shuffled()
        }
    }
    
    
