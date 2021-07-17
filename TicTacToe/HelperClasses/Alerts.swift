//
//  Alerts.swift
//  TicTacToe
//
//  Created by Sajjad Sarkoobi on 7/16/21.
//

import SwiftUI


struct AlertItem: Identifiable {
    let id = UUID()
    var title : Text
    var message : Text
    var button : Text
}

struct AlertContext {
    
    //Human win:
    static let humanWin    = AlertItem(title: Text("You Win"),
                             message: Text("You are so Smart"),
                             button: Text("Yea"))
    
    //Computer win:
    static let computerWin = AlertItem(title: Text("You Lost"),
                             message: Text("You Lost to the AI"),
                             button: Text("Rematch"))
    
    //Draw win:
    static let draw        = AlertItem(title: Text("Draw"),
                             message: Text("What a battle"),
                             button: Text("Try again"))
}
