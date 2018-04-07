//
//  Concentration.swift
//  Concentration
//
//  Created by Suying on 15/02/18.
//  Copyright © 2018 Suying. All rights reserved.
//

import Foundation
import GameKit

class Concentration

{
    var cards = [Card]()
    
    var indexOfOnendOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp{
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
                }
            }
        }
    

    
    init (numberOfPairsOfCard: Int) {
        for _ in 0..<numberOfPairsOfCard {
            let card = Card()
            cards += [card, card]
        }
        cards=GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards) as! [Card]
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnendOnlyFaceUpCard, matchIndex != index {
                //check if card matches
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }
            else {
                indexOfOnendOnlyFaceUpCard = index
            }
        }
    }
}
