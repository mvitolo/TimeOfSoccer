//
//  TosCalculator.swift
//  TOS
//
//  Created by Matteo Vitolo on 30/07/15.
//  Copyright (c) 2015 Matteo Vitolo. All rights reserved.
//

import Foundation

public class TOSCalculator {

    internal var team = NSMutableDictionary()
    internal var coach1 = NSDictionary()
    internal var coach2 = NSDictionary()
    internal var coach3 = NSDictionary()
    internal var players = NSArray()
    internal var coaches = NSArray()
    
    class var sharedInstance: TOSCalculator {
        struct Static {
            static let instance: TOSCalculator = TOSCalculator()
        }
        return Static.instance
    }
    
    init() {
        
        var jsonDict = getJsonData("players")
        var jsonContainer = jsonDict.objectForKey("Players") as! NSDictionary
        players = jsonContainer.objectForKey("Player") as! NSArray
        
        jsonDict = getJsonData("coaches")
        jsonContainer = jsonDict.objectForKey("Coaches") as! NSDictionary
        coaches = jsonContainer.objectForKey("Coach") as! NSArray
        resetTeam()
    }
    
    func resetTeam(){
        for index in 1...11{
            let playerArray = NSDictionary()
            team[index] = playerArray
        }
        addCoachToPosition("-", position: 1) //adding default coach
        coach2 = NSDictionary()
        coach3 = NSDictionary()
    }
    
    private func getJsonData(FileName:String) ->NSDictionary{
        var _: NSError?
        let path = NSBundle.mainBundle().pathForResource(FileName, ofType: "json")
        let _ = NSURL(string: path!)
        let data: NSData? = NSData(contentsOfFile: path!)
        let jsonDict = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
        return jsonDict
    }
    
    func getAllPlayersForPosition(position:Int)-> NSArray{
        let playersinrole = NSMutableArray()
        for player in players{
            let playerPositions = (player.objectForKey("Positions") as! NSArray)
            
            for playerPosition in playerPositions {
                if ((playerPosition.objectForKey("Position") as! Int) == position){
                    playersinrole.addObject(player)
                }
            }
        }
        
        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "ShirtNumber", ascending: true)
        let sortedResults: NSArray = playersinrole.sortedArrayUsingDescriptors([descriptor])

        
        return sortedResults
    }
    
    func addCoachToPosition(CoachName:String, position:Int) -> Bool{
        for coach in coaches {
            let coachname = (coach as! NSDictionary).objectForKey("Name") as! NSString
            if coachname.isEqualToString(CoachName) {
                if (coach1.count != 0 && (coach1.objectForKey("Name") as! NSString).isEqualToString(CoachName)){
                    coach1 = NSDictionary()
                }
                
                if (coach2.count != 0 && (coach2.objectForKey("Name") as! NSString).isEqualToString(CoachName)){
                    coach2 = NSDictionary()
                }
                
                if (coach3.count != 0 && (coach3.objectForKey("Name") as! NSString).isEqualToString(CoachName)){
                    coach3 = NSDictionary()
                }
                
                if (position == 1){
                    coach1 = coach as! NSDictionary
                    return true
                }else if (position == 2){
                    coach2 = coach as! NSDictionary
                    return true
                }else if (position == 3){
                    coach3 = coach as! NSDictionary
                    return true
                }
            }
        }
        return false
    }
    
    func removePlayerFromPosition(positionIndex: Int) {
        team[positionIndex] = NSDictionary()
    }
    
    func removeCoachFromPosition(positionIndex: Int) {
        if (positionIndex == 1){
            coach1 = NSDictionary()
        }else if (positionIndex == 2){
            coach2 = NSDictionary()
        }else if (positionIndex == 3){
            coach3 = NSDictionary()
        }
    }
    
    func addPlayerToTeam(shirtnumber: NSNumber, playerName: String, position:Int) ->Bool {
        for player in players {
            let cplayerName = (player as! NSDictionary).objectForKey("Name") as! NSString
            let cplayerShirtNumber = (player as! NSDictionary).objectForKey("ShirtNumber") as! Int
            
            if cplayerShirtNumber == shirtnumber {
                
                if (cplayerName.isEqualToString(playerName) || playerName == "" ){
                
                    let playerPositions = (player.objectForKey("Positions") as! NSArray)
                
                    for playerPosition in playerPositions {
                        if ((playerPosition.objectForKey("Position") as! Int) == position){
                            for index in 1...11 {
                                let teamPlayer = team[index]
                                if (teamPlayer == nil || teamPlayer?.count == 0)
                                {
                                    continue
                                }
                                let teamName = (teamPlayer as! NSDictionary).objectForKey("Name") as! NSString
                                let teamShirtNumber = (teamPlayer as! NSDictionary).objectForKey("ShirtNumber") as! Int
                                if (teamName.isEqualToString(cplayerName as String) && teamShirtNumber == cplayerShirtNumber ) {
                                    team[index] = NSDictionary()
                                }
                            }
                            
                            team[position] = player
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    func getLinkModifierForPosition(positionIndex: Int) ->Int{
        
        var color = NSString()
        var position = NSString()
        
        switch positionIndex{
        case 1:
            return 0
        case 2:
            color = "Orange"
            position = "LeftCon"
        case 3:
            color = "Orange"
            position = "DownCon"
        case 4:
            color = "Orange"
            position = "DownCon"
        case 5:
            color = "Orange"
            position = "RightCon"
        case 6:
            return 0
        case 7:
            return 0
        case 8:
            return 0
        case 9:
            return 0
        case 10:
            color = "Red"
            position = "TopCon"
        case 11:
            color = "Red"
            position = "TopCon"
        default:
            return 0
        }
        var res = 0
        let player = team.objectForKey(positionIndex) as! NSDictionary
        if ( player.count == 0 ){
            return res
        }
        if ((player.objectForKey(position) as! NSString).isEqualToString(color as String)){
            res = 2
        }
        return res
    }
    
    func getModifierForPosition(positionIndex: Int) ->NSString{
        switch positionIndex{
        case 1:
            return "OrangeDown"
        case 2:
            if ( isPlayerAttackModule(positionIndex)){
                return "BlueLeft"
            }
            return "OrangeLeft"
        case 3:
            if ( isPlayerAttackModule(positionIndex)){
                return "YellowTop"
            }
            return "OrangeDown"
        case 4:
            if ( isPlayerAttackModule(positionIndex)){
                return "YellowTop"
            }
            return "OrangeDown"
        case 5:
            if ( isPlayerAttackModule(positionIndex)){
                return "BlueRight"
            }
            return "OrangeRight"
        case 6:
            if ( isPlayerAttackModule(positionIndex)){
                return "BlueLeft"
            }
            return "OrangeLeft"
        case 7:
            if ( isPlayerAttackModule(positionIndex)){
                return "YellowTop"
            }
            return "OrangeDown"
        case 8:
            if ( isPlayerAttackModule(positionIndex)){
                return "YellowTop"
            }
            return "OrangeDown"
        case 9:
            if ( isPlayerAttackModule(positionIndex)){
                return "BlueRight"
            }
            return "OrangeRight"
        case 10:
            return "RedTop"
        case 11:
            return "RedTop"
        default:
            return ""
        }
    }
    
    func getLeftConnection(positionIndex: Int) -> Int{
        var res = 0
        let player = team.objectForKey(positionIndex) as! NSDictionary
        if ( player.count == 0 || positionIndex == 2 || positionIndex == 6){
            return res
        }
        var nextPosition = positionIndex - 1
        var modifier = 0
        var addExtraConnection = false
        if (positionIndex == 9){
            addExtraConnection = true
        }else if (positionIndex == 10){
            nextPosition = 6
            modifier = 2
        }
        var nextplayer = team.objectForKey(nextPosition) as! NSDictionary
        if ( nextplayer.count > 0){
            let connString = player.objectForKey("LeftCon") as! NSString
            if ( connString.isEqualToString("")){
                return 0
            }
            let otherString = nextplayer.objectForKey("RightCon") as! NSString
            if (connString.isEqualToString(otherString as String)){
                if (!connString.isEqualToString("Blue")){
                    modifier = 0
                }
                res = 1 + modifier
            }
        }
        if (addExtraConnection) {
            nextplayer = team.objectForKey(11) as! NSDictionary
            if ( nextplayer.count > 0){
                let connString = player.objectForKey("LeftCon") as! NSString
                let otherString = nextplayer.objectForKey("RightCon") as! NSString
                if (connString.isEqualToString(otherString as String)){
                    if ( connString.isEqualToString("Blue") ){
                        res += 3
                    }else{
                        res += 1
                    }
                }
            }
        }
        return res
    }
    
    func getRightConnection(positionIndex: Int) -> Int{
        
        var res = 0
        let player = team.objectForKey(positionIndex) as! NSDictionary
        if ( player.count == 0 || positionIndex == 5 || positionIndex == 9){
            return res
        }
        var nextPosition = positionIndex + 1
        var modifier = 0
        var addExtraConnection = false
        if (positionIndex == 6){
            addExtraConnection = true
        }else if (positionIndex == 11){
            nextPosition = 9
            modifier = 2
        }
        var nextplayer = team.objectForKey(nextPosition) as! NSDictionary
        if ( nextplayer.count > 0){
            let connString = player.objectForKey("RightCon") as! NSString
            if ( connString.isEqualToString("")){
                return 0
            }
            let otherString = nextplayer.objectForKey("LeftCon") as! NSString
            if (connString.isEqualToString(otherString as String)){
                if (!connString.isEqualToString("Blue")){
                    modifier = 0
                }

                res = 1 + modifier
            }
        }
        if (addExtraConnection) {
            nextplayer = team.objectForKey(10) as! NSDictionary
            if ( nextplayer.count > 0){
                let connString = player.objectForKey("RightCon") as! NSString
                let otherString = nextplayer.objectForKey("LeftCon") as! NSString
                if (connString.isEqualToString(otherString as String)){
                    if ( connString.isEqualToString("Blue") ){
                        res += 3
                    }else{
                        res += 1
                    }
                }
            }
        }
        return res
    }
    
    func getDownConnection(positionIndex: Int) -> Int{
        var res = 0
        let player = team.objectForKey(positionIndex) as! NSDictionary
        if ( player.count == 0 || positionIndex < 6){
            return res
        }
        var nextPosition = 0
        var modifier = 2
        
        if ( positionIndex < 10 ){
            nextPosition = positionIndex - 4
        } else {
            nextPosition = positionIndex - 3
        }
        
        let connString = player.objectForKey("DownCon") as! NSString
        if ( connString.isEqualToString("")){
            return 0
        }
        
        if ( positionIndex == 7 || positionIndex == 8 ){
            modifier = 0
        }
        let nextplayer = team.objectForKey(nextPosition) as! NSDictionary
        if ( nextplayer.count > 0){
            
            let otherString = nextplayer.objectForKey("TopCon") as! NSString
            if (connString.isEqualToString(otherString as String)){
                if (!connString.isEqualToString("Yellow")){
                    modifier = 0
                }
                res = 1 + modifier
            }
        }
        return res
    }
    
    
    func getTopConnection(positionIndex: Int) -> Int{
        var res = 0
        let player = team.objectForKey(positionIndex) as! NSDictionary
        if ( player.count == 0 || positionIndex > 9 || positionIndex == 6 || positionIndex == 9){
            return res
        }
        var nextPosition = 0
        var modifier = 2
        
        if ( positionIndex < 6 ){
            nextPosition = positionIndex + 4
        } else {
            nextPosition = positionIndex + 3
        }
        
        let connString = player.objectForKey("TopCon") as! NSString
        if ( connString.isEqualToString("")){
            return 0
        }
        
        if ( positionIndex == 3 || positionIndex == 4 ){
            modifier = 0
        }
        
        let nextplayer = team.objectForKey(nextPosition) as! NSDictionary
        if ( nextplayer.count > 0){
            
            let otherString = nextplayer.objectForKey("DownCon") as! NSString
            if (connString.isEqualToString(otherString as String)){
                if (!connString.isEqualToString("Yellow")){
                    modifier = 0
                }
                res = 1 + modifier
            }
        }
        return res
    }
    
    func getConnectionMultiplier(positionIndex: Int) ->Int{
        if (positionIndex == 1){
            return 0
        }
        var res = 0
        res += getLeftConnection(positionIndex)
        res += getRightConnection(positionIndex)
        res += getTopConnection(positionIndex)
        res += getDownConnection(positionIndex)
        
        return res
    }
    
    func getCoachModifier(coachPosition: Int, playerPosition: Int) -> Int{
        
        var coach = NSDictionary()
        
        if (coachPosition == 1 ){
            coach = coach1
        } else if (coachPosition == 2){
            coach = coach2
        } else if (coachPosition == 3){
            coach = coach3
        }
        
        let teamplayer = team.objectForKey(playerPosition) as! NSDictionary
        if(teamplayer.count == 0 || coach.count == 0) {
            return 0
        }
        
        var res = 0
        
        let tCon = teamplayer.objectForKey("TopCon") as! NSString
        let lCon = teamplayer.objectForKey("LeftCon") as! NSString
        let rCon = teamplayer.objectForKey("RightCon") as! NSString
        let dCon = teamplayer.objectForKey("DownCon") as! NSString
        let con = [tCon,lCon,rCon,dCon]
        
        for connection in con {
            if (!(connection.isEqualToString(""))){
                res += coach.objectForKey(connection) as! Int
            }
        }
        
        return res
    }
    
    func calculatePlayer(playerPosition: Int) ->Int{
        var result = 0
        let teamplayer = team.objectForKey(playerPosition) as! NSDictionary
        
        if(teamplayer.count == 0) {
            return -2
        }
        let res = teamplayer.objectForKey(getModifierForPosition(playerPosition)) as! Int
        result += res
        
        let conn = getConnectionMultiplier(playerPosition)
        result += conn
        
        var coachmodifier = 0
        
        for index in 1...3{
            coachmodifier += getCoachModifier(index, playerPosition: playerPosition)
        }
        
        result += coachmodifier
        
        var linkmodifier = 0
        linkmodifier = getLinkModifierForPosition(playerPosition)
        result += linkmodifier
        
        return result
    }
    
    func calculateCounter()->Int{
        var counter = 0
        for index in 1...11{
            let player = team[index] as! NSDictionary
            if (player.count > 0 ){
                counter += player.objectForKey("HumanCost") as! Int
            }
        }
        if (coach1.count > 0){
            counter += coach1.objectForKey("HumanCost") as! Int
        }
        if (coach2.count > 0){
            counter += coach2.objectForKey("HumanCost") as! Int
        }
        if (coach3.count > 0){
            counter += coach3.objectForKey("HumanCost") as! Int
        }
        
        return counter
    }
    
    func calculateModule(module: NSString) ->Int{
        var result = 0
        if (coach1.count == 0){
            addCoachToPosition("-", position: 1)
        }
        
        let attackModule = coach1.objectForKey(module) as! NSArray
        
        for player in  attackModule {
            let playernumber = player.objectForKey("Player") as! Int
            result += calculatePlayer(playernumber)
        }
        
        return result
    }
    
    func calculateAttack() -> Int{
        return calculateModule("AttackModule")
    }
    
    func calculateDefense() -> Int{
        return calculateModule("DefenseModule")
    }
    
    func getCoachFromPosition(position: Int) -> NSDictionary{
        if position == 1 {
            return coach1
        } else if position == 2 {
            return coach2
        } else if position == 3 {
            return coach3
        }
        return NSDictionary()
    }
    
    func isPlayerAttackModule(playerPosition:Int) ->Bool {
     
        let attackModule = coach1.objectForKey("AttackModule") as! NSArray
        
        for player in  attackModule {
            let playernumber = player.objectForKey("Player") as! Int
            if (playernumber == playerPosition){
                return true
            }
        }
        return false
    }
    

}
