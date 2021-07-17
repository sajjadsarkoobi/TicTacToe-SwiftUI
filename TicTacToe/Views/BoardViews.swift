//
//  BoardViews.swift
//  TicTacToe
//
//  Created by Sajjad Sarkoobi on 7/16/21.
//

import SwiftUI

struct GameItemView: View {
    var proxy : GeometryProxy
    var body: some View {
        Circle()
            .foregroundColor(.blue).opacity(0.8)
            .frame(width: proxy.size.width/3 - 15 , height: proxy.size.width/3 - 15, alignment: .center)
    }
}


struct PlayerIndicatorView: View {
    
    var systemImage: String
    var body: some View {
        Image(systemName: systemImage)
            .resizable()
            .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
    }
}
