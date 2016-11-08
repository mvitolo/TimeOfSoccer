//
//  ViewController.swift
//  TOS
//
//  Created by Matteo Vitolo on 28/07/15.
//  Copyright (c) 2015 Matteo Vitolo. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController,UIPopoverPresentationControllerDelegate,ADBannerViewDelegate, ADInterstitialAdDelegate, TilesDelegate {

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
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    
    @IBOutlet weak var coach1Button: UIButton!
    @IBOutlet weak var coach2Button: UIButton!
    @IBOutlet weak var coach3Button: UIButton!
    
    @IBOutlet weak var adBanner: ADBannerView!
    var playersButtons : NSMutableArray!
    var coachesButtons : NSMutableArray!
    
    //var fullviewad : ADInterstitialAd!
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        playersButtons =  [p1Button, p2Button,p3Button,p4Button,p5Button,p6Button,p7Button,p8Button,p9Button,p10Button,p11Button]
        reassignTiles()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fullviewad = ADInterstitialAd()
        //fullviewad.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reassignTiles(){
        
        team = (TOSCalculator.sharedInstance.team) as NSDictionary
        for index in 1...11{
            let player = team.object(forKey: index) as! NSDictionary
            
            let image = player.object(forKey: "image")
            if (image != nil){
                let buttonIndex = index - 1
                (playersButtons[buttonIndex] as! UIButton).setBackgroundImage(UIImage(named: image as! String), for: UIControlState())
            }else{
                let buttonIndex = index - 1
                (playersButtons[buttonIndex] as! UIButton).setBackgroundImage(nil, for: UIControlState())
            }
        }
        if (TOSCalculator.sharedInstance.coach1.count > 0){
            let coach = TOSCalculator.sharedInstance.coach1
            let image = coach.object(forKey: "image")
            if (image != nil){
                coach1Button.setBackgroundImage(UIImage(named: image as! String), for: UIControlState())
            }else{
                coach1Button.setBackgroundImage(UIImage(named: "ent_1.png"), for: UIControlState())
            }
        }else {
            coach1Button.setBackgroundImage(UIImage(named: "ent_1.png"), for: UIControlState())
        }
        
        if (TOSCalculator.sharedInstance.coach2.count > 0){
            let coach = TOSCalculator.sharedInstance.coach2
            let image = coach.object(forKey: "image")
            if (image != nil){
                coach2Button.setBackgroundImage(UIImage(named: image as! String), for: UIControlState())
            }else{
                coach2Button.setBackgroundImage(UIImage(named: "ent_0.png"), for: UIControlState())
            }
        }else {
            coach2Button.setBackgroundImage(UIImage(named: "ent_0.png"), for: UIControlState())
        }
        
        if (TOSCalculator.sharedInstance.coach3.count > 0){
            let coach = TOSCalculator.sharedInstance.coach3
            let image = coach.object(forKey: "image")
            if (image != nil){
                coach3Button.setBackgroundImage(UIImage(named: image as! String), for: UIControlState())
            }else{
                coach3Button.setBackgroundImage(UIImage(named: "ent_0.png"), for: UIControlState())
            }
        }else {
            coach3Button.setBackgroundImage(UIImage(named: "ent_0.png"), for: UIControlState())
        }
        
        
        defenseLabel.text = String(format: "%d", TOSCalculator.sharedInstance.calculateDefense())
        attackLabel.text = String(format: "%d", TOSCalculator.sharedInstance.calculateAttack())
        counterLabel.text = String(format: "%d", TOSCalculator.sharedInstance.calculateCounter())
        
        /*if counter == 10 {
            counter = 0
            fullviewad.presentInView(self.view)
        }else{
            counter++
        }*/
        
    }

    @IBAction func p1Action(_ sender: AnyObject) {
        playerAction(sender, position: 1)
    }
    @IBAction func p2Action(_ sender: AnyObject) {
        playerAction(sender, position: 2)
    }
    @IBAction func p3Action(_ sender: AnyObject) {
        playerAction(sender, position: 3)
    }
    @IBAction func p4Action(_ sender: AnyObject) {
        playerAction(sender, position: 4)
    }
    @IBAction func p5Action(_ sender: AnyObject) {
        playerAction(sender, position: 5)
    }
    @IBAction func p6Action(_ sender: AnyObject) {
        playerAction(sender, position: 6)
    }
    @IBAction func p7Action(_ sender: AnyObject) {
        playerAction(sender, position: 7)
    }
    @IBAction func p8Action(_ sender: AnyObject) {
        playerAction(sender, position: 8)
    }
    @IBAction func p9Action(_ sender: AnyObject) {
        playerAction(sender, position: 9)
    }
    @IBAction func p10Action(_ sender: AnyObject) {
        playerAction(sender, position: 10)
    }
    @IBAction func p11Action(_ sender: AnyObject) {
        playerAction(sender, position: 11)
    }
    
    @IBAction func coach1Action(_ sender: AnyObject) {
        coachAction(sender, position: 1)
    }
    @IBAction func coach2Action(_ sender: AnyObject) {
        coachAction(sender, position: 2)
    }
    @IBAction func coach3Action(_ sender: AnyObject) {
        coachAction(sender, position: 3)
    }
    
    func coachAction (_ sender: AnyObject, position: Int){
        popoverAction(sender, position: position, role: TeamRole.coach)
    }
    
    func playerAction (_ sender: AnyObject, position: Int){
        popoverAction(sender, position: position, role: TeamRole.player)
    }
    
    func popoverAction (_ sender: AnyObject, position: Int, role: TeamRole){
        let playerInformationViewController =  PlayerPickerViewController()
        playerInformationViewController.position = position
        playerInformationViewController.role = role
        playerInformationViewController.modalPresentationStyle = .popover
        playerInformationViewController.preferredContentSize = CGSize(width: 300, height: 300)
        playerInformationViewController.caller = self
        
        let popoverPresentationViewController =  playerInformationViewController.popoverPresentationController
        popoverPresentationViewController?.permittedArrowDirections = .any
        popoverPresentationViewController?.delegate = self
        popoverPresentationViewController?.sourceRect = CGRect(x: 50, y: 50, width: 0, height: 0)
        //popoverPresentationController?.barButtonItem = sender
        popoverPresentationViewController?.sourceView = sender as? UIView
        present(playerInformationViewController, animated: true, completion: nil)
    }
    func bannerViewDidLoadAd(_ banner: ADBannerView!) {
        adBanner.isHidden = false
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
        adBanner.isHidden = true
    }
    
    func interstitialAdActionShouldBegin(_ interstitialAd: ADInterstitialAd!, willLeaveApplication willLeave: Bool) -> Bool {
        return true;
    }
    
    func interstitialAdDidUnload(_ interstitialAd: ADInterstitialAd!) {
    
    }
    func interstitialAd(_ interstitialAd: ADInterstitialAd!, didFailWithError error: Error!){
        
    }

}

