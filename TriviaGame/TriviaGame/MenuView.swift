//
//  MenuView.swift
//  TriviaGame
//
//  Created by Admin on 3/25/24.
//

import Foundation
import SwiftUI

enum NotifyMeAboutType {
    case directMessages
    case mentions
    case anything
}

struct MenuView: View {
    @State private var notifyMeAbout: NotifyMeAboutType = .directMessages
    @State private var playNotificationSounds = true
    @State private var sendReadReceipts = false
    @State private var difficultyLevel: Double = 0 // Default difficulty level
    @State private var questionCount: Int = 0 // Default difficulty level
    
    private var types: [String] = [
        "Any Type",
        "Multiple Choice",
        "True or False"
    ]
    
    @State private var categories: CategoriesResponse?
    @State private var selectedType = "Any Type"
    @State private var selectedCategory = "General Knowledge"
    @State private var selectedTime = "30 seconds"
    //@State private var selectedAmount = ""
    @State private var timeRemaining = 30
    

    @State private var currentDate = Date.now
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var selectedAmountString = ""
    @State private var selectedAmount = 1
    let maxQuestions = 50 // Maximum number of questions allowed
    
    private var difficultyText: String {
        switch difficultyLevel {
        case 0..<4.3:
            return "easy"
        case 4.38..<8:
            return "medium"
        case 9..<11:
            return "hard"
        default:
            return "Hard"
        }
    }
    

    
    var body: some View {
        NavigationView {
            VStack {
                Text("Trivia Game") // This is your title
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.top, 20)
                Form {
                    Section {
                        TextField("Enter Number", text: $selectedAmountString)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .onChange(of: selectedAmountString) { newValue in
                                // Ensure the entered value is within the valid range
                                if let newValue = Int(newValue) {
                                    selectedAmount = min(newValue, maxQuestions)
                                    selectedAmountString = "\(selectedAmount)" // Ensure TextField updates with clamped value
                                }
                            }
                        
                        
                        Picker("Select Category", selection: $selectedCategory) {
                            ForEach(categories?.trivia_categories ?? [], id: \.name) { category in
                                Text("\(category.name)").tag("\(category.name)")
                            }
                        }
                        HStack {
                            Text("Difficulty: \(difficultyText)")
                            Slider(value: $difficultyLevel, in: 0...11, step: 1)
                        }
                        
                        Picker("Select Type", selection: $selectedType) {
                            ForEach(types, id: \.self) { type in
                                Text("\(type)").tag("\(type)")
                            }
                        }
                        
                        Picker("Timer Duration", selection: $timeRemaining) {
                            Text("30 seconds").tag(30)
                            Text("60 seconds").tag(60)
                            Text("120 seconds").tag(120)
                            Text("300 seconds").tag(300)
                            Text("1 hour").tag(3600)
                        }
                        
//                        let seconds = calendar.component(.second, from: date)

                        //Text("\(timeRemaining)")
                            .onReceive(timer) { input in
//                                currentDate = input
                                
                                if timeRemaining > 0 {
                                    timeRemaining -= 1
                                }
                            }
                    }
                }
                NavigationLink(destination: MainQuestionView(amount: questionCount, difficultyText: difficultyText, selectedAmountString:   selectedAmountString, selectedType: selectedType, timeRemaining: $timeRemaining)) { // NavigationLink to ContentView
//
                    Text("Start Trivia")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300)
                        .background(Color.green)
                        .cornerRadius(10)

                }
            }
            .background(Color.blue)
        }
        .onAppear {
            Task {
                categories = try await NetworkManager.shared.getCategories()
            }
        }
    }
    
}

//#if DEBUG
//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
//#endif

