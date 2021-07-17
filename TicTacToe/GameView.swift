//
//  GameView.swift
//  TicTacToe
//
//  Created by Sajjad Sarkoobi on 7/15/21.
//

import SwiftUI

struct GameView: View {

    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        GeometryReader { geometry in
            VStack{
                Spacer()
                
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack{
                            
                            GameItemView(proxy: geometry)
                            PlayerIndicatorView(systemImage: viewModel.moves[i]?.indicator ?? "")
            
                        }.onTapGesture {
                            viewModel.processPlayerMoves(for: i)
                        }
                    }
                }
                
                Spacer()
            }
            .disabled(viewModel.isBoardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem) { alertitem in
                Alert(title: alertitem.title, message: alertitem.message, dismissButton: .default(alertitem.button, action: {
                    viewModel.resetGame()
                }))
            }
        }
    }
    
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

