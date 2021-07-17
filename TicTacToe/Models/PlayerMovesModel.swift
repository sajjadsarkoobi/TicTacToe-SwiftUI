//
//  PlayerMovesModel.swift
//  TicTacToe
//
//  Created by Sajjad Sarkoobi on 7/16/21.
//

import Foundation


enum Player {
    case human
    case computer
}

struct Move {
    let player:Player
    let boardIndex: Int
    
    var indicator : String {
        return player == .human ? "xmark" : "circle"
    }
}
