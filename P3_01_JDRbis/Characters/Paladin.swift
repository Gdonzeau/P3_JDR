//
//  Paladin.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 24/02/2021.
//

import Foundation

class Paladin: Character {
    override var HPClass:Int { 80 }
    override var classe:String { "un paladin" }
    override var hobby:String { "méditer" }
    override func presentHimSelf() {
        super.presentHimSelf()
        print("Je pense que c'est tout.")
    }
}
