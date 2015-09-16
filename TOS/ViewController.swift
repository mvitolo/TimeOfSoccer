//
//  ViewController.swift
//  TOS
//
//  Created by Matteo Vitolo on 28/07/15.
//  Copyright (c) 2015 Funambol. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let playerInformationViewController =  UITableViewController()
        playerInformationViewController.modalPresentationStyle = .Popover
        playerInformationViewController.preferredContentSize = CGSizeMake(300, 300)
        
        
        
        let popoverPresentationViewController = playerInformationViewController.popoverPresentationController
        popoverPresentationViewController?.permittedArrowDirections = .Any
        popoverPresentationViewController?.delegate = self
        //popoverPresentationController?.barButtonItem = sender
        popoverPresentationViewController?.sourceView = sender as! UIView
        presentViewController(playerInformationViewController, animated: true, completion: nil)
        
    
    }

}

