//
//  ViewController.swift
//  cncentration
//
//  Created by Павел Звеглянич on 09.05.2020.
//  Copyright © 2020 Павел Звеглянич. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController { //Controller

    private lazy var game = Concentration(numberOfPairsCards: numberOfPairsCards) //Model
    
    var numberOfPairsCards: Int {
            return (cardButtons.count + 1) / 2
    }
    
    private (set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.7490196078, green: 0.3529411765, blue: 0.9490196078, alpha: 1)]
        let attributeString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributeString
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBAction private func newGame(_ sender: UIButton) { // не работает когда меняешь тему
        ClearGame()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let numberCard = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: numberCard)
            updateViewFromModel()
        } else {
            print("nothing")
        }
    }
    
    //MARK: - Modify code (delete/replace repeating code)
    private func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji (for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 0) : #colorLiteral(red: 0.7490196078, green: 0.3529411765, blue: 0.9490196078, alpha: 1)
                }
            }
        }
    }
    
    private func ClearGame () {
        game.clearOf()
        for index in cardButtons.indices {
            cardButtons[index].setTitle("", for: UIControl.State.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.3529411765, blue: 0.9490196078, alpha: 1)
        }
        flipCount = 0
        emojiChoices = "🦇😱🙀😈🎃👻🍭🍬"
        game = Concentration.init(numberOfPairsCards: (cardButtons.count + 1) / 2)
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬"
    
    private var emoji = [Card : String]()
    
    private func emoji(for card: Card) -> String {
            if emoji[card] == nil, emojiChoices.count > 0 {
                let randomIndex = arc4random_uniform(UInt32(emojiChoices.count))
                let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: Int(randomIndex))
                emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            }
        return emoji[card] ?? "?"
    }
}

