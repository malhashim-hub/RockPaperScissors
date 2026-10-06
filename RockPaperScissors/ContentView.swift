//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Mohammed Alhashim on 05/10/2026.
//

import SwiftUI

struct ContentView: View {

    enum Move: String, CaseIterable {
        case rock, paper, scissors

        var title: String {
            rawValue.capitalized
        }
    }

    @State private var userChoice: Move = .rock
    @State private var computerChoice: Move = Move.allCases.randomElement()!
    @State private var result: String = ""
    @State private var showAlert: Bool = false
    @State private var progress: Int = 0
    @State private var score: Int = 0
    @State private var shouldWin: Bool = Bool.random()
    @State private var showResultAlert: Bool = false


    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack() {
                    Spacer()
                    Text("Computer chose: \(computerChoice.title)")
                    Text(shouldWin ? "You should win" : "You should lose")


                    VStack(spacing: 50) {
                        ForEach(Move.allCases, id: \.self) { item in
                            Button() {
                                userChoice = item
                                result = evaluate(user: userChoice, computer: computerChoice, shouldWin: shouldWin)
                                if progress == 10 {
                                    showResultAlert = true
                                } else {
                                    showAlert = true
                                }

                            } label: {
                                Text(item.title)
                            }
                            .font(.system(size: 50))
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(.mint)
                            .clipShape(Capsule())

                        }

                    }
                    Spacer()
                    Spacer()
                    Text("Score: \(score)")
                    Text("Progress: \(progress)")
                    Spacer()
                }

            }
            .navigationTitle("Rock Paper Scissors")
            .navigationBarTitleDisplayMode(.inline)
            .alert(result, isPresented: $showAlert) {
                Button("Next") {
                    newRound()
                }
            } message: {
                Text("Computer chose: \(computerChoice.title) \n You chose: \(userChoice.title)")
            }
            .alert("Congratz ur totall score is: \(score)", isPresented: $showResultAlert){
                Button("Play again") {
                    score = 0
                    progress = 0
                    newRound()

                }
            }
        }
    }

    func evaluate(user: Move, computer: Move, shouldWin: Bool) -> String {
        progress += 1

        if shouldWin {
            switch (user, computer) {
            case (.rock, .scissors):
                score += 1
                return "You Win"
            case (.rock, .paper):
                score = (score == 0) ? 0 : score - 1
                return "You Lose"

            case (.paper, .rock):
                score += 1
                return "You Win"
            case (.paper, .scissors):
                score = (score == 0) ? 0 : score - 1
                return "You Lose"

            case (.scissors, .paper):
                score += 1
                return "You Win"
            case (.scissors, .rock):
                score = (score == 0) ? 0 : score - 1
                return "You Lose"

            default:
                return "It's a Tie"

            }
        } else {
            switch (computer, user) {
            case (.rock, .scissors):
                score += 1
                return "You Win"
            case (.rock, .paper):
                score = (score == 0) ? 0 : score - 1
                return "You Lose"

            case (.paper, .rock):
                score += 1
                return "You Win"
            case (.paper, .scissors):
                score = (score == 0) ? 0 : score - 1
                return "You Lose"

            case (.scissors, .paper):
                score += 1
                return "You Win"
            case (.scissors, .rock):
                score = (score == 0) ? 0 : score - 1
                return "You Lose"

            default:
                return "It's a Tie"

            }
        }
    }

    func newRound() {
        computerChoice = Move.allCases.randomElement()!
        shouldWin = Bool.random()
    }

}

#Preview {
    ContentView()
}
