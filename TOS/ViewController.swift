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
    
    var playersButtons : NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        playersButtons =  [p1Button, p2Button,p3Button,p4Button,p5Button,p6Button,p7Button,p8Button,p9Button,p10Button,p11Button]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reassignTiles(){
        team = (TOSCalculator.sharedInstance.team) as NSDictionary
        for index in 1...11{
            let image = (team[index] as! NSDictionary).objectForKey("image") as! NSString
            (playersButtons[index] as! UIButton).setBackgroundImage(UIImage(named: image as String), forState: UIControlState.Normal)
        }
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
    
    func playerAction (sender: AnyObject, position: Int){
        let playerInformationViewController =  PlayerPickerViewController()
        playerInformationViewController.position = position
        playerInformationViewController.modalPresentationStyle = .Popover
        playerInformationViewController.preferredContentSize = CGSizeMake(300, 300)
        
        let popoverPresentationViewController = playerInformationViewController.popoverPresentationController
        popoverPresentationViewController?.permittedArrowDirections = .Any
        popoverPresentationViewController?.delegate = self
        popoverPresentationViewController?.sourceRect = CGRectMake(50, 50, 0, 0)
        //popoverPresentationController?.barButtonItem = sender
        popoverPresentationViewController?.sourceView = sender as? UIView
        presentViewController(playerInformationViewController, animated: true, completion: nil)
    }

}

