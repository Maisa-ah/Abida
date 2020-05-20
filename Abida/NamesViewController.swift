//
//  NamesViewController.swift
//  Abida
//
//  Created by Maisa Ahmad on 5/6/20.
//  Copyright © 2020 Maisa Ahmad. All rights reserved.
//

import UIKit

class NamesViewController: UITableViewController {
    
    /*animate on load*/
    override func viewDidLoad() {
        super.viewDidLoad()
        animateTable()
        let title = "99 Names of Allah"
        self.tableView.backgroundColor = color1
        self.view.backgroundColor = color4
        self.navigationItem.title = title
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }
    
    //function will deselect a selected row, so the row will only be highlighted when selected
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse", for: indexPath) as UITableViewCell
        cell.backgroundColor = color1
        let backgroundView = UIView()
        backgroundView.backgroundColor = color2
        cell.selectedBackgroundView = backgroundView
        let nameLabel = cell.viewWithTag(1000) as! UILabel
        nameLabel.text = names[indexPath.row]
        
        let meaningLabel = cell.viewWithTag(50) as! UILabel
        meaningLabel.text = meanings[indexPath.row]
        
        return cell
    }
    
    /*function animates table so cells move upwards with a slight delay between each other
     
     reference: https://www.youtube.com/watch?v=FpTY04efWC0
     */
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let height = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: height)
        }
        
        var delay = 0
        //        ease-out curve causes the animation to begin quickly, then slow
        for cell in cells {
            UIView.animate(withDuration: 2, delay: Double(delay) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delay += 1
        }
    }
    
}
