//
//  SmallStaff.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 24/02/2021.
//

import Foundation

class SmallClub:Weapon {
    override var name: String { "un petit bâton" }
    override var damage: Int { 10 }
    override var number:Int { 7 }
    override var barbarianAuthorized:Bool { true }
    override var druidAuthorized:Bool { true }
    override var paladinAuthorized:Bool { true }
    override var mageAuthorized:Bool { true }
}
