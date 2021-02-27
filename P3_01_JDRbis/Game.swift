//
//  Game.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Game {
    
    var players = [Player]()
    var attacker = Player(name: "")
    var defender = Player(name: "")
    var numberOfPlayers = 2 // Combien de joueurs dans une partie
    var numberOfTurns = 0
    let probabilityOfChest = 90 // Pourcentage de chance d'apparition d'un coffre
    let chestIsGeneric = true //Can chest contain everything or just stuff adapted to hero opening it ?
    
    func startGame() { // Déroulement de la partie
        // On crée autant de joueurs que nécessaire
        Weapon.initializingChests()
        
        createPlayer(countStart: 0)
        // Puis on crée autant de héros que nécessaire
        for i in 0 ..< numberOfPlayers{
            players[i].creationHero(countStart: 0,creator:players[i].name)
        }
        // On présente les différents héros
        self.presentEveryBody()
        // On décide qui commence
        throwCoin()
        
        while players[0].stillAlive() > 0 && players[1].stillAlive() > 0 {
            whoseTurnIsIt()
            if checkForDraw() { break } // À retirer si on souhaite se baser sur la chance des coffres
            attacker.playTurn()
            attacker.findingSurvivals()
            changeGo()
        }
        endGame()
    }
    
    func createPlayer(countStart:Int) { // On crée un joueur pour la partie
        for i in countStart ..< numberOfPlayers {
            players.append(Player.init(name: giveNamePlayer(number: i)))
            if players[i].name == "" {
                
                players.remove(at: i)
                createPlayer(countStart: i)
                break
            }
            else {
                print("Bonjour \(players[i].name)")
            }
        }
    }
    
    func giveNamePlayer(number:Int)->String { // On lui donne un nom
        var retour:String = ""
        print("Bonjour joueur \(number+1), comment vous appelez-vous ?")
        
        if let answer = readLine() {
            
            if checkNamePlayer(nameToCheck:answer) {
                retour = answer
            }
            else {
                print("Le nom est déjà pris")
            }
        }
        return retour
    }
    
    func checkNamePlayer(nameToCheck:String)->Bool {
        var nameDontExist = true
        for name in Player.playerNamesUsed {
            if nameToCheck == name {
                nameDontExist = false
            }
        }
        return nameDontExist
    }
    
    func presentEveryBody() {
        for i in 0 ..< numberOfPlayers {
            print("\nVoici \(players[i].name).",
                  "\nIl possède \(Player.numberOfHeroes) personnages :")
            for j in 0 ..< Player.numberOfHeroes {
                print("\n- \(players[i].heroes[j].classe) qui nous a déclaré :")
                players[i].heroes[j].presentHimSelf()
            }
        }
    }
    
    func throwCoin() {
        let coin = Int(arc4random_uniform(UInt32(numberOfPlayers))) // On lance une pièce pour savoir qui commence
        print("\(players[coin].name) commence.")
        players[coin].myGo = true
    }
    
    func whoseTurnIsIt() {
        self.numberOfTurns += 1
        for player in players {
            if player.myGo {
                attacker = player
            }
            else {
                defender = player
            }
        }
        print("C'est le tour de \(attacker.name).")
    }
    func changeGo() {
        players[0].myGo = !players[0].myGo
        players[1].myGo = !players[1].myGo
    }
    
    func checkForDraw()->Bool { // If there are only healers left, nobody can wins. It is a draw
        var onlyHealers = true
        for i in 0 ..< numberOfPlayers {
            for j in 0 ..< Player.numberOfHeroes {
                if players[i].heroes[j].weapon.heals == false {
                    onlyHealers = false
                    break
                }
            }
        }
        if onlyHealers {print("Il n'y a plus aucun combattant capable de blesser. Égalité.")}
        return onlyHealers
    }
    
    func endGame() { //Mr. Stark ?
        print("Partie terminée.",
              "\nElle a duré : \(numberOfTurns) tours.")
        if players[0].stillAlive() == 0 {
            print("\(players[1].name) a gagné.")
        }
        if players[1].stillAlive() == 0 {
            print("\(players[0].name) a gagné.")
        }
    }
}
