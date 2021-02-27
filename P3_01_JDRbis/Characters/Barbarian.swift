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
    override var armor:Int { 0 }
    override var classe:String { "barbare" }
    override var hobby:String { "taper sur les gens" }
    override func presentHimSelf() {
        super.presentHimSelf()
        print("Et c'est chouette.")
    }
}
