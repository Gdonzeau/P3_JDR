//
//  Mage.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 24/02/2021.
//

import Foundation

class Mage: Character {
    override var ref:Int { 3 }
    override var HPClass:Int { 50 }
    //override var armor:Int { 0 }
    override var classe:String { "mage" }
    override var hobby:String { "study books" }
    override func presentHimSelf() {
        super.presentHimSelf()
        print("It is very interesting.")
    }
}
