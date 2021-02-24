//
//  Mage.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 24/02/2021.
//

import Foundation

class Mage: Character {
    override var HPClass:Int { 50 }
    override var classe:String { "un mage" }
    override var hobby:String { "étudier les arcanes" }
    override func presentHimSelf() {
        super.presentHimSelf()
        print("Et voilà.")
    }
}
