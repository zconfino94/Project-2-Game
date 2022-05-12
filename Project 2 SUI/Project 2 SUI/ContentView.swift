//
//  ContentView.swift
//  Project 2 SUI
//
//  Created by Zachary Confino on 11/7/19.
//  Copyright © 2019 Zachary Confino. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
   @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            
            AngularGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink, .red]), center: .center).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                Spacer()
                VStack {
                    Text("Find the flag of")
                        .foregroundColor(.white)
                        .fixedSize()
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .fixedSize()
                }
                
                ForEach(0 ..< 3) { number in Button(action: {
                    self.flagTapped(number)
                }) {
                    
                    Image(self.countries[number])
                        .renderingMode(.original)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 2)
                    }
                }
        
                VStack {
                    Text("Your current score is")
                        .foregroundColor(.white)
                    Text("\(score)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                Spacer()
                Spacer()
                
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("\(scoreMessage) Your score is now \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    func flagTapped(_ number: Int) {
        let selectedAnswer = countries[number]
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreMessage = "You gain a point."
            score += 1
        } else {
            scoreTitle = "Incorrect"
            scoreMessage = "That was the flag of \(selectedAnswer). You lose a point."
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
