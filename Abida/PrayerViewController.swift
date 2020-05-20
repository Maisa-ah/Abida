//
//  PrayerViewController.swift
//  Abida
//
//  Created by Maisa Ahmad on 5/3/20.
//  Copyright © 2020 Maisa Ahmad. All rights reserved.
//

import UIKit
import CoreLocation

/*class controls home screens view - receives info for prayer time api and gets location
 
 corelocation reference: textbook
 */

class PrayerViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //    @IBOutlet weak var rTitle: UILabel!
    //    @IBOutlet weak var rDes: UILabel!
    //    @IBOutlet weak var rDate: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    //    @IBOutlet weak var remindView: UIView!
    
    let locationManager = CLLocationManager()
    var Times : Timings?{
        didSet{
            //  lets the calling queue move on without waiting until the dispatched block is executed
            //  update the main thread when the task is finished
            DispatchQueue.main.async{
                self.tableView.reloadData()
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = color2
        
        locationManager.requestAlwaysAuthorization()
        tableView.delegate = self
        tableView.dataSource = self
        
        let controller = ReminderViewController()
        controller.remindDelegate = self
        
        //get user location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        self.view.backgroundColor = color1
        tableView.contentInset = UIEdgeInsets.zero
        tableView.backgroundColor = color1
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    /*for each cell, get appropriate info passed on from api*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeslot", for: indexPath) as UITableViewCell
        cell.backgroundColor = color2
        
        let timeLabel = cell.viewWithTag(9) as! UILabel
        let nameLabel = cell.viewWithTag(10) as! UILabel
        guard let times = Times
            else{
                return cell
        }
        if indexPath.row == 0{
            nameLabel.text = "Fajr"
            timeLabel.text = times.Fajr
        }
        else if indexPath.row == 1{
            nameLabel.text = "Dhuhr"
            timeLabel.text = times.Dhuhr
        }
        else if indexPath.row == 2{
            nameLabel.text = "Asr"
            timeLabel.text = times.Asr
        }
        else if indexPath.row == 3{
            nameLabel.text = "Maghrib"
            timeLabel.text = times.Maghrib
        }
        else{
            nameLabel.text = "Isha"
            timeLabel.text = times.Isha
        }
        
        return cell
    }
    
    /*receives location to throw into api request - needed since prayer times vary by location*/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            //            print(location.coordinate)
            let lat = String(format: "%f", location.coordinate.latitude)
            let long = String(format: "%f", location.coordinate.longitude)
            //            print(lat)
            //            print(long)
            
            //call to api request, throw in location parameters
            let timeRequest = PrayerRequest(latitude:lat, longitude:long)
            timeRequest.getTimes { [weak self] result in
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let times):
                    self?.Times = times
                    //                    print("hey")
                    //                    print(self?.Times)
                }
            }
        }
    }
    
    /*Reference: stackoverflow*/
    // if access denied, give user chance to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    /*create alert if location access is disabled that lets you into settings screen*/
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Location Access Denied", message: "Location needed for app to provide data.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

extension PrayerViewController: RemindDelegate{
    func didTapSave(name: String, des: String, remindDate: Date) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: remindDate)
        
        print("this is name ",name)
        
        //        rTitle.text = name
        //        rDes.text = des
        //        rDate.text = strDate
        
    }
    
    
}
