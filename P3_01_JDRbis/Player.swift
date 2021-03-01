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
    static var numberOfPlayers = 2
    private let probabilityOfChest = 90 // % of chance that a magical chest appears
    var myTurn = false // is it your go or not ?
    
    private var magicChestChoiceFree = true //When a magicChest appears, does the player can get everyequipment including for other classes ? For example can a Barbarian get (and use) a fireBall ?
    
    var heroes = [Character]()
    private var heroesAlive = [Character]()
    
    var name:String
    
    init(name:String) {
        self.name = name
    }
    
    //MARK: CREATION PLAYER
    
    static func createPlayer() {
        for i in 0 ..< Player.numberOfPlayers {
            
            let newPlayer = Player(name: "")
            
            while newPlayer.name == "" {
            newPlayer.name = giveNamePlayer(number: i)
                Player.playerNamesUsed.append(newPlayer.name)
            }
            game.players.append(newPlayer)
        }
    }
    
    static func giveNamePlayer(number:Int)->String { // We give a name to player...
        var retour:String = ""
        print("Hello player \(number+1), what's your name ?")
        
        if let answer = readLine() {
            
            if checkNamePlayer(nameToCheck:answer) {
                retour = answer
            }
            else {
                print("This name is not available.")
            }
        }
        return retour
    }
    
    static func checkNamePlayer(nameToCheck:String)->Bool { // ... and we check it
        var nameDontExist = true
        for name in Player.playerNamesUsed {
            if nameToCheck == name {
                nameDontExist = false
            }
        }
        return nameDontExist
    }
    
    // MARK: CREATION HERO
    
    func creationHero(creator:String) {
        var career = 0
        var heroName = ""
        var heroWeapon = Weapon()
        for i in 0 ..< Player.numberOfHeroes {
            // As far as we didn't receive a correct answer...
            while career == 0 { //... for career
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
            
            while heroName == "" { // ... for name
                heroName = giveNameHero(number: i,creator:creator)
                heroes[i].name = heroName
            }
            
            while heroWeapon.name == "nothing" { // ... and for weapon
                heroWeapon = choiceWeapon(career: Int(career))
                heroes[i].weapon = heroWeapon
            }
            
            print("Hello \(heroes[i].name)\n")
            heroes[i].HPInGame = heroes[i].HPClass
            heroesAlive.append(heroes[i])
            career = 0
            heroName = ""
            heroWeapon = Weapon()
        }
    }
    
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
                    // If we receive an optionnal, type Int which is 1,2,3 or 4 we go on.
                }
            }
            else {
                print("I didn't understand, please repeat.")
            }
        }
        return response
    }
    
    //MARK: Choice weapon
    
    private func choiceWeapon(career:Int) -> Weapon {
        var retour = Weapon()
        var nameRetour = ""
        var choice = [Weapon]()
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
    
    //MARK: Which Weapon for who ?
    
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
    
    private func giveNameHero(number:Int,creator:String)->String { // Let's give a name
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
        for name in Character.heroNamesUsed { // We compare the proposed name with names already created
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
    
    //MARK: TURN - MAIN FUNCTION
    
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
    
    private func choiceHero()-> Character {// Let's show which character can play
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
        // We check if the attacker's equipment can attack o heal to propose the appropriated target.
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
                possibilities.append(i)
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
    
    //MARK: WHO IS ALIVE
    
    func findingSurvivals() { // Checking who is still alive. Updating array heroesAlive
        game.defender.heroesAlive = [Character]() // Let's empty the array.
        for i in 0 ..< Player.numberOfHeroes { // And let's build it again
            if game.defender.heroes[i].HPInGame > 0 {
                game.defender.heroesAlive.append(game.defender.heroes[i])
            }
        }
    }
    
    // MARK: THE MAGIC CHEST
    
    private func magicChest(playingHero:Character) {
        var joker = Int()
        if Int(arc4random_uniform(UInt32(100)))+1 <= probabilityOfChest { // We throw a D100 to know if a chest appears
            print("A chest appears in front of \(playingHero.name)")
            if magicChestChoiceFree {
                // Generic Chest
                joker = Int(arc4random_uniform(UInt32(Weapon.allWeapons.count)))
                print("The chest contains \(Weapon.allWeapons[joker].name)")
                print("Do you want to exchange \(playingHero.weapon.name) for \(Weapon.allWeapons[joker].name)")
                
                print("1. Yes")
                print("2. No")
                
                if let choice = readLine() {
                    if Int(choice) == 1 {
                        print("Let's change.")
                        playingHero.weapon = Weapon.allWeapons[joker]
                    }
                    else {
                        // If the answer is not 1 or 2, we could ask to repeat. But if the player is unable to correctly use a keyboard, it is not a got idea to let him use a weapon...
                        print("No change")
                    }
                }
            }
            else {
                // Personnal chest
                joker = Int(arc4random_uniform(UInt32(Weapon.allChests[playingHero.ref].count)))
                print("The chest contains \(Weapon.allChests[playingHero.ref][joker].name)")
                print("Do you want to exchange \(playingHero.weapon.name) for \(Weapon.allChests[playingHero.ref][joker].name)")
                
                print("1. Yes")
                print("2. No")
                
                if let choice = readLine() {
                    if Int(choice) == 1 {
                        print("Let's change.")
                        playingHero.weapon = Weapon.allChests[playingHero.ref][joker]
                    }
                    else {
                        /// IIf the answer is not 1 or 2, we could ask to repeat. But if the player is unable to correctly use a keyboard, it is not a got idea to let him use a weapon...
                        print("No change")
                    }
                }
            }
        }
    }
}
