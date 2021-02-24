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
    
    var myGo = false // À qui est-ce le tour de jouer
    
    var heroes = [Character]()
    
    var name:String
    
    init(name:String) {
        self.name = name
        Player.playerNamesUsed += [name]
    }
    
    func creationHero(countStart:Int,creator:String,job:String) {
        var career = job
        for i in countStart ..< Player.numberOfHeroes {
            
            while career == "" { // Tant que la réponse n'est pas compréhensible, on redemande
                career = choiceClassnumber(number: i, creator: creator)
            }
            switch career {
            case "1":
                //heroes.append(Character.allClasses[0])
                
                heroes.append(Barbarian.init(name: giveNameHero(number: i,creator:creator), weapon: choiceWeapon(career:career)))
                
                while heroes[i].name == "" {
                    heroes[i].name = giveNameHero(number: i,creator:creator)
                }
                
                while heroes[i].weapon.name == "un petit bâton" {
                    print("Commande incorrecte")
                    heroes[i].weapon = choiceWeapon(career: career)
                }
                
                print("Bonjour \(heroes[i].name)")
                heroes[i].HPInGame = heroes[i].HPClass
                
            case "2":
                heroes.append(Paladin.init(name: giveNameHero(number: i,creator:creator), weapon: choiceWeapon(career: career)))
                
                while heroes[i].name == "" {
                    heroes[i].name = giveNameHero(number: i,creator:creator)
                }
                
                while heroes[i].weapon.name == "un petit bâton" {
                    print("Commande incorrecte")
                    heroes[i].weapon = choiceWeapon(career: career)
                }
                
                print("Bonjour \(heroes[i].name)")
                heroes[i].HPInGame = heroes[i].HPClass
                
            case "3":
                heroes.append(Druid.init(name: giveNameHero(number: i,creator:creator), weapon: choiceWeapon(career: career)))
                
                while heroes[i].name == "" {
                    heroes[i].name = giveNameHero(number: i,creator:creator)
                }
                
                while heroes[i].weapon.name == "un petit bâton" {
                    print("Commande incorrecte")
                    heroes[i].weapon = choiceWeapon(career: career)
                }
                
                print("Bonjour \(heroes[i].name)")
                heroes[i].HPInGame = heroes[i].HPClass
                
            case "4":
                heroes.append(Mage.init(name: giveNameHero(number: i,creator:creator), weapon: choiceWeapon(career: career)))
                
                while heroes[i].name == "" {
                    heroes[i].name = giveNameHero(number: i,creator:creator)
                }
                
                while heroes[i].weapon.name == "un petit bâton" {
                    print("Commande incorrecte")
                    heroes[i].weapon = choiceWeapon(career: career)
                }
                
                print("Bonjour \(heroes[i].name)")
                heroes[i].HPInGame = heroes[i].HPClass
                
            default:
                heroes.append(Character.init(name: giveNameHero(number: i,creator:creator), weapon: choiceWeapon(career: career)))
                
                while heroes[i].name == "" {
                    heroes[i].name = giveNameHero(number: i,creator:creator)
                }
                
                while heroes[i].weapon.name == "un petit bâton" {
                    print("Commande incorrecte")
                    heroes[i].weapon = choiceWeapon(career: career)
                }
                
                print("Bonjour \(heroes[i].name)")
                heroes[i].HPInGame = heroes[i].HPClass
                
            }
            
            //let test = Int(career)! // On force le déballage de l'optionnel, mais on est sûr qu'il s'agit de 1, 2, 3 ou 4.
            //print(test)
            career = ""
            
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
    
    func choiceWeapon(career:String) -> Weapon {
        var retour = Weapon()
        var nameRetour = ""
        var choice = [Weapon]() // On fait un tableau des armes existantes et autorisées en fonction de la classe du perso
        for i in 0 ..< Weapon.allWeapons.count {
            if career == "1" { // Armes autorisées pour le Barbare
                if Weapon.allWeapons[i].barbarianAuthorized {
                    choice += [Weapon.allWeapons[i]]
                }
            }
            if career == "2" { // Armes autorisées pour le Barbare
                if Weapon.allWeapons[i].paladinAuthorized {
                    choice += [Weapon.allWeapons[i]]
                }
            }
            if career == "3" { // Armes autorisées pour le Barbare
                if Weapon.allWeapons[i].druidAuthorized {
                    choice += [Weapon.allWeapons[i]]
                }
            }
            if career == "4" { // Armes autorisées pour le Barbare
                if Weapon.allWeapons[i].mageAuthorized {
                    choice += [Weapon.allWeapons[i]]
                }
            }
        }
        print("Vous pouvez choisir un équipement :")
        
        var possibilities = [Int]()
        for i in 0..<choice.count {
            print("\n\([i+1]). \(choice[i].name)")
            possibilities += [i]
        }
        if let answer = readLine() {
            // Faire deux choix : correct et incorrect avec .count
            for test in possibilities {
                if test+1 == Int(answer) {
                    nameRetour = choice[test].name
                }
            }
        }
        retour = defineWeapons(name: nameRetour)
        return retour
    }
    
    func defineWeapons(name:String) ->Weapon {
        var retour = Weapon()
        switch name {
        case "une hache":
            retour = Axe()
        case "un sort de soin majeur":
            retour = BigHealingSpell()
        case "une dague":
            retour = Dagger()
        case "un fléau":
            retour = Flail()
        case "un marteau":
            retour = Hammer()
        case "un sort de soin":
            retour = HealingSpell()
        case "une épée":
            retour = Sword()
        default :
            retour = SmallClub()
        }
        return retour
    }
    
    func giveNameHero(number:Int,creator:String)->String { // On lui donne un nom
        var retour:String = ""
        print("\(creator), comment appelez-vous votre héros numéro \(number+1) ?")
        
        if let answer = readLine() {
            
            if checkNameHero(nameToCheck:answer) {
                retour = answer
                Character.heroNamesUsed += [retour]
            }
            else {
                print("Le nom est déjà pris")
            }
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
