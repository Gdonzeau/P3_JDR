//
//  Player.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Player {
    static var playerNamesUsed = [String]()
    
    var numberOfHeroes = 3
    var heroes = [Character]()
    
    var name:String
    
    init(name:String) {
        self.name = name
        Player.playerNamesUsed += [name]
    }
    
    
    
  
}
