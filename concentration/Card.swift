//
//  Card.swift
//  cncentration
//
//  Created by Павел Звеглянич on 14.05.2020.
//  Copyright © 2020 Павел Звеглянич. All rights reserved.
//

import Foundation


struct Card: Hashable {
    
    var hashValue: Int {return identifer}
    
    
    
    static func ==(lhs: Card, rhs:  Card) -> Bool {
        return lhs.identifer == rhs.identifer
    }
    var isFaceUp = false
    var isMatched = false
    private var identifer: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentefer() -> Int {
        identifierFactory += 1
        print ()
        return identifierFactory
    }
    
    init () {
        self.identifer  =  Card.getUniqueIdentefer()
    }
}

