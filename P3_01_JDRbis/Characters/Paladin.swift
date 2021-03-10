//
//  Paladin.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 24/02/2021.
//

import Foundation

class Paladin: Character {
    override var ref:Int { 2 }
    override var HPClass:Int { 80 }
    override var magicProtect:Int { 20 }
    override var classe:String { "paladin" }
    override var hobby:String { "meditate" }
    override func presentHimSelf() {
        super.presentHimSelf()
        print("And it is a good thing.")
    }
}
