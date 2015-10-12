//
//  ViewController_iphone.swift
//  TOS
//
//  Created by Matteo on 09/10/15.
//  Copyright © 2015 Matteo Vitolo. All rights reserved.
//

import UIKit

class ViewController_iphone: UITableViewController, UIPopoverPresentationControllerDelegate, TilesDelegate {
    @IBOutlet weak var counterLabel: UILabel!

    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TimeOfSoccer Calculator"
        reassignTiles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 3
        }else if section == 1 {
            return 11
        }
        return 11
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("iphMainCell", forIndexPath: indexPath)
        if indexPath.section == 0 {
            let coach = TOSCalculator.sharedInstance.getCoachFromPosition(indexPath.row + 1)
            if coach.count == 0 {
                cell.textLabel?.text = String(format: "%d -", indexPath.row + 1)

            }else{
                let name = coach.objectForKey("Name") as! NSString
                cell.textLabel?.text = String(format: "%d - %@", indexPath.row + 1, name)
            }
        }
        
        if indexPath.section == 1{
            let team = (TOSCalculator.sharedInstance.team) as NSDictionary
            let player = team.objectForKey(indexPath.row + 1) as! NSDictionary
            if player.count == 0 {
                cell.textLabel?.text = String(format: "%d -", indexPath.row + 1)
            }else{

                let shirtNumber = player.objectForKey("ShirtNumber") as! NSNumber
                let name = player.objectForKey("Name") as! NSString
                cell.textLabel?.text = String(format: "%d - %d %@", indexPath.row + 1, shirtNumber.intValue , name)
            }
            cell.textLabel?.backgroundColor =  TOSCalculator.sharedInstance.isPlayerAttackModule(indexPath.row + 1) ? UIColor.blueColor().colorWithAlphaComponent(0.4) : UIColor.greenColor().colorWithAlphaComponent(0.4)
            
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var role : TeamRole!
        if indexPath.section == 0 {
            role = TeamRole.Coach
        } else if indexPath.section == 1 {
            role = TeamRole.Player
        }
        popoverAction(self, position: indexPath.row + 1, role: role)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if ( section == 0){
            return "Coaches"
        } else if ( section == 1){
            return "Players"
        }
        return "-"
    }
    func reassignTiles(){
        self.tableView.reloadData()
        let attack = TOSCalculator.sharedInstance.calculateAttack()
        let defense = TOSCalculator.sharedInstance.calculateDefense()
        let counter = TOSCalculator.sharedInstance.calculateCounter()
        
        self.defenseLabel.text = String(format: "%d", defense)
        self.attackLabel.text = String(format: "%d", attack)
        self.counterLabel.text = String(format: "%d", counter)
    }
    func popoverAction (sender: AnyObject, position: Int, role: TeamRole){
        let playerInformationViewController =  PlayerPickerViewController()
        playerInformationViewController.position = position
        playerInformationViewController.role = role
        playerInformationViewController.modalPresentationStyle = .Popover
        playerInformationViewController.preferredContentSize = CGSizeMake(300, 300)
        playerInformationViewController.caller = self
        self.navigationController?.pushViewController(playerInformationViewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
