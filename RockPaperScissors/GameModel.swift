//
//  GameModel.swift
//  RockPaperScissors
//
//  Created by Mohammed Alhashim on 21/10/2026.
//

import Foundation
import Observation

enum Move: String, CaseIterable {
    case rock, paper, scissors
    
    var title: String {
        rawValue.capitalized
    }
    
    var beats: Move {
        switch self {
        case .rock: return .scissors
        case .paper: return .rock
        case .scissors: return .paper
        }
    }
    
    var emoji: String {
        switch self {
        case .rock: return "🪨"
        case .paper: return "📄"
        case .scissors: return "✂️"
        }
    }
    
}

enum Outcome: String {
    case win, lose, tie
    
    var title: String {
        rawValue.capitalized
    }
}

@Observable
class GameModel {
    var userChoice: Move = .rock
    var computerChoice: Move = Move.allCases.randomElement()!
    var result: Outcome = .tie
    var progress: Int = 0
    var score: Int = 0
    var shouldWin: Bool = Bool.random()
    let totalRounds: Int = 10
    
    var isGameOver: Bool {
        progress == totalRounds
    }
    
    func newRound() {
        computerChoice = Move.allCases.randomElement()!
        shouldWin = Bool.random()
    }
    
    func evaluate() -> Outcome {
        
        let real: Outcome
        if userChoice == computerChoice {
            real = .tie
        } else if userChoice.beats == computerChoice {
            real = .win
        } else {
            real = .lose
        }
        
        if shouldWin {
            return real
        }
        
        switch real {
        case .win: return .lose
        case .lose: return .win
        case .tie: return .tie
            
            
        }
    }
    
    func play(_ move: Move){
        progress += 1
        userChoice = move
        result = evaluate()
        
        switch result {
        case .win:
            score += 1
            
        case .lose:
            score = max(0, score - 1)
            
        case .tie:
            break
        }
    }
    
    func reset() {
        score = 0
        progress = 0
        newRound()
    }
}
