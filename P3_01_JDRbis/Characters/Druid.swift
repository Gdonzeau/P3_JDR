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
    //override var armor:Int { 0 }
    override var magicProtect:Int { 20 }
    override var classe:String { "druid" }
    override var hobby:String { "walk in the forest" }
    override func presentHimSelf() {
        super.presentHimSelf()
        print("And that's all.")
    }
}
