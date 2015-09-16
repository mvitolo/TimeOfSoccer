//
//  TOSCalculatorTests.swift
//  TOS
//
//  Created by Matteo Vitolo on 31/07/15.
//  Copyright (c) 2015 Funambol. All rights reserved.
//

import Foundation
import TOS

import UIKit
import XCTest

class TOSCalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TOSCalculator.sharedInstance.resetTeam()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyTeam() {
        // This is a test for the starting team with the amateur players who are crap!
        let resultAttack = TOSCalculator.sharedInstance.calculateAttack()
        let resultDefense = TOSCalculator.sharedInstance.calculateDefense()
        XCTAssert( (resultAttack == -12) , "Attack for empty Team")
        XCTAssert( (resultDefense == -10) , "Defense for empty Team")
    }
    
    func testAddGoalkeeperToWrongPosition(){
        //We know that the goalkeeper has number 91
        //Let's add it as midfielder position 7
        let result = TOSCalculator.sharedInstance.addPlayerToTeam(91, playerName: "", position: 7) as Bool
        XCTAssertFalse(result, String(format:"%s",__FUNCTION__))
    }
    
    func testAddGoalkeeperToRightPosition(){
        //We know that the goalkeeper has number 91
        //Let's add it as 1 Position
        let result = TOSCalculator.sharedInstance.addPlayerToTeam(91, playerName: "",position: 1) as Bool
        XCTAssert(result, String(format:"%s",__FUNCTION__))
    }
    
    func testAddMultipositionPlayerToTheWrongPosition(){
        //Let's Add 92 position 2-4 to position 7
        let result = TOSCalculator.sharedInstance.addPlayerToTeam(92, playerName: "",position: 7) as Bool
        XCTAssertFalse(result, String(format:"%s",__FUNCTION__))
    }
    
    func testAddMultipositionPlayerToTheRightPosition(){
        //Let's Add 92 position 2-4 to position 2
        let result = TOSCalculator.sharedInstance.addPlayerToTeam(92, playerName: "",position: 4) as Bool
        XCTAssert(result, String(format:"%s",__FUNCTION__))
    }
    
 /*   func testAddAttack(){
        TOSCalculator.sharedInstance.addPlayerToTeam(94, position: 6)
        TOSCalculator.sharedInstance.addPlayerToTeam(95, position: 7)
        TOSCalculator.sharedInstance.addPlayerToTeam(96, position: 11)

        let resultAttack = TOSCalculator.sharedInstance.calculateAttack()
        XCTAssert( (resultAttack == -6) , String(format:"%s",__FUNCTION__))
    }
    
    func testAddDefence(){
        TOSCalculator.sharedInstance.addPlayerToTeam(91, position: 1)
        TOSCalculator.sharedInstance.addPlayerToTeam(92, position: 2)
        TOSCalculator.sharedInstance.addPlayerToTeam(93, position: 3)
        
        let resultDefense = TOSCalculator.sharedInstance.calculateDefense()
        XCTAssert( (resultDefense == -4) , String(format:"%s",__FUNCTION__))
    }*/
    
    func testHorizontalConnection(){
        
    }
    
    func testVerticalConnection(){
   /*     TOSCalculator.sharedInstance.addPlayerToTeam(94, position: 2)
        TOSCalculator.sharedInstance.addPlayerToTeam(93, position: 6)
        let result = TOSCalculator.sharedInstance.calculatePlayer(2)
        XCTAssert( (result == 5) , String(format:"%s",__FUNCTION__))*/
    }
    
    
    
    func testemptyTeam(){
        let resultDefense = TOSCalculator.sharedInstance.calculateDefense()
        XCTAssert( (resultDefense == -10) , String(format:"%s",__FUNCTION__))
        
        let resultAttack = TOSCalculator.sharedInstance.calculateAttack()
        XCTAssert( (resultAttack == -12) , String(format:"%s",__FUNCTION__))
    }
    
    func testFullTeam(){
        TOSCalculator.sharedInstance.addPlayerToTeam(35, playerName: "CEVASCO",  position: 1)
        TOSCalculator.sharedInstance.addPlayerToTeam(14, playerName: "LIPSCHITZZ",position: 2)
        TOSCalculator.sharedInstance.addPlayerToTeam(45, playerName: "AKUMO",position: 3)
        TOSCalculator.sharedInstance.addPlayerToTeam(16, playerName: "KSUCO",position: 4)
        TOSCalculator.sharedInstance.addPlayerToTeam(20, playerName: "FUCH",position: 5)
        TOSCalculator.sharedInstance.addPlayerToTeam(94, playerName: "",position: 6)
        TOSCalculator.sharedInstance.addPlayerToTeam(11, playerName: "ALPINO",position: 7)
        TOSCalculator.sharedInstance.addPlayerToTeam(23, playerName: "ROCINANTE",position: 8)
        TOSCalculator.sharedInstance.addPlayerToTeam(21, playerName: "OLADOLA",position: 9)
        TOSCalculator.sharedInstance.addPlayerToTeam(85, playerName: "TONE",position: 10)
        TOSCalculator.sharedInstance.addPlayerToTeam(47, playerName: "CÁRDENAS",position: 11)
        TOSCalculator.sharedInstance.addCoachToPosition("BUHONERO", position: 2)
        TOSCalculator.sharedInstance.addCoachToPosition("EXIMENO", position: 3)

        //def
        var resPlayer = TOSCalculator.sharedInstance.calculatePlayer(1)
        XCTAssert( (resPlayer == 6) , String(format:"%s",__FUNCTION__))
        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(2)
        XCTAssert( (resPlayer == 14) , String(format:"%s",__FUNCTION__))
        
        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(3)
        XCTAssert( (resPlayer == 5) , String(format:"%s",__FUNCTION__))

        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(4)
        XCTAssert( (resPlayer == 10) , String(format:"%s",__FUNCTION__))
        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(5)
        XCTAssert( (resPlayer == 4) , String(format:"%s",__FUNCTION__))
        
        //att
        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(6)
        XCTAssert( (resPlayer == 1) , String(format:"%s",__FUNCTION__))
        
        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(7)
        XCTAssert( (resPlayer == 21) , String(format:"%s",__FUNCTION__))
        
        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(8)
        XCTAssert( (resPlayer == 13) , String(format:"%s",__FUNCTION__))
        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(9)
        XCTAssert( (resPlayer == 12) , String(format:"%s",__FUNCTION__))
        
        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(10)
        XCTAssert( (resPlayer == 6) , String(format:"%s",__FUNCTION__))
        
        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(11)
        XCTAssert( (resPlayer == 11) , String(format:"%s",__FUNCTION__))
        
        let resultDefense = TOSCalculator.sharedInstance.calculateDefense()
        XCTAssert( (resultDefense == 39) , String(format:"%s",__FUNCTION__))
        
        let resultAttack = TOSCalculator.sharedInstance.calculateAttack()
        XCTAssert( (resultAttack == 64) , String(format:"%s",__FUNCTION__))

        
    }
    
    func testManualExample(){//this test is simulating the example present in the game manual
        TOSCalculator.sharedInstance.addPlayerToTeam(3, playerName: "", position: 2)
        TOSCalculator.sharedInstance.addPlayerToTeam(14, playerName: "", position: 3)
        TOSCalculator.sharedInstance.addPlayerToTeam(97, playerName: "", position: 4)
        TOSCalculator.sharedInstance.addPlayerToTeam(20, playerName: "", position: 5)
        TOSCalculator.sharedInstance.addPlayerToTeam(41, playerName: "", position: 6)
        TOSCalculator.sharedInstance.addPlayerToTeam(18, playerName: "", position: 8)
        TOSCalculator.sharedInstance.addPlayerToTeam(28, playerName: "", position: 9)
        TOSCalculator.sharedInstance.addPlayerToTeam(10, playerName: "", position: 10)
        TOSCalculator.sharedInstance.addPlayerToTeam(9, playerName: "", position: 11)
        TOSCalculator.sharedInstance.addCoachToPosition("PICAPICARA", position: 1)
        TOSCalculator.sharedInstance.addCoachToPosition("ANGEL MARTINEZ", position: 3)

        
        var resPlayer = TOSCalculator.sharedInstance.calculatePlayer(2)
        XCTAssert( (resPlayer == 5) , String(format:"%s",__FUNCTION__))
        
        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(3)
        XCTAssert( (resPlayer == 18) , String(format:"%s",__FUNCTION__))

        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(4)
        XCTAssert( (resPlayer == 1) , String(format:"%s",__FUNCTION__))

        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(5)
        XCTAssert( (resPlayer == 6) , String(format:"%s",__FUNCTION__))

        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(6)
        XCTAssert( (resPlayer == 10) , String(format:"%s",__FUNCTION__))
        
        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(8)
        XCTAssert( (resPlayer == 5) , String(format:"%s",__FUNCTION__))

        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(9)
        XCTAssert( (resPlayer == 7) , String(format:"%s",__FUNCTION__))

        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(10)
        XCTAssert( (resPlayer == 10) , String(format:"%s",__FUNCTION__))

        resPlayer = TOSCalculator.sharedInstance.calculatePlayer(11)
        XCTAssert( (resPlayer == 16) , String(format:"%s",__FUNCTION__))
        
     //
        let resultDefense = TOSCalculator.sharedInstance.calculateDefense()
        XCTAssert( (resultDefense == 35) , String(format:"%s",__FUNCTION__))
        
        let resultAttack = TOSCalculator.sharedInstance.calculateAttack()
        XCTAssert( (resultAttack == 39) , String(format:"%s",__FUNCTION__))
    }
    
    func testGetAllPlayersForPosition(){
        var players = TOSCalculator.sharedInstance.getAllPlayersForPosition(4)
        XCTAssert( (players.count == 19) , String(format:"%s",__FUNCTION__))
        
        players = TOSCalculator.sharedInstance.getAllPlayersForPosition(5)
        XCTAssert( (players.count == 10) , String(format:"%s",__FUNCTION__))

        
        players = TOSCalculator.sharedInstance.getAllPlayersForPosition(9)
        XCTAssert( (players.count == 16) , String(format:"%s",__FUNCTION__))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
}
