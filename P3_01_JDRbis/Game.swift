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
    
    func startGame() { // Déroulement de la parti
        // On crée autant de joueurs que nécessaire
        createPlayer(countStart: 0)
        // Puis on crée autant de héros que nécessaire
        for i in 0 ..< numberOfPlayers{
            players[i].creationHero(countStart: 0,creator:players[i].name)
        }
        // On présente les différents héros
        self.presentEveryBody()
        // On décide qui commence
        throwCoin()
        
        while players[0].stillPlaying() > 0 && players[1].stillPlaying() > 0 {
        whoseTurnIsIt()
        attacker.playTurn()
            attacker.findingSurvivals()
        changeGo()
        
            /*
            attacker.heroActivated = attacker.choiceHeros()
            attacker.choiceHeros().actionOn(receiver: self.attacker.choiceTarget(heal: attacker.choiceHeros().weapon.Heals))
            */
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
    
    func endGame() {
        print("Partie terminée")
    }
}
