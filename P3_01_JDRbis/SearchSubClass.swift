//
//  SearchSubClass.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 27/02/2021.
//

import Foundation
/*
func subclasses<Weapon>(of theClass: Weapon) -> [Weapon] {
    var count: UInt32 = 0, result: [Weapon] = []
    let allClasses = objc_copyClassList(&count)!

    for n in 0 ..< count {
        let someClass: AnyClass = allClasses[Int(n)]
        guard let someSuperClass = class_getSuperclass(someClass), String(describing: someSuperClass) == String(describing: theClass) else { continue }
        result.append(someClass as! Weapon)
    }

    return result
}
*/
