//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Petie Positivo on 4/30/22.
//

import SwiftUI

struct FlagImage: View {
    var imgName: String
    
    var body: some View {
        Image(imgName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var gameTicker = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of:")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.white)
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imgName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
        }.alert(scoreTitle, isPresented: $showingScore) {
            if gameTicker < 8 { Button("Continue", action: askQuestion)}
            else if gameTicker == 8 { Button("Restart", action: restartGame)}
        } message: {
            if gameTicker < 8 { Text("Your score is \(userScore)")}
            else if gameTicker == 8 { Text("Your final score is \(userScore) 🎉") }
        }
    }
    
    func restartGame() {
        userScore = 0
        gameTicker = 0
        askQuestion()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        gameTicker += 1
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct ✔️"
            userScore += 1
        } else {
            scoreTitle = """
                        Wrong ❌
                        That flag belongs to \(countries[number])
                        """
        }
        showingScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
