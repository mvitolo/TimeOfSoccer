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
        XCTAssert( (resultAttack == -18) , "Attack for empty Team")
        XCTAssert( (resultDefense == -15) , "Defense for empty Team")
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
    
    func testAddAttack(){
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
    }
    
    func testHorizontalConnection(){
        
    }
    
    func testVerticalConnection(){
        TOSCalculator.sharedInstance.addPlayerToTeam(4, position: 2)
        TOSCalculator.sharedInstance.addPlayerToTeam(3, position: 6)
        let result = TOSCalculator.sharedInstance.calculatePlayer(2)
        XCTAssert( (result == 5) , String(format:"%s",__FUNCTION__))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
}
