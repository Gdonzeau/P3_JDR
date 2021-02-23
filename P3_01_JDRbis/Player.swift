//
//  Player.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Player {
    static var playerNamesUsed = [String]()
    static var numberOfHeroes:Int = 3
    
    var heroes = [Character]()
    
    var name:String
    
    init(name:String) {
        self.name = name
        Player.playerNamesUsed += [name]
    }
    
    func creationHero(countStart:Int,creator:String) {
        for i in countStart ..< Player.numberOfHeroes {
            heroes.append(Character.init(name: giveNameHero(number: i,creator:creator)))
            if heroes[i].name == "" {
                // On supprime la case et on relance la fonction
                heroes.remove(at: i)
                creationHero(countStart: i,creator:creator)
                break
            }
            else {
                print("Bonjour \(heroes[i].name)")
            }
        }
    }
    
    func choiceClass() {
        
    }
    
    func giveNameHero(number:Int,creator:String)->String { // On lui donne un nom
        var retour:String = ""
        print("\(creator), comment appelez-vous votre héros numéro \(number+1) ?")
        
        if let answer = readLine() {
            
            if checkNameHero(nameToCheck:answer) {
              //  print("Nom différent")
                retour = answer
            }
            else {
               print("Le nom est déjà pris")
                //answer = ""
            }
 
            //retour = answer
        }
        return retour
    }
    
    func checkNameHero(nameToCheck:String)->Bool {
        var nameDontExist = true
        for name in Character.heroNamesUsed {
            if nameToCheck == name {
                nameDontExist = false
            }
        }
        return nameDontExist
    }
    
    
}
