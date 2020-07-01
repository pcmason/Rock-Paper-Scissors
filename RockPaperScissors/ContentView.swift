//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Paul Mason on 7/1/20.
//  Copyright © 2020 Paul Mason. All rights reserved.
//

//creating a rock paper scissors game where your opponent will randomly pick an option between rock paper and scissors and either win/lose and the player has to pick the correct option

import SwiftUI

struct ContentView: View {
    //create arrays for 'opponent' and player to choose from
    let moves = ["Rock", "Paper", "Scissors"]
    //let winOrLose = ["Win", "Lose"]
    //now create state variables to keep track of what the computer opponent has chosen
    @State private var oppMove = Int.random(in: 0...2)
    @State private var winCond = Bool.random()
    //create variable for playerScore
    @State private var playerScore = 0
    //create scoreTitle for the alert
    @State private var scoreTitle = ""
    //create a bool to determine if the alert should be shown
    @State private var showAlert = false
    var correctAnswer: Int {
        var answer: Int
        if winCond {
            if moves[oppMove] == "Rock"{
                answer = 1
            }else if moves[oppMove] == "Paper"{
                answer = 2
            }else {
                answer = 0
            }
        }else{
            if moves[oppMove] == "Rock"{
                answer = 2
            }else if moves[oppMove] == "Paper"{
                answer = 0
            }else {
                answer = 1
            }
        }
        return answer
    }
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("Score: \(playerScore)")
                    .font(.headline)
                    .padding()
                Text("Opponent throws \(moves[oppMove])!")
                    .font(.headline)
                    .fontWeight(.black)
                    .padding()
                if winCond {
                    Text("Win")
                    .font(.title)
                    .fontWeight(.black)
                    .padding()
                }else {
                    Text("Lose")
                    .font(.title)
                    .fontWeight(.black)
                    .padding()
                }
                //now deal with the buttons for the user
                ForEach(0 ..< 3){number in Button(action: {
                    self.moveChosen(number)
                }){
                    Text(self.moves[number])
                    .padding()
                        .background(Color.black)
                    .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                    
                        
                }
                    
                }
                    Spacer()
                //add the alert shown when the user selects a button
                    .alert(isPresented: $showAlert){
                        Alert(title: Text(scoreTitle), message: Text("Your score is \(playerScore)"), dismissButton: .default(Text("Continue")){
                            self.nxtQuestion()
                        })
                    }
                }
            }
    }
    //function that is called when user chooses an answer
    func moveChosen(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            playerScore += 50
        }else {
            scoreTitle = "Wrong, should have picked \(moves[correctAnswer])."
            if playerScore > 0 {
                playerScore -= 25
            }
        }
        showAlert = true
    }
    //function that creates the next question
    func nxtQuestion() {
        oppMove = Int.random(in: 0...2)
        winCond = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
