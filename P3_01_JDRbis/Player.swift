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
    
    var myGo = false // À qui est-ce le tour de jouer ?
    
    var heroes = [Character]()
    var heroesAlive = [Character]()
    
    var name:String
    
    init(name:String) {
        self.name = name
        Player.playerNamesUsed += [name]
    }
    
    // MARK: CREATION
    
    func creationHero(countStart:Int,creator:String) {
        var career = ""
        var heroName = ""
        var heroWeapon = Weapon()
        for i in countStart ..< Player.numberOfHeroes {
            
            while career == "" { // Tant que la réponse n'est pas compréhensible, on redemande
                career = choiceClassnumber(number: i, creator: creator)
            }
            
            while heroName == "" {
                heroName = giveNameHero(number: i,creator:creator)
            }
            
            while heroWeapon.name == "un petit bâton" {
                heroWeapon = choiceWeapon(career: career)
            }
            
            //    createHero(Charac: <#T##Character#>, name: <#T##String#>, weapon: <#T##Weapon#>)
            //    createHero(type(of: Character(name: name, weapon: Weapon)))
            switch career {
            case "1":
                heroes.append(Barbarian.init(name: heroName, weapon: heroWeapon))
                
            case "2":
                heroes.append(Paladin.init(name: heroName, weapon: heroWeapon))
                
            case "3":
                heroes.append(Druid.init(name: heroName, weapon: heroWeapon))
                
            case "4":
                heroes.append(Mage.init(name: heroName, weapon: heroWeapon))
                
            default:
                heroes.append(Character.init(name: heroName, weapon: heroWeapon))
            }
            
            print("Bonjour \(heroes[i].name)")
            heroes[i].HPInGame = heroes[i].HPClass
            heroesAlive.append(heroes[i])
            career = ""
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
    
    //MARK: Choice weapon
    
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
    
    //MARK: What kind of weapon for who ?
    
    func defineWeapons(name:String) ->Weapon {
        var retour = Weapon()
        //Amélioration possible :
        for i in 0 ..< Weapon.allWeapons.count {
            if name == Weapon.allWeapons[i].name {
                retour = Weapon.allWeapons[i]
            }
            /*
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
             case "une boule de feu":
             retour = FireBall()
             default :
             retour = SmallClub()
             }
             */
        }
        return retour
    }
    
    //MARK: Giving name
    
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
    
    //MARK: Checking name
    
    func checkNameHero(nameToCheck:String)->Bool {
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
    
    func stillPlaying()->Int { // Checking total heroes' HP left
        var retour = 0
        for i in 0 ..< Player.numberOfHeroes {
            retour += self.heroes[i].HPInGame
        }
        print("Les héros de \(self.name) ont \(retour) PV restants.")
        return retour
    }
    
    func playTurn() {
        var heroActivated = Character(name: "", weapon: Weapon())
        var target = Character(name: "", weapon: Weapon())
        
        while heroActivated.name == "" {
            heroActivated = choiceHeros()
        }
        
        magicChest(playingHero: heroActivated)
        
        while target.name == "" {
            target = choiceTarget(heal: heroActivated.weapon.Heals)
        }
        
        heroActivated.actionOn(receiver: target)
        
        heroActivated = Character(name: "", weapon: Weapon())
        target = Character(name: "", weapon: Weapon())
    }
    
    func choiceHeros()-> Character {// Affiche le nom des persos du joueurs
        var retour = Character(name: "", weapon: Weapon())
        var possibilities = [Int]()
        for i in 0..<self.heroesAlive.count {
            possibilities += [i]
        }
        print("Qui choisissez-vous pour ce tour ?")
        for i in 0 ..< self.heroesAlive.count {
            print("[\(i+1)]. \(self.heroesAlive[i].name)")
        }
        if let answer = readLine() {
            var ok = false
            for test in possibilities {
                if test+1 == Int(answer) {
                    retour = self.heroesAlive[test]
                    print("Très bien")
                    ok = true
                    break
                }
            }
            if ok == false {
                print("Je n'ai pas compris")
            }
        }
        return retour
    }
    
    func choiceTarget(heal:Bool)-> Character {
        var retour = Character(name: "", weapon: Weapon())
        var possibilities = [Int]()
        // On vérifie si l'attaquant soigne ou attaque
        if heal {
            for i in 0..<self.heroesAlive.count {
                possibilities += [i]
            }
            print("Qui choisissez-vous de soigner pour ce tour ?")
            for i in 0 ..< self.heroesAlive.count {
                print("[\(i+1)]. \(self.heroesAlive[i].name)")
            }
            if let answer = readLine() {
                var ok = false
                for test in possibilities {
                    if test+1 == Int(answer) {
                        retour = self.heroesAlive[test]
                        print("Entendu")
                        ok = true
                        break
                    }
                }
                if ok == false {
                    print("Je n'ai pas compris")
                }
            }
        }
        else {
            for i in 0..<game.defender.heroesAlive.count {
                possibilities += [i]
            }
            print("Qui choisissez-vous d'attaquer pour ce tour ?")
            for i in 0 ..< game.defender.heroesAlive.count {
                print("[\(i+1)]. \(game.defender.heroesAlive[i].name)")
            }
            if let answer = readLine() {
                var ok = false
                for test in possibilities {
                    if test+1 == Int(answer) {
                        retour = game.defender.heroesAlive[test]
                        print("Parfait")
                        ok = true
                        break
                    }
                }
                if ok == false {
                    print("Je n'ai pas compris")
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
    
    func magicChest(playingHero:Character) {
        var joker = Int()
        if Int(arc4random_uniform(UInt32(100)))+1 <= game.probabilityOfChest { // On lance un D100 pour savoir si un coffre apparaît
            print("Un coffre apparaît devant \(playingHero.name)")
            joker = Int(arc4random_uniform(UInt32(Weapon.allWeapons.count)))
            print("Le coffre contient \(Weapon.allWeapons[joker].name)")
            print("Souhaitez-vous échanger \(playingHero.weapon.name) contre \(Weapon.allWeapons[joker].name)")
            print("1. Oui")
            print("2. Non")
            
            if let choice = readLine() {
                if Int(choice) == 1 {
                    playingHero.weapon = Weapon.allWeapons[joker]
                }
                else {
                    // On pourrait aussi répéter en cas de réponse ni 1 ni 2. Mais si le joueur n'arrive pas à appuyer sur la bonne touche, c'est peut-être imprudent de lui laisser une arme. ;)
                    print("On ne change pas")
                }
            }
        }
    }
}
