//
//  GameView.swift
//  RockPaperScissors
//
//  Created by Mohammed Alhashim on 05/10/2026.
//

import SwiftUI

struct GameView: View {
    
    @State private var game = GameModel()
    @State private var showAlert: Bool = false
    @State private var showResultAlert: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack(spacing: 32) {
                    Spacer()
                    VStack {
                        Text("Computer chose")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                        
                        Text(game.computerChoice.title)
                            .font(.largeTitle)
                    }
                    
                    Text(game.shouldWin ? "You should win" : "You should lose")
                        .font(.title).bold()
                        .foregroundStyle(.white)
                    
                    
                    HStack(spacing: 30) {
                        ForEach(Move.allCases, id: \.self) { item in
                            Button() {
                                game.play(item)
                                
                                if game.isGameOver {
                                    showResultAlert = true
                                } else {
                                    showAlert = true
                                }
                                
                            } label: {
                                Text(item.emoji)
                            }
                            .font(.system(size: 50))
                            .foregroundStyle(Color.white)
                            .padding()
                            .frame(width: 90, height: 90)
                            .background(.mint)
                            .clipShape(Circle())
                            
                        }
                        
                    }
                    
                    
                    VStack {
                        Text("Score: \(game.score)")
                        Text("Round \(game.progress) of \(game.totalRounds)")
                    }
                    .font(.footnote)
                    .opacity(0.75)
                    Spacer()
                }
                
            }
            .navigationTitle("Rock Paper Scissors")
            .navigationBarTitleDisplayMode(.inline)
            .alert(game.result.title, isPresented: $showAlert) {
                Button("Next") {
                    game.newRound()
                    
                }
            } message: {
                Text("Computer chose: \(game.computerChoice.title) \n You chose: \(game.userChoice.title)")
            }
            .alert("Game Over!", isPresented: $showResultAlert){
                Button("Play again") {
                    game.reset()
                    
                }
            } message: {
                Text("Score is \(game.score) of \(game.totalRounds)")
            }
        }
    }
  
}

#Preview {
    GameView()
}
