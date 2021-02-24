//
//  Game.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Game {
    
    var Players = [Player]()
    
    var numberOfPlayers = 2 // Combien de joueurs dans une partie
    
    func startGame() { // Déroulement de la parti
        // On crée autant de joueurs que nécessaire
        createPlayer(countStart: 0)
        // Puis on crée autant de héros que nécessaire
        for i in 0 ..< numberOfPlayers{
            Players[i].creationHero(countStart: 0,creator:Players[i].name, job: "")
        }
        // On décide qui commence
        throwCoin()
    }
    
    func createPlayer(countStart:Int) { // On crée un joueur pour la partie
        for i in countStart ..< numberOfPlayers {
            Players.append(Player.init(name: giveNamePlayer(number: i)))
            if Players[i].name == "" {
                
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
            print("\nVoici \(Players[i].name).",
                  "\nIl possède \(Player.numberOfHeroes) personnages :")
            for j in 0 ..< Player.numberOfHeroes {
                print("\n- \(Players[i].heroes[j].classe) qui nous a déclaré :")
                Players[i].heroes[j].presentHimSelf()
            }
        }
    }
    
    func throwCoin() {
        let pièce = Int(arc4random_uniform(UInt32(2))) // On lance une pièce pour savoir qui commence
        print("\(Players[pièce].name) commence.")
        Players[pièce].myGo = true
    }
}
