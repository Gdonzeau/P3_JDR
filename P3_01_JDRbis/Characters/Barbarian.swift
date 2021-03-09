//
//  Barbarian.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class Barbarian: Character {
    override var ref:Int { 0 }
    override var HPClass:Int { 120 }
    override var classe:String { "barbarian" }
    override var hobby:String { "start fights at the inn" } // A barbarian is a barbarian...
    override func presentHimSelf() {
        super.presentHimSelf()
        print("And this is cool !")
    }
}
