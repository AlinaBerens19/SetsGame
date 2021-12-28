//
//  ContentView.swift
//  SetGame
//
//  Created by Aлександр Шаталов on 05/12/2021.
//

import SwiftUI

struct ContentView: View {
    
    //for compile <Theme> should be in ViewModel
    @ObservedObject var game: SetGameViewModel = SetGameViewModel()
    @State var timeRemaining = 100
    @Namespace private var dealingNamespace
    @State private var dealt = Set<Int>()
    @State private var firstDealHappen = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private func deal(_ card: GameOfSets<Theme>.Card) {
        dealt.insert(card.id)
    }
    
    private func IsUndealt(_ card: GameOfSets<Theme>.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealWithAnimation(for card: GameOfSets<Theme>.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    //update when cards become part of the set
    var setWasFound: Bool {
        if !game.sets.isEmpty {
            return true
        }
        else {
            return false
        }
    }
    
    //regulation of card size
    var cardSize: CGFloat {
        if game.cards.count <= 15 {
            return 100
        }
        else if game.cards.count > 15 && game.cards.count < 25 {
            return 90
        }
        else if game.cards.count > 24 && game.cards.count < 37 {
            return 85
        }
        else if game.cards.count > 37 && game.cards.count < 56 {
            return 80
        }
        else if game.cards.count > 55 && game.cards.count < 65 {
            return 75
        }

        else {
            return 75
        }
    }

    //regulation of card size
    var deckSize: CGFloat {
        if game.cards.count <= 15 {
            return 100
        }
     
        else {
            return 75
        }
    }
    
    private func zIndex(of card: GameOfSets<Theme>.Card)-> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
        VStack {
            restartButton
            HStack {
                pileBody
                Spacer()
                deckBody
            }
                gameBody
            }
        }
    }
}
    
    var restartButton: some View {
        Button("Restart") {
            dealt = []
            game.restartGame()
            game.firstDeal()
            
            for card in game.cards.filter( { $0.cardState == .cardOnTheTable }) {
                withAnimation(dealWithAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var pileBody: some View {
        ZStack {
            ForEach(game.cards) { card in
                ZStack {
                    if card.cardState == .cardIsPartOfTheSet {
                        CardView(id: card.id, shape: card.cardContent.shape.rawValue, number: card.cardContent.number.rawValue, color: card.cardContent.color.rawValue, shade: card.cardContent.shade.rawValue, isFaceUp: card.isFaceUp)
                    }
                }
            }
        }
        .frame(width: 1.3 * deckSize, height: 2 * deckSize)
        
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards) { card in
                ZStack {
                   CardView(id: card.id, shape: card.cardContent.shape.rawValue, number: card.cardContent.number.rawValue, color: card.cardContent.color.rawValue, shade: card.cardContent.shade.rawValue, isFaceUp: card.isFaceUp)
                            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                            .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity).animation(Animation.easeInOut))
                    }
                }
            }
        .disabled(game.disabled)
        .frame(width: 1.3 * deckSize, height: 2 * deckSize)
        .onAppear {
           game.firstDeal()
           for card in game.cards.filter( { $0.cardState == .cardOnTheTable }) {
                 withAnimation(dealWithAnimation(for: card)) {
                 deal(card)
                 }
            }
        }
        .onTapGesture {
            game.addCards()
            for card in game.cards.filter( { $0.cardState == .cardOnTheTable }) {
                withAnimation(dealWithAnimation(for: card)) {
                deal(card)
                }
            }
        }
    }

    
    var gameBody: some View {
        VStack {
            Text("The time remaining \(game.timeRemaining)")
                .onReceive(timer) { _ in
                    game.startTimer()

                }
            Text("You score is \(game.count)")


            LazyVGrid(columns: [GridItem(.adaptive(minimum: cardSize))]) {
                ForEach(game.cards) { card in
                
            if IsUndealt(card) || card.cardState == .cardIsPartOfTheSet {
                 Color.clear
            }
                

            else {
                 CardView(id: card.id, shape: card.cardContent.shape.rawValue, number: card.cardContent.number.rawValue, color: card.cardContent.color.rawValue, shade: card.cardContent.shade.rawValue, isFaceUp: card.isFaceUp)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity).animation(Animation.easeInOut))
                        .aspectRatio(2/3, contentMode: .fit)
                        .zIndex(-1)
                        .foregroundColor(card.cardState == .cardIsSelected ? Color.red : Color.black)
                        .onTapGesture {
                            game.gameDidStart(card)
                        }
                    }
                }
            }
        }
    }
        private struct CardConstants {
            static let aspectRatio: CGFloat = 2/3
            static let dealDuration: Double = 0.5
            static let totalDealDuration: Double = 2
            static let undealtHeight: CGFloat = 90
            static let undealtWidth = undealtHeight * aspectRatio
        }
    }



    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
    .previewInterfaceOrientation(.portrait)
        }
    }


