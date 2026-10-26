//
//  GameView.swift
//  RockPaperScissors
//
//  Created by Mohammed Alhashim on 05/10/2026.
//

import SwiftUI

struct GameView: View {
    
    @State private var game = GameModel()
    @State private var isWaiting = false
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
                                isWaiting = true
                                Task {
                                    try? await Task.sleep(for: .seconds(1))
                                    if game.isGameOver {
                                        game.newRound()
                                        showResultAlert = true
                                    } else {
                                            game.newRound()
                                    }
                                    isWaiting = false
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
                            .disabled(isWaiting)
                            
                        }
                        
                    }
                    
                    if let result = game.result {
                            Text(result.title)
                            .transition(.opacity)
                            .font(.title2)
                            .foregroundStyle(result.color)
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
            .alert("Game Over!", isPresented: $showResultAlert){
                Button("Play again") {
                        game.reset()
                }
            } message: {
                Text("Score is \(game.score) of \(game.totalRounds)")
            }
            .animation(.easeInOut, value: game.result)
        }
    }
  
}

extension Outcome {
    var color: Color {
        switch self {
        case .win: return .green
        case .lose: return .red
        case .tie: return .orange
        }
    }
}

#Preview {
    GameView()
}
