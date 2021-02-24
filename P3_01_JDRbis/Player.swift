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
    
    func creationHero(countStart:Int,creator:String,job:String) {
        var career = job
        for i in countStart ..< Player.numberOfHeroes {
            
            if career == "" {
                career = choiceClassnumber(number: i, creator: creator)
            }
            
            while career == "" { // Tant que la réponse n'est pas compréhensible, on redemande
                career = choiceClassnumber(number: i, creator: creator)
            }
            switch career {
            case "1":
                heroes.append(Barbarian.init(name: giveNameHero(number: i,creator:creator), weapon: choiceWeapon()))
                if heroes[i].name == "" {
                    // On supprime la case et on relance la fonction
                    heroes.remove(at: i)
                    creationHero(countStart: i,creator:creator,job:career)
                    break
                }
                else {
                    print("Bonjour \(heroes[i].name)")
                }
            case "2":
                heroes.append(Paladin.init(name: giveNameHero(number: i,creator:creator), weapon: choiceWeapon()))
                if heroes[i].name == "" {
                    // On supprime la case et on relance la fonction
                    heroes.remove(at: i)
                    creationHero(countStart: i,creator:creator,job: career)
                    break
                }
                else {
                    print("Bonjour \(heroes[i].name)")
                }
            case "3":
                heroes.append(Druid.init(name: giveNameHero(number: i,creator:creator), weapon: choiceWeapon()))
                if heroes[i].name == "" {
                    // On supprime la case et on relance la fonction
                    heroes.remove(at: i)
                    creationHero(countStart: i,creator:creator,job: career)
                    break
                }
                else {
                    print("Bonjour \(heroes[i].name)")
                }
            case "4":
                heroes.append(Mage.init(name: giveNameHero(number: i,creator:creator), weapon: choiceWeapon()))
                if heroes[i].name == "" {
                    // On supprime la case et on relance la fonction
                    heroes.remove(at: i)
                    creationHero(countStart: i,creator:creator,job: career)
                    break
                }
                else {
                    print("Bonjour \(heroes[i].name)")
                }
            default:
                heroes.append(Character.init(name: giveNameHero(number: i,creator:creator), weapon: choiceWeapon()))
                if heroes[i].name == "" {
                    // On supprime la case et on relance la fonction
                    heroes.remove(at: i)
                    creationHero(countStart: i,creator:creator,job: career)
                    break
                }
            }
            career = ""
              //  print("Bonjour \(heroes[i].name)")
        }
    }
    
    func choiceClassnumber(number:Int,creator:String)->String {
        var retour:String = ""
        print("\(creator), quelle classe donnez-vous à votre héros numéro \(number+1) ?",
              "\n1. Barbare",
              "\n2. Paladin",
              "\n3. Druide",
              "\n4. Mage")
        
        if let answer = readLine() {
            if answer == "1" || answer == "2" || answer == "3" || answer == "4" {
                retour = answer
            }
            else {
                print("Je n'ai pas compris, veuillez refaire votre choix.")
            }
        }
        return retour
    }
    
    func choiceWeapon() -> Weapon {
        var retour = Weapon()
        return retour
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
