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
        let result = TOSCalculator.sharedInstance.addPlayerToTeam(91, position: 7) as Bool
        XCTAssertFalse(result, String(format:"%s",__FUNCTION__))
    }
    
    func testAddGoalkeeperToRightPosition(){
        //We know that the goalkeeper has number 91
        //Let's add it as 1 Position
        let result = TOSCalculator.sharedInstance.addPlayerToTeam(91, position: 1) as Bool
        XCTAssert(result, String(format:"%s",__FUNCTION__))
    }
    
    func testAddMultipositionPlayerToTheWrongPosition(){
        //Let's Add 92 position 2-4 to position 7
        let result = TOSCalculator.sharedInstance.addPlayerToTeam(92, position: 7) as Bool
        XCTAssertFalse(result, String(format:"%s",__FUNCTION__))
    }
    
    func testAddMultipositionPlayerToTheRightPosition(){
        //Let's Add 92 position 2-4 to position 2
        let result = TOSCalculator.sharedInstance.addPlayerToTeam(92, position: 4) as Bool
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
    
    func testManualExample(){//this test is simulating the example present in the game manual
        TOSCalculator.sharedInstance.addPlayerToTeam(3, position: 2)
        TOSCalculator.sharedInstance.addPlayerToTeam(14, position: 3)
        TOSCalculator.sharedInstance.addPlayerToTeam(97, position: 4)
        TOSCalculator.sharedInstance.addPlayerToTeam(20, position: 5)
        TOSCalculator.sharedInstance.addPlayerToTeam(41, position: 6)
        TOSCalculator.sharedInstance.addPlayerToTeam(18, position: 8)
        TOSCalculator.sharedInstance.addPlayerToTeam(28, position: 9)
        TOSCalculator.sharedInstance.addPlayerToTeam(10, position: 10)
        TOSCalculator.sharedInstance.addPlayerToTeam(9, position: 11)
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
}
