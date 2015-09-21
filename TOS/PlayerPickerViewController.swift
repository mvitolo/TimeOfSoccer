//
//  PlayerPickerViewController.swift
//  TOS
//
//  Created by Matteo on 17/09/15.
//  Copyright © 2015 Funambol. All rights reserved.
//

import UIKit

enum TeamRole {
    case Coach, Player
}

class PlayerPickerViewController: UITableViewController {
    var items = NSMutableArray()
    var caller : UIViewController?
    var role : TeamRole?
    var position : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ( role == TeamRole.Player ){
            self.items.addObjectsFromArray(TOSCalculator.sharedInstance.getAllPlayersForPosition(self.position) as [AnyObject])

        } else if ( role == TeamRole.Coach ) {
            self.items.addObjectsFromArray(TOSCalculator.sharedInstance.coaches as [AnyObject])
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()//tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        let player = self.items[indexPath.row] as! NSDictionary
        if ( role == TeamRole.Player){
            cell.textLabel?.text = NSString(format: "%@ - %@", (player.objectForKey("ShirtNumber")?.stringValue)!, player.objectForKey("Name") as! NSString) as String
        }else if (role == TeamRole.Coach){
            cell.textLabel?.text =  player.objectForKey("Name") as? String
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if ( role == TeamRole.Player ){
            let player = self.items[indexPath.row] as! NSDictionary
            
            TOSCalculator.sharedInstance.addPlayerToTeam(player.objectForKey("ShirtNumber") as! NSNumber, playerName: player.objectForKey("Name") as! NSString as String, position: position)
            (caller as! ViewController).reassignTiles()
            
            self.dismissViewControllerAnimated(true, completion:nil)
        }else if ( role == TeamRole.Coach ){
            let coach = self.items[indexPath.row] as! NSDictionary
            
            TOSCalculator.sharedInstance.addCoachToPosition(coach.objectForKey("Name") as! String, position: position)
            (caller as! ViewController).reassignTiles()
            
            self.dismissViewControllerAnimated(true, completion:nil)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}