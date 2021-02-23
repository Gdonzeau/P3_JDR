//
//  Game.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Game {
    
    var Players = [Player]()
    
    var numberOfPlayers = 5 // Combien de joueurs dans une partie
    
    func startGame() {
        // On crée autant de joueurs que nécessaire
        createPlayer(countStart: 0)
        for i in 0 ..< numberOfPlayers{
            Players[i].creationHero(countStart: 0,creator:Players[i].name)
        }
    }
    
    func createPlayer(countStart:Int) { // On crée un joueur pour la partie
        for i in countStart ..< numberOfPlayers {
            Players.append(Player.init(name: giveNamePlayer(number: i)))
            if Players[i].name == "" {
                // On supprime la case et on relance la fonction
                Players.remove(at: i)
                createPlayer(countStart: i)
                break
            }
            else {
                print("Bonjour \(Players[i].name)")
            }
        }
    }
    
    func giveNamePlayer(number:Int)->String { // On lui donne un nom
        var retour:String = ""
        print("Bonjour joueur \(number+1), comment vous appelez-vous ?")
        
        if let answer = readLine() {
            
            if checkNamePlayer(nameToCheck:answer) {
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
    
    func checkNamePlayer(nameToCheck:String)->Bool {
        var nameDontExist = true
        for name in Player.playerNamesUsed {
            if nameToCheck == name {
                nameDontExist = false
            }
        }
        return nameDontExist
    }
}
