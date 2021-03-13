//
//  Game.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Game {
    
    private var numberOfTurns = 0
    
    func startGame() { // ... to start the game, yes !
        
        Weapon.initializingChests()// One chest for each class
        
        Player.createPlayer() // renvoie un tableau de player
        
        for i in 0 ..< Player.numberOfPlayers {
            Player.players[i].creationHero(creator:Player.players[i].name)
        }
        
        presentEveryBody()
        
        throwCoin() // Who starts ?
        
        while Player.players[0].stillAlive() > 0 && Player.players[1].stillAlive() > 0 { // Still HP left ? Let's play
            
            whoseTurnIsIt()
            if checkForDraw() { break } // If there are only healers, it is a draw. Put it in commentary to desactivate
            Player.attacker.playTurn()
            Player.attacker.findingSurvivals()
            changeTurn() // It is the other player's turbn and we start a new turn
        }
        endGame()
    }
    
    private func presentEveryBody() { // Function to introcduce players and to ask each hero to introduce himself
        for i in 0 ..< Player.numberOfPlayers {
            print("\nHere's \(Player.players[i].name).",
                  "\nHe has \(Player.numberOfHeroes) heroes :")
            for j in 0 ..< Player.numberOfHeroes {
                print("\n- One \(Player.players[i].heroes[j].classe) who told us :")
                Player.players[i].heroes[j].presentHimSelf()
            }
        }
    }
    
    private func throwCoin() { // Function to decide who starts
        let coin = Int.random(in: 0 ..< Player.numberOfPlayers)
        print("\n\(Player.players[coin].name) starts.")
        Player.players[coin].myTurn = true
    }
    
    private func whoseTurnIsIt() { // Function to manage whose turn it is.
        self.numberOfTurns += 1 // and how many turns are played
        for player in Player.players {
            if player.myTurn { // It's my turn ?
                Player.attacker = player // So I attack
            } else {
                Player.defender = player // and you defend
            }
        }
        print("\nIt is \(Player.attacker.name)'s turn.")
    }
    private func changeTurn() { // I just played, it's your turn.
        Player.players[0].myTurn.toggle()
        Player.players[1].myTurn.toggle()
    }
    
    private func checkForDraw()->Bool { // If there are only healers left, nobody can win. It is a draw.
        var onlyHealers = true
        for i in 0 ..< Player.numberOfPlayers {
            for j in 0 ..< Player.players[i].heroesAlive.count {
                if Player.players[i].heroesAlive[j].weapon.heals == false {
                    onlyHealers = false
                    break
                }
            }
        }
        if onlyHealers {print("There are no more fighters able to wound. This is a draw.")}
        return onlyHealers
    }
    
    private func endGame() { //Mr. Stark ?
        print("Game over.",
              "\nThe game lasted : \(numberOfTurns) turns.")
        if Player.players[0].stillAlive() == 0 {
            print("\(Player.players[1].name) won.")
        }
        if Player.players[1].stillAlive() == 0 {
            print("\(Player.players[0].name) won.")
        }
        presentEveryBody()
    }
}
