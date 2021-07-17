//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Sajjad Sarkoobi on 7/16/21.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]

    @Published var moves : [Move?] = Array(repeating: nil, count: 9)
    @Published var isBoardDisabled: Bool = false
    @Published var alertItem : AlertItem?
    
    func processPlayerMoves(for position: Int){
        if isSquareOccupied(in: moves, forIndex: position) { return }
        moves[position] = Move(player: .human , boardIndex: position)
        
        
        if checkWinConditions(player: .human, moves: moves) {
            print("Human wins")
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(moves: moves){
            print("draw")
            alertItem = AlertContext.draw
            return
        }
        isBoardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[self] in
            let computerPosition = determineComputerMove(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isBoardDisabled = false
            
            if checkWinConditions(player: .computer, moves: moves) {
                print("computer wins")
                alertItem = AlertContext.computerWin
                return
            }
            
            if checkForDraw(moves: moves){
                print("draw")
                alertItem = AlertContext.draw
                return
            }
        }
        
    }
    
    func isSquareOccupied(in moves:[Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    func determineComputerMove(in moves:[Move?]) -> Int {
        
        //If AI can win, then win
        let winConditions: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[1,4,7],[2,4,6],[0,3,6],[2,5,8]]
        let computerMoves = moves.compactMap({$0}) .filter({$0.player == .computer })
        let computerIndexes = Set(computerMoves.map({$0.boardIndex}))
        
        for pattern in winConditions {
            let winPosition = pattern.subtracting(computerIndexes)
            
            if winPosition.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
                if isAvailable { return winPosition.first!}
            }
        }
        
        // If AI can't win, then block
        let humanMoves = moves.compactMap({$0}) .filter({$0.player == .human })
        let humanIndexes = Set(humanMoves.map({$0.boardIndex}))
        
        for pattern in winConditions {
            let winPosition = pattern.subtracting(humanIndexes)
            
            if winPosition.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
                if isAvailable { return winPosition.first!}
            }
        }
        
        
        // If AI can't block then take middle square
        let centerSquar = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquar){
            return centerSquar
        }
        
        
        // If AI can't tacke middle squar then take a random number
        var movePosition = Int.random(in: 0..<9)
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinConditions(player: Player, moves:[Move?]) -> Bool{
        let winConditions: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[1,4,7],[2,4,6],[0,3,6],[2,5,8]]
        
        let playerMoves = moves.compactMap({$0}) .filter({$0.player == player })
        let playerIndexes = Set(playerMoves.map({$0.boardIndex}))
        for item in winConditions where item.isSubset(of: playerIndexes) { return true}
        
        return false
    }
    
    func checkForDraw(moves:[Move?]) -> Bool {
        return moves.compactMap{$0}.count == 9
    }
    
    func resetGame(){
        isBoardDisabled = false
        moves = Array(repeating: nil, count: 9)
    }
    
}
