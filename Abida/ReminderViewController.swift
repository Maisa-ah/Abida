//
//  ReminderViewController.swift
//  Abida
//
//  Created by Maisa Ahmad on 5/11/20.
//  Copyright © 2020 Maisa Ahmad. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData


protocol RemindDelegate: class {
    func didTapSave(name: String, des:String, remindDate: Date)
}

class ReminderViewController: UIViewController {
    
    weak var remindDelegate: RemindDelegate?
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var desText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    /*test if datepicker is changing and how to access its values with dateformatter*/
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        //        print(strDate)
    }
    
    /*when saving, add info into array so tableview controller can access what notifications were created
     function calls schedule function so notifications are registered
     */
    @IBAction func SaveButton() {
        if let nametext = nameText.text, !nametext.isEmpty,
            let destext = desText.text, !destext.isEmpty {
            
            let notifDate = datePicker.date
            RemindersTableViewController().schedule(nametext: nametext, desText:destext, dateTime:notifDate)
            
            //        remind.append(Reminder(name: nametext, description:destext, notifdate:notifDate))
            //            print(Reminder(name: nametext, description:destext, notifdate:notifDate))
            //            print(remind.count)
            
            //            close view and go to previous
            
            _ = navigationController?.popViewController(animated: true)
            
            //            call delegate on save and pass parameters to new notification
            
            
            /*lets core data handle the information so that it is saved when application is terminated*/
            let ob = ReminderItem(context: persistence.context)
            ob.title = nametext
            ob.des = destext
            ob.remindAt = notifDate
            remindersOb.append(ob)
            persistence.saveContext()
            
            remindDelegate?.didTapSave(name: nametext, des: destext, remindDate: notifDate)
            //            print(nametext, destext, notifDate)
            
            
        }
    }
    
}
