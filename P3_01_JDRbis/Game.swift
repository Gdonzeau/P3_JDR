//
//  Game.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Game {
    
    var players = [Player]()
    private var attacker = Player(name: "") // Who is the attacker and who is the defender
    var defender = Player(name: "")
    //private var numberOfPlayers = 2 // How many players
    private var numberOfTurns = 0
    
    func startGame() { // ... to start the game, yes !
        
        Weapon.initializingChests()// One chest for each class
        
        Player.createPlayer()
        
        for i in 0 ..< Player.numberOfPlayers {
            players[i].creationHero(creator:players[i].name)
        }
        
        self.presentEveryBody()
        
        throwCoin() // Who starts ?
        
        while players[0].stillAlive() > 0 && players[1].stillAlive() > 0 { // Still HP left ? Let's play
            
            whoseTurnIsIt()
            if checkForDraw() { break } // If there are only healers, it is a draw. Put it in commentary to desactivate
            attacker.playTurn()
            attacker.findingSurvivals()
            changeGo() // It is the other player's go and we start a new turn
        }
        endGame()
    }
    /*
    private func createPlayer(countStart:Int) {
        for i in countStart ..< numberOfPlayers {
            players.append(Player.init(name: giveNamePlayer(number: i)))
            // We create a new player. If his name is already taken (return will be ""), we delete the player and start again.
            
            if players[i].name == "" {
                players.remove(at: i)
                createPlayer(countStart: i)
                break
            }
            else {
                print("Hello \(players[i].name)\n")
            }
        }
    }
    
    private func giveNamePlayer(number:Int)->String { // We give a name to player...
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
    
    private func checkNamePlayer(nameToCheck:String)->Bool { // ... and we check it
        var nameDontExist = true
        for name in Player.playerNamesUsed {
            if nameToCheck == name {
                nameDontExist = false
            }
        }
        return nameDontExist
    }
 */
 
    private func presentEveryBody() { // Function to introcduce players and to ask each hero to introduce himself
        for i in 0 ..< Player.numberOfPlayers {
            print("\nHere's \(players[i].name).",
                  "\nHe has \(Player.numberOfHeroes) heroes :")
            for j in 0 ..< Player.numberOfHeroes {
                print("\n- One \(players[i].heroes[j].classe) who told us :")
                players[i].heroes[j].presentHimSelf()
            }
        }
    }
    
    private func throwCoin() { // Function to decide who starts
        let coin = Int(arc4random_uniform(UInt32(Player.numberOfPlayers)))
        print("\n\(players[coin].name) starts.")
        players[coin].myGo = true
    }
    
    private func whoseTurnIsIt() { // Function to manage whose turn it is.
        self.numberOfTurns += 1 // and how many turns are played
        for player in players {
            if player.myGo { // It's my go ?
                attacker = player // So I attack
            }
            else {
                defender = player // and you defend
            }
        }
        print("\nIt is \(attacker.name)'s go.")
    }
    private func changeGo() { // I just played, it's your turn.
        players[0].myGo = !players[0].myGo
        players[1].myGo = !players[1].myGo
    }
    
    private func checkForDraw()->Bool { // If there are only healers left, nobody can win. It is a draw.
        var onlyHealers = true
        for i in 0 ..< Player.numberOfPlayers {
            for j in 0 ..< Player.numberOfHeroes {
                if players[i].heroes[j].weapon.heals == false {
                    onlyHealers = false
                    break
                }
            }
        }
        if onlyHealers {print("There are no more fighters able to wouhd. This is a draw.")}
        return onlyHealers
    }
    
    private func endGame() { //Mr. Stark ?
        print("Game over.",
              "\nThe game lasted : \(numberOfTurns) turns.")
        if players[0].stillAlive() == 0 {
            print("\(players[1].name) won.")
        }
        if players[1].stillAlive() == 0 {
            print("\(players[0].name) won.")
        }
    }
}
