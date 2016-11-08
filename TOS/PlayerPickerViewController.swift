//
//  PlayerPickerViewController.swift
//  TOS
//
//  Created by Matteo on 17/09/15.
//  Copyright © 2015 Matteo Vitolo. All rights reserved.
//

import UIKit

enum TeamRole {
    case coach, player
}

class PlayerPickerViewController: UITableViewController {
    var items = NSMutableArray()
    var caller : TilesDelegate?
    var role : TeamRole?
    var position : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ( role == TeamRole.player ){
            self.items.addObjects(from: TOSCalculator.sharedInstance.getAllPlayersForPosition(self.position) as [AnyObject])
            self.title = String(format: "Player in position %d", position)

        } else if ( role == TeamRole.coach ) {
            self.items.addObjects(from: TOSCalculator.sharedInstance.coaches as [AnyObject])
            
            self.title = String(format: "Coach in position %d", position)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.items.count + 1)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()//tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        if ( indexPath.row == 0 ){
            cell.textLabel?.text = "Remove"
            cell.textLabel?.textAlignment = NSTextAlignment.center
            return cell
        }
        
        let player = self.items[indexPath.row - 1] as! NSDictionary
        if ( role == TeamRole.player){
            cell.textLabel?.text = NSString(format: "%@ - %@", ((player.object(forKey: "ShirtNumber") as AnyObject).stringValue)!, player.object(forKey: "Name") as! NSString) as String
        }else if (role == TeamRole.coach){
            cell.textLabel?.text =  player.object(forKey: "Name") as? String
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if ( role == TeamRole.player ){
            if (indexPath.row == 0){
                TOSCalculator.sharedInstance.removePlayerFromPosition(position)
            }else{
                let player = self.items[indexPath.row - 1] as! NSDictionary
            
                TOSCalculator.sharedInstance.addPlayerToTeam(player.object(forKey: "ShirtNumber") as! NSNumber, playerName: player.object(forKey: "Name") as! NSString as String, position: position)
            }
        }else if ( role == TeamRole.coach ){
            if (indexPath.row == 0){
                TOSCalculator.sharedInstance.removeCoachFromPosition(position)
            }else{
                let coach = self.items[indexPath.row - 1] as! NSDictionary
            
                TOSCalculator.sharedInstance.addCoachToPosition(coach.object(forKey: "Name") as! String, position: position)
            }
        }
        caller!.reassignTiles()

        if UIDevice.current.userInterfaceIdiom == .pad {
            self.dismiss(animated: true, completion:nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
