//
//  PlayerPickerViewController.swift
//  TOS
//
//  Created by Matteo on 17/09/15.
//  Copyright © 2015 Matteo Vitolo. All rights reserved.
//

import UIKit

enum TeamRole {
    case Coach, Player
}

class PlayerPickerViewController: UITableViewController {
    var items = NSMutableArray()
    var caller : TilesDelegate?
    var role : TeamRole?
    var position : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ( role == TeamRole.Player ){
            self.items.addObjectsFromArray(TOSCalculator.sharedInstance.getAllPlayersForPosition(self.position) as [AnyObject])
            self.title = String(format: "Player in position %d", position)

        } else if ( role == TeamRole.Coach ) {
            self.items.addObjectsFromArray(TOSCalculator.sharedInstance.coaches as [AnyObject])
            
            self.title = String(format: "Coach in position %d", position)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.items.count + 1)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()//tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        if ( indexPath.row == 0 ){
            cell.textLabel?.text = "Remove"
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            return cell
        }
        
        let player = self.items[indexPath.row - 1] as! NSDictionary
        if ( role == TeamRole.Player){
            cell.textLabel?.text = NSString(format: "%@ - %@", (player.objectForKey("ShirtNumber")?.stringValue)!, player.objectForKey("Name") as! NSString) as String
        }else if (role == TeamRole.Coach){
            cell.textLabel?.text =  player.objectForKey("Name") as? String
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if ( role == TeamRole.Player ){
            if (indexPath.row == 0){
                TOSCalculator.sharedInstance.removePlayerFromPosition(position)
            }else{
                let player = self.items[indexPath.row - 1] as! NSDictionary
            
                TOSCalculator.sharedInstance.addPlayerToTeam(player.objectForKey("ShirtNumber") as! NSNumber, playerName: player.objectForKey("Name") as! NSString as String, position: position)
            }
        }else if ( role == TeamRole.Coach ){
            if (indexPath.row == 0){
                TOSCalculator.sharedInstance.removeCoachFromPosition(position)
            }else{
                let coach = self.items[indexPath.row - 1] as! NSDictionary
            
                TOSCalculator.sharedInstance.addCoachToPosition(coach.objectForKey("Name") as! String, position: position)
            }
        }
        caller!.reassignTiles()

        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.dismissViewControllerAnimated(true, completion:nil)
        } else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}
