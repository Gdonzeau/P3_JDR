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
    
    var myGo = false // is it your go or not ?
    
    private var magicChestChoiceFree = true //When a magicChest appears, does the player can get everyequipment including for other classes ? For example can a Barbarian get (and use) a fireBall ?
    
    var heroes = [Character]()
    private var heroesAlive = [Character]()
    
    var name:String
    
    init(name:String) {
        self.name = name
        Player.playerNamesUsed += [name]
    }
    
    // MARK: CREATION
    
    func creationHero(countStart:Int,creator:String) {
        var career = 0
        var heroName = ""
        var heroWeapon = Weapon()
        for i in countStart ..< Player.numberOfHeroes {
            
            while career == 0 { // Tant que la réponse n'est pas compréhensible, on redemande
                career = choiceClass(number: i, creator: creator)
            }
            
            switch career {
            case 1:
                heroes.append(Barbarian.init(name: heroName, weapon: heroWeapon))
                
            case 2:
                heroes.append(Druid.init(name: heroName, weapon: heroWeapon))
                
            case 3:
                heroes.append(Paladin.init(name: heroName, weapon: heroWeapon))
                
            case 4:
                heroes.append(Mage.init(name: heroName, weapon: heroWeapon))
                
            default:
                heroes.append(Character.init(name: heroName, weapon: heroWeapon))
            }
            
            while heroName == "" {
                heroName = giveNameHero(number: i,creator:creator)
                heroes[i].name = heroName
            }
            
            while heroWeapon.name == "nothing" {
                heroWeapon = choiceWeapon(career: Int(career))
                heroes[i].weapon = heroWeapon
            }
            
            //    createHero(Charac: <#T##Character#>, name: <#T##String#>, weapon: <#T##Weapon#>)
            //    createHero(type(of: Character(name: name, weapon: Weapon)))
     /*
            switch career {
            case 1:
                heroes.append(Barbarian.init(name: heroName, weapon: heroWeapon))
                
            case 2:
                heroes.append(Druid.init(name: heroName, weapon: heroWeapon))
                
            case 3:
                heroes.append(Paladin.init(name: heroName, weapon: heroWeapon))
                
            case 4:
                heroes.append(Mage.init(name: heroName, weapon: heroWeapon))
                
            default:
                heroes.append(Character.init(name: heroName, weapon: heroWeapon))
            }
 */
            //Character.allClassesCreator[career]
            
            
            print("Hello \(heroes[i].name)\n")
            heroes[i].HPInGame = heroes[i].HPClass
            heroesAlive.append(heroes[i])
            career = 0
            heroName = ""
            heroWeapon = Weapon()
        }
    }
    /*
     func createHero(Carac : Character.init(name:String,weapon:Weapon)) {
     heroes.append(Carac)
     }
     */
    //MARK: Choice class
    
    private func choiceClass(number:Int,creator:String)->Int {
        var response = 0
        print("\(creator), which class do you choose for your hero number \(number+1) ?",
              "\n1. Barbarian",
              "\n2. Druid",
              "\n3. Paladin",
              "\n4. Mage")
        
        if let answer = readLine() {
            if Int(answer) == 1 || Int(answer) == 2 || Int(answer) == 3 || Int(answer) == 4 {
                if let retour = Int(answer) {
                    response = retour
                }
            }
            else {
                print("I didn't undertand, please repeat.")
            }
        }
        return response
    }
    
    //MARK: Choice weapon
    
    private func choiceWeapon(career:Int) -> Weapon {
        var retour = Weapon()
        var nameRetour = ""
        var choice = [Weapon]()
        //var number = Int(career)
        choice = Weapon.allChests[career-1]
        
        print("\nChoose an equipment :")
        
        var possibilities = [Int]()
        for i in 0..<choice.count {
            print("\n\([i+1]). \(choice[i].name)")
            possibilities += [i]
        }
        if let answer = readLine() {
            for test in possibilities {
                if test+1 == Int(answer) {
                    nameRetour = choice[test].name
                }
            }
        }
        retour = defineWeapons(name: nameRetour)
        return retour
    }
    
    //MARK: What kind of weapon for who ?
    
    private func defineWeapons(name:String) ->Weapon {
        var retour = Weapon()
        for i in 0 ..< Weapon.allWeapons.count {
            if name == Weapon.allWeapons[i].name {
                retour = Weapon.allWeapons[i]
            }
        }
        return retour
    }
    
    //MARK: Giving name
    
    private func giveNameHero(number:Int,creator:String)->String { // On lui donne un nom
        var retour:String = ""
        print("\(creator), how do you name your \(self.heroes[number].classe) ?")
        
        if let answer = readLine() {
            
            if checkNameHero(nameToCheck:answer) {
                retour = answer
                Character.heroNamesUsed += [retour]
            }
            else {
                print("\nName already choosen.\n")
            }
        }
        return retour
    }
    
    //MARK: Checking name
    
    private func checkNameHero(nameToCheck:String)->Bool {
        var nameDontExist = true
        for name in Character.heroNamesUsed {
            if nameToCheck == name {
                nameDontExist = false
            }
        }
        return nameDontExist
    }
    
    //MARK: END CREATION
    
    
    
    //MARK: PLAY
    
    func stillAlive()->Int { // Checking total heroes' HP left
        var retour = 0
        for i in 0 ..< Player.numberOfHeroes {
            retour += self.heroes[i].HPInGame
        }
        print("\n\(self.name)'s heroes have \(retour) HP left.")
        return retour
    }
    
    func playTurn() {
        var heroActivated = Character(name: "", weapon: Weapon())
        var target = Character(name: "", weapon: Weapon())
        
        while heroActivated.name == "" {
            heroActivated = choiceHero()
        }
        
        magicChest(playingHero: heroActivated)
        
        while target.name == "" {
            target = choiceTarget(heal: heroActivated.weapon.heals)
        }
        
        heroActivated.actionOn(receiver: target)
        
        heroActivated = Character(name: "", weapon: Weapon())
        target = Character(name: "", weapon: Weapon())
    }
    
    private func choiceHero()-> Character {// Affiche le nom des persos du joueurs
        var retour = Character(name: "", weapon: Weapon())
        var possibilities = [Int]()
        for i in 0..<self.heroesAlive.count {
            possibilities += [i]
        }
        print("Who do you choose for this turn ?")
        for i in 0 ..< self.heroesAlive.count {
            print("[\(i+1)]. \(self.heroesAlive[i].name)")
        }
        if let answer = readLine() {
            var ok = false
            for test in possibilities {
                if test+1 == Int(answer) {
                    retour = self.heroesAlive[test]
                    print("Good.")
                    ok = true
                    break
                }
            }
            if ok == false {
                print("I didn't understand.")
            }
        }
        return retour
    }
    
    private func choiceTarget(heal:Bool)-> Character {
        var retour = Character(name: "", weapon: Weapon())
        var possibilities = [Int]()
        // On vérifie si l'attaquant soigne ou attaque
        if heal {
            for i in 0..<self.heroesAlive.count {
                possibilities += [i]
            }
            print("Who do you want to heal ?")
            for i in 0 ..< self.heroesAlive.count {
                print("[\(i+1)]. \(self.heroesAlive[i].name) the \(self.heroesAlive[i].classe) who has \(self.heroesAlive[i].HPInGame) HP left.")
            }
            if let answer = readLine() {
                var ok = false
                for test in possibilities {
                    if test+1 == Int(answer) {
                        retour = self.heroesAlive[test]
                        print("Ok")
                        ok = true
                        break
                    }
                }
                if ok == false {
                    print("Please repeat.")
                }
            }
        }
        else {
            for i in 0..<game.defender.heroesAlive.count {
                possibilities += [i]
            }
            print("Who do you want to attack ?")
            for i in 0 ..< game.defender.heroesAlive.count {
                print("[\(i+1)]. \(game.defender.heroesAlive[i].name) the \(game.defender.heroesAlive[i].classe) who has \(game.defender.heroesAlive[i].HPInGame) HP left.")
            }
            if let answer = readLine() {
                var ok = false
                for test in possibilities {
                    if test+1 == Int(answer) {
                        retour = game.defender.heroesAlive[test]
                        print("All right.")
                        ok = true
                        break
                    }
                }
                if ok == false {
                    print("I didn't understand.")
                }
            }
        }
        return retour
    }
    
    func findingSurvivals() { // Checking who is still alive. Updating array heroesAlive
        game.defender.heroesAlive = [Character]() // On vide le tableau et on supprime les cases
        for i in 0 ..< Player.numberOfHeroes { // Et on le refait
            if game.defender.heroes[i].HPInGame > 0 {
                game.defender.heroesAlive.append(game.defender.heroes[i])
            }
        }
    }
    
    private func magicChest(playingHero:Character) {
        var joker = Int()
        if Int(arc4random_uniform(UInt32(100)))+1 <= game.probabilityOfChest { // On lance un D100 pour savoir si un coffre apparaît
            print("A chest appears in front of \(playingHero.name)")
            if magicChestChoiceFree {
            // Generic Chest
            joker = Int(arc4random_uniform(UInt32(Weapon.allWeapons.count)))
            print("The chest contains \(Weapon.allWeapons[joker].name)")
            print("Do you want to exchange \(playingHero.weapon.name) for \(Weapon.allWeapons[joker].name)")
        }
        else {
            // Personnal chest
            joker = Int(arc4random_uniform(UInt32(Weapon.allChests[playingHero.ref].count)))
            print("The chest contains \(Weapon.allChests[playingHero.ref][joker].name)")
            print("Do you want to exchange \(playingHero.weapon.name) for \(Weapon.allChests[playingHero.ref][joker].name)")
        }
            print("1. Yes")
            print("2. No")
            
            if let choice = readLine() {
                if Int(choice) == 1 {
                    print("Let's change.")
                    playingHero.weapon = Weapon.allChests[playingHero.ref][joker]
                }
                else {
                    // On pourrait aussi répéter en cas de réponse ni 1 ni 2. Mais si le joueur n'arrive pas à appuyer sur la bonne touche, c'est peut-être imprudent de lui laisser une arme. ;)
                    print("No change")
                }
            }
        }
    }
}
