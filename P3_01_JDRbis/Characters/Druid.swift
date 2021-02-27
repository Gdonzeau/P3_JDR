//
//  Druid.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 24/02/2021.
//

import Foundation

class Druid: Character {
    override var ref:Int { 1 }
    override var HPClass:Int { 60 }
    override var armor:Int { 0 }
    override var magicProtect:Int { 60 }
    override var classe:String { "un druide" }
    override var hobby:String { "me promener dans la forêt" }
    override func presentHimSelf() {
        super.presentHimSelf()
        print("Et c'est tout pour moi.")
    }
}
