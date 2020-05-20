//
//  RemindersTableViewController.swift
//  Abida
//
//  Created by Maisa Ahmad on 5/13/20.
//  Copyright © 2020 Maisa Ahmad. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

//array of reminders to notify about
//var remind = [Reminder]()
var remindersOb = [ReminderItem]()

class RemindersTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //request notification info on load
        NotifRequest()
        tableView.delegate = self
        tableView.dataSource = self
        
        let fetchRequest: NSFetchRequest<ReminderItem> = ReminderItem.fetchRequest()
        do{
            let remindob = try persistence.context.fetch(fetchRequest)
            remindersOb = remindob
        }catch{}
    }
    
    
    
    //  request authorization to make notification and play sound
    func NotifRequest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
            if success{
                print("success!")
                //self.schedule(nametext: "pls", desText: "yay", dateTime: Date())
            }
            else if error != nil{
                print("error")
            }
        })
    }
    
    /*Schedules notifications by taking name, description and date of info user has applied*/
    func schedule(nametext: String, desText: String, dateTime: Date){
        let content = UNMutableNotificationContent()
        //title, sound and badge members of notification content
        content.title = nametext
        content.sound = .default
        content.body = desText
        
        
        //grabs data components and schedules notification
        let datetime = dateTime
        let schedule = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: datetime), repeats: false)
        //                print("this is content title" ,datetime)
        
        /*to help accesss specific notifications upon deletion, throws in time notification is to be done to differenciate between one another*/
        let request = UNNotificationRequest(identifier: "notif Optional(\(String(describing: datetime)))", content: content, trigger: schedule)
        
        //        print("this is notif title ", "notif Optional(\(String(describing: datetime)))")
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil{
                print("error")
            }
        })
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return remind.count
        return remindersOb.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "remind", for: indexPath)
        
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["notif \(String(describing: remindersOb[indexPath.row].remindAt))"])
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        //        let strDate = dateFormatter.string(from: remind[indexPath.row].notifdate)
        let strDate = dateFormatter.string(from: remindersOb[indexPath.row].remindAt!)
        
        
        cell.backgroundColor = color1
        let backgroundView = UIView()
        backgroundView.backgroundColor = color2
        cell.selectedBackgroundView = backgroundView
        let nameLabel = cell.viewWithTag(12) as! UILabel
        //        nameLabel.text = remind[indexPath.row].name
        nameLabel.text = remindersOb[indexPath.row].title
        
        let desLabel = cell.viewWithTag(13) as! UILabel
        //       desLabel.text = remind[indexPath.row].description
        desLabel.text = remindersOb[indexPath.row].des
        
        let dateLabel = cell.viewWithTag(14) as! UILabel
        dateLabel.text = strDate
        
        
        
        return cell
    }
    
    /*when deleting a cell, not only deletes the cell but the notification requested as well*/
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //        if editingStyle == .delete {
        //            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["notif \(String(describing: remind[indexPath.row].notifdate))"])
        //            print("this is index title:" ,remind[indexPath.row].notifdate)
        //            remind.remove(at: indexPath.row)
        //            print(remind.count)
        
        if editingStyle == .delete {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["notif \(String(describing: remindersOb[indexPath.row].remindAt))"])
            //                    print("this is index title:" ,"notif \(remindersOb[indexPath.row].remindAt)")
            
            persistence.context.delete(remindersOb[indexPath.row])
            remindersOb.remove(at: indexPath.row)
            //                    print(remindersOb.count)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
