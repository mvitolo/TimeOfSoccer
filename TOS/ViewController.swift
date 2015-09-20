//
//  ViewController.swift
//  TOS
//
//  Created by Matteo Vitolo on 28/07/15.
//  Copyright (c) 2015 Funambol. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPopoverPresentationControllerDelegate {

    var team : NSDictionary!
    
    @IBOutlet weak var p1Button: UIButton!
    @IBOutlet weak var p2Button: UIButton!
    @IBOutlet weak var p3Button: UIButton!
    @IBOutlet weak var p4Button: UIButton!
    @IBOutlet weak var p5Button: UIButton!
    @IBOutlet weak var p6Button: UIButton!
    @IBOutlet weak var p7Button: UIButton!
    @IBOutlet weak var p8Button: UIButton!
    @IBOutlet weak var p9Button: UIButton!
    @IBOutlet weak var p10Button: UIButton!
    @IBOutlet weak var p11Button: UIButton!
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var defenceLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    
    @IBOutlet weak var coach1Button: UIButton!
    @IBOutlet weak var coach2Button: UIButton!
    @IBOutlet weak var coach3Button: UIButton!
    
    var playersButtons : NSMutableArray!
    var coachesButtons : NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        playersButtons =  [p1Button, p2Button,p3Button,p4Button,p5Button,p6Button,p7Button,p8Button,p9Button,p10Button,p11Button]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reassignTiles(){
        team = (TOSCalculator.sharedInstance.team) as NSDictionary
        for index in 1...11{
            let player = team.objectForKey(index) as! NSDictionary
            
            let image = player.objectForKey("image")
            if (image != nil){
                let buttonIndex = index - 1
                (playersButtons[buttonIndex] as! UIButton).setBackgroundImage(UIImage(named: image as! String), forState: UIControlState.Normal)
            }else{
                let buttonIndex = index - 1
                (playersButtons[buttonIndex] as! UIButton).setBackgroundImage(nil, forState: UIControlState.Normal)
            }
        }
        if (TOSCalculator.sharedInstance.coach1.count > 0){
            let coach = TOSCalculator.sharedInstance.coach1
            let image = coach.objectForKey("image")
            if (image != nil){
                coach1Button.setBackgroundImage(UIImage(named: image as! String), forState: UIControlState.Normal)
            }else{
                coach1Button.setBackgroundImage(UIImage(named: "ent_1.png"), forState: UIControlState.Normal)
            }
        }else {
            coach1Button.setBackgroundImage(UIImage(named: "ent_1.png"), forState: UIControlState.Normal)
        }
        
        if (TOSCalculator.sharedInstance.coach2.count > 0){
            let coach = TOSCalculator.sharedInstance.coach2
            let image = coach.objectForKey("image")
            if (image != nil){
                coach2Button.setBackgroundImage(UIImage(named: image as! String), forState: UIControlState.Normal)
            }else{
                coach2Button.setBackgroundImage(UIImage(named: "ent_1.png"), forState: UIControlState.Normal)
            }
        }else {
            coach2Button.setBackgroundImage(UIImage(named: "ent_1.png"), forState: UIControlState.Normal)
        }
        
        if (TOSCalculator.sharedInstance.coach3.count > 0){
            let coach = TOSCalculator.sharedInstance.coach1
            let image = coach.objectForKey("image")
            if (image != nil){
                coach3Button.setBackgroundImage(UIImage(named: image as! String), forState: UIControlState.Normal)
            }else{
                coach3Button.setBackgroundImage(UIImage(named: "ent_1.png"), forState: UIControlState.Normal)
            }
        }else {
            coach3Button.setBackgroundImage(UIImage(named: "ent_1.png"), forState: UIControlState.Normal)
        }
        
        
        defenceLabel.text = NSString(format: "%d", TOSCalculator.sharedInstance.calculateDefense()) as String
        attackLabel.text = NSString(format: "%d", TOSCalculator.sharedInstance.calculateAttack()) as String
        
    }

    @IBAction func p1Action(sender: AnyObject) {
        playerAction(sender, position: 1)
    }
    @IBAction func p2Action(sender: AnyObject) {
        playerAction(sender, position: 2)
    }
    @IBAction func p3Action(sender: AnyObject) {
        playerAction(sender, position: 3)
    }
    @IBAction func p4Action(sender: AnyObject) {
        playerAction(sender, position: 4)
    }
    @IBAction func p5Action(sender: AnyObject) {
        playerAction(sender, position: 5)
    }
    @IBAction func p6Action(sender: AnyObject) {
        playerAction(sender, position: 6)
    }
    @IBAction func p7Action(sender: AnyObject) {
        playerAction(sender, position: 7)
    }
    @IBAction func p8Action(sender: AnyObject) {
        playerAction(sender, position: 8)
    }
    @IBAction func p9Action(sender: AnyObject) {
        playerAction(sender, position: 9)
    }
    @IBAction func p10Action(sender: AnyObject) {
        playerAction(sender, position: 10)
    }
    @IBAction func p11Action(sender: AnyObject) {
        playerAction(sender, position: 11)
    }
    
    @IBAction func coach1Action(sender: AnyObject) {
        coachAction(sender, position: 1)
    }
    @IBAction func coach2Action(sender: AnyObject) {
        coachAction(sender, position: 2)
    }
    @IBAction func coach3Action(sender: AnyObject) {
        coachAction(sender, position: 3)
    }
    
    func coachAction (sender: AnyObject, position: Int){
        popoverAction(sender, position: position, role: TeamRole.Coach)
    }
    
    func playerAction (sender: AnyObject, position: Int){
        popoverAction(sender, position: position, role: TeamRole.Player)
    }
    
    func popoverAction (sender: AnyObject, position: Int, role: TeamRole){
        let playerInformationViewController =  PlayerPickerViewController()
        playerInformationViewController.position = position
        playerInformationViewController.role = role
        playerInformationViewController.modalPresentationStyle = .Popover
        playerInformationViewController.preferredContentSize = CGSizeMake(300, 300)
        playerInformationViewController.caller = self
        
        let popoverPresentationViewController =  playerInformationViewController.popoverPresentationController
        popoverPresentationViewController?.permittedArrowDirections = .Any
        popoverPresentationViewController?.delegate = self
        popoverPresentationViewController?.sourceRect = CGRectMake(50, 50, 0, 0)
        //popoverPresentationController?.barButtonItem = sender
        popoverPresentationViewController?.sourceView = sender as? UIView
        presentViewController(playerInformationViewController, animated: true, completion: nil)
    }

}

