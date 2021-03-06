//
//  EventTableViewController.swift
//  StickToIt
//
//  Created by twer on 7/19/15.
//  Copyright (c) 2015 twer. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {

    var eventList = [Event]()
    var event:Event!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func removeEvent(event:Event){
        var toBeRemovedIndex:Int?
        for index in 0...eventList.count{
            if eventList[index] === event{
                toBeRemovedIndex = index
                break
            }
        }
        
        if let unwrappedToBeRemovedIndex = toBeRemovedIndex{
            eventList.removeAtIndex(unwrappedToBeRemovedIndex)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return eventList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventTableViewCell
        let cellData = eventList[indexPath.row]
        
        cell.eventName.text = cellData.name
        cell.times.text = String(cellData.times)
        
        cell.alertImage.hidden = !cellData.needAlert
        cell.checkedImage.hidden = !cellData.checkedThisTime
        
        return cell
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
       performSegueWithIdentifier("showDetail", sender: eventList[indexPath.row])
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showDetail")
        {
            let item = sender as! Event
            
            let eventDetailViewController = segue.destinationViewController as! EventDetailViewController
            eventDetailViewController.event = item
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellData = eventList[indexPath.row]
        cellData.times++
        cellData.checkedThisTime = true
        
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    @IBAction func unwindFromAddEvent(sender: UIStoryboardSegue){
        eventList.append(event)
        event.saveInBackground()
    }
    
    @IBAction func unwindFromDeleteEvent(sender: UIStoryboardSegue){
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
}
