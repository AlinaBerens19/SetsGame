//
//  GameProtocol.swift
//  SetGame
//
//  Created by Aлександр Шаталов on 12/12/2021.
//

import Foundation


protocol Game {
    associatedtype CardContent where CardContent: Equatable
    
    mutating func startGame(createCardContent: () -> [CardContent])
    mutating func restartGame(createCardContent: () -> [CardContent])
    mutating func addCards()
    mutating func gameDidStart(_ card: GameOfSets<CardContent>.Card)
    mutating func gameDidEnded()
}
