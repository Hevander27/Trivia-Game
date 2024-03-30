//
//  ContentView.swift
//  TriviaGame
//
//  Created by Admin on 3/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var notifyMeAbout: NotifyMeAboutType = .directMessages
    @State private var playNotificationSounds = true
    @State private var sendReadReceipts = false
    @State private var difficultyLevel: Double = 0 // Default difficulty level
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                Text("Time Remaining:") // This is your title
                    .font(.title)
                    .padding(.top, 10)
                
                
                List {
                    Section {
                        
                    }
                }
            
                .background(Color(UIColor.systemGray6))
                .padding()
                
                Button(action: {}) {
                      Text("Submit")
                
                          .padding()
                          .frame(width: 300)
                          .background(Color.green)
                          .cornerRadius(16)
                  }
            }
            .background(Color(UIColor.systemGreen).opacity(0.15))


        }
    }
}

#Preview {
    ContentView()
}
