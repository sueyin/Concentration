//
//  ViewController.swift
//  Concentration
//
//  Created by Suying on 14/02/18.
//  Copyright © 2018 Suying. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCard: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func clickNewGame(_ sender: UIButton) {
        currentEmojiChoices = emojiChoices
        game = Concentration(numberOfPairsOfCard: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        let cardNum = cardButtons.index(of: sender)!
        game.chooseCard(at: cardNum)
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻","🎃","🌛","🤡","💀","😈"]
    
    lazy var currentEmojiChoices = emojiChoices
    
    //,"👾","👺","🧠","👣"
    //[Int:String]
    var emoji = Dictionary<Int,String>()
    
    func emoji (for card: Card) -> String {
        if emoji[card.identifier] == nil, currentEmojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(currentEmojiChoices.count)))
            emoji[card.identifier] = currentEmojiChoices.remove(at:randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

    
}

