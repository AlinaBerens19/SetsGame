//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Aлександр Шаталов on 05/12/2021.
//

import Foundation



class SetGameViewModel: ObservableObject {
    
    
    //for the test perpose use <String> and after change it to custom shape??
    @Published var cardModel: GameOfSets<Theme>
    
    
    init() {
        cardModel = GameOfSets<Theme> {
            CreateNewTheme().themes
        }
        
        print("Sets count: \(cardModel.sets.count)")
    }

    func startGame() {
        cardModel.startGame {
            CreateNewTheme().themes
        }
    }
    
    func restartGame() {
        cardModel = GameOfSets<Theme> {
            CreateNewTheme().themes
        }
    }
    
    func addCards() {
        //cardModel.addCards()
        cardModel.onDeckClick()
    }
    
    func startTimer() {
        cardModel.startTimer()
    }
    
    func gameDidStart(_ card: GameOfSets<Theme>.Card) {
        cardModel.gameDidStart(card)
    }
  
    func gameDidEnded(_ card: GameOfSets<Theme>.Card) {
        //
    }
    
    func firstDeal() {
       cardModel.firstDealing()
    }

    var deck: Array<GameOfSets<Theme>.Card> {
        cardModel.deck
    }
    
    var cards: Array<GameOfSets<Theme>.Card> {
        cardModel.cardsInGame
    }
    
    var sets: Array<GameOfSets<Theme>.Card> {
        cardModel.sets
    }
    
    var anotherThreeCards: Array<GameOfSets<Theme>.Card> {
        cardModel.anotherThreeCard
    }
    
    var count: Int {
        cardModel.count
    }
    
    var timeRemaining: Int {
        cardModel.timeRemaining
    }
    
    var disabled: Bool {
        cardModel.disabled
    }
}
