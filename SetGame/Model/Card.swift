//
//  Card.swift
//  SetGame
//
//  Created by Aлександр Шаталов on 05/12/2021.
//

import Foundation
import SwiftUI

//shapes, colors and names of shading/hatching  should be in theme

struct GameOfSets<CardContent> : Game where CardContent: Equatable {
    
    private(set) var deck: [Card]
    private(set) var cards: [Card]
    private(set) var sets: [Card]
    private(set) var anotherThreeCard: [Card]
    private(set) var cardsInGame: [Card]
    private var res: Bool? = nil
    private(set) var count: Int = 0
    private(set) var timeRemaining: Int
    private(set) var disabled: Bool
    
    mutating func startTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        }
    }
    
    mutating func startGame(createCardContent: () -> [CardContent]) {
  
        for index in 0..<ConstantNames.cardsInTheDeck {
            let cardContent = createCardContent()[index]
            deck.append(Card(id: index, cardContent: cardContent))
        }
        
        deck.shuffle()
   }
    
    mutating func firstDealing() {
        
        for index in cardsInGame.indices {
            if cardsInGame[index].cardState == .cardInTheDeck {
                cardsInGame[index].cardState = .cardOnTheTable
                cardsInGame[index].isFaceUp = true
            }
        }
        
        addCards()
    }
    
    mutating func onDeckClick() {
        
        if deck.isEmpty {
            disabled = true
        }
        
        for index in cardsInGame.indices {
            if cardsInGame[index].cardState == .cardInTheDeck {
                cardsInGame[index].cardState = .cardOnTheTable
                cardsInGame[index].isFaceUp = true
            }
       }
        
        addCards()
    }
    
    mutating func restartGame(createCardContent: () -> [CardContent]) {
        cardsInGame.removeAll()
        deck.removeAll()
        disabled = false
        startGame(createCardContent: createCardContent)
     }
    
    mutating func addCards() {
    
        if deck.isEmpty {
            return
        }
        guard disabled == false else {
            return
        }
        
            for index in 0..<3 {
              cardsInGame.append(deck[index])
              deck.remove(at: index)
            }
   
    }
    
    //***** check if three chosen cards not equal one to another *****
    private func tripleBool<Element>(first: Element, second: Element, third: Element) -> Bool where Element: Equatable {
        
        var result = false
        
        guard first != second else {
            return result
        }
        
        guard second != third else {
            return result
        }
        
        guard first != third else {
            return result
        }
        
        result = true
        
        return result
    }
    
    
    mutating private func checkNewSet() {
        cards = cardsInGame.filter{ $0.cardState == .cardIsSelected }
        print("Cards: \(cards)")
        
        guard cards.count == 3 else {
            return
        }
        
        res = tripleBool(first: cards[0], second: cards[1], third: cards[2])
        if res == true {
            count += 1
            //addCards()
        }
        print("Result - \(String(describing: res))")
        sets = cards
        print("Combination - \(String(describing: sets))")
        cards.removeAll()
//        sets.removeAll()
        
        for index in cardsInGame.indices {
            if cardsInGame[index].cardState == .cardIsSelected {
                if res == true {
                    cardsInGame[index].cardState = .cardIsPartOfTheSet
                }
                else {
                    cardsInGame[index].cardState = .cardOnTheTable
                }
            }
        }
    }
    
    //toggle card state
    mutating private func selectDeselectCard(_ card: Card){
        
        for index in cardsInGame.indices {
            if cardsInGame[index].id == card.id {
                if cardsInGame[index].cardState == .cardIsSelected {
                    cardsInGame[index].cardState = .cardOnTheTable
                    print("id: \(cardsInGame[index].id)")
                }
                else if cardsInGame[index].cardState == .cardOnTheTable {
                    cardsInGame[index].cardState = .cardIsSelected
                    checkNewSet()
                    print("id: \(cardsInGame[index].id)")
                }
            }
        }
    }
 
    
    mutating func gameDidStart(_ card: Card) {
        selectDeselectCard(card)
     }
    
    mutating func gameDidEnded() {
        //
    }
    
  
    init(createCardContent: () -> [CardContent]) {
        deck = [Card]()
        cards = [Card]()
        sets = [Card]()
        anotherThreeCard = [Card]()
        cardsInGame = [Card]()
        timeRemaining = 100
        disabled = false
        
        startGame(createCardContent: createCardContent)
        
        for index in 0..<12 {
            cardsInGame.append(deck[index])
            deck.remove(at: index)
        }
     }
    

    struct Card: Identifiable, Equatable {
        
        static func == (lhs: GameOfSets<CardContent>.Card, rhs: GameOfSets<CardContent>.Card) -> Bool {
            return lhs.cardContent != rhs.cardContent
        }
        
        enum CardState {
            case cardInTheDeck, cardOnTheTable, cardIsSelected, cardIsPartOfTheSet
        }
        
        var id: Int
        var cardContent: CardContent
        var cardState: CardState = .cardInTheDeck
        var isFaceUp: Bool = false
   }
    
}


