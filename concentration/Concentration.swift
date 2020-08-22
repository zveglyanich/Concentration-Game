//
//  File.swift
//  cncentration
//
//  Created by Павел Звеглянич on 14.05.2020.
//  Copyright © 2020 Павел Звеглянич. All rights reserved.
//

import Foundation

struct Concentration {
    private (set) var  cards = [Card] ()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
            cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard (at index: Int) {
        assert (cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : chosen index not include in the cards")
        if !cards[index].isMatched { 
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if   cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp  = true
            } else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func clearOf () {
        for index in cards.indices {
            cards[index].isFaceUp = false
        }
        cards.removeAll()
    }
    
    init (numberOfPairsCards: Int) {
        assert (numberOfPairsCards > 0, "Concentration.init(\(numberOfPairsCards): you musthave at least one pair cards")
        for _ in 1...numberOfPairsCards {
            let card = Card()
            cards.insert(card, at: cards.count.arc4Random)
            cards.insert(card, at: cards.count.arc4Random)
        }
    }
}

extension Int{
    var arc4Random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
