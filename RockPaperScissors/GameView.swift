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
                VStack() {
                    Spacer()
                    Text("Computer chose: \(game.computerChoice.title)")
                    Text(game.shouldWin ? "You should win" : "You should lose")
                    
                    
                    VStack(spacing: 50) {
                        ForEach(Move.allCases, id: \.self) { item in
                            Button() {
                                game.play(item)
                                
                                if game.isGameOver {
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
                    Text("Score: \(game.score)")
                    Text("Progress: \(game.progress)")
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
            .alert("Congratz ur totall score is: \(game.score)", isPresented: $showResultAlert){
                Button("Play again") {
                    game.reset()
                    
                }
            }
        }
    }
  
}

#Preview {
    GameView()
}
