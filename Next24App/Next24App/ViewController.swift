//
//  ViewController.swift
//  Next24App
//
//  Created by Casey Chin on 9/23/24.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    /* tableView showing tasks for today */
    @IBOutlet weak var todayTableView: UITableView!
    
    /* tableView showing tasks for tomorrow */
    @IBOutlet weak var tomorrowTableView: UITableView!
    
    /* Cal to keep track of when days switch*/
    let calendar = Calendar.current
    let today = Date()
    var storedDate = Date(timeIntervalSince1970: 0)
    
    
    var todayTasks: [Task] = [Task(title: "add your tasks here", isCompleted: false)]
    var tomorrowTasks: [Task] = [Task(title: "your tasks for tomorrow will show here", isCompleted: false)]
    var defaultTasks: [Task] = [Task(title: "nothing here yet.. get busy!", isCompleted: false)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (storedDate == Date(timeIntervalSince1970: 0)) {
            storedDate = today
        }
        // Check if day has switched
        if !calendar.isDate(today, inSameDayAs: storedDate) {
            // Switch data to tomorrow's
            todayTasks = tomorrowTasks
            todayTasks = defaultTasks
            // Update storedDate to today
            storedDate = today
        }
        
        self.todayTableView.register(UITableViewCell.self, forCellReuseIdentifier: "today")
        self.tomorrowTableView.register(UITableViewCell.self, forCellReuseIdentifier: "tomorrow")
        
        todayTableView.delegate = self
        todayTableView.dataSource = self
        
        tomorrowTableView.delegate = self
        tomorrowTableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        todayTableView.addGestureRecognizer(tap)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc func doubleTapped(_ tableView: UITableView) {
        // do something here
        
        todayTasks.append(Task(title: "tester", isCompleted: false))
        todayTableView.reloadData()
        print("test")
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == todayTableView {
            
            return self.todayTasks.count
            
        } else {
            
            return self.tomorrowTasks.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == todayTableView {
            
            let cell: UITableViewCell = (self.todayTableView.dequeueReusableCell(withIdentifier: "today") )!
            
            cell.textLabel?.text = self.todayTasks[indexPath.row].title
            
            return cell
            
        }
        else if tableView == tomorrowTableView {
            
            let cell: UITableViewCell = (self.todayTableView.dequeueReusableCell(withIdentifier: "today") )!
            
            cell.textLabel?.text = self.todayTasks[indexPath.row].title
            
            return cell
            
        }
        else {return UITableViewCell()}
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped cell number \(indexPath.row).")
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if tableView == todayTableView {
           
            // action one
            
            let editAction = UITableViewRowAction(style: .default, title: "Push", handler: { (action, indexPath) in
                
                let task = self.todayTasks[indexPath.row]
                
                self.todayTasks.remove(at: indexPath.row)
                
                // delete the table view row
                self.todayTableView.deleteRows(at: [indexPath], with: .fade)
                
                self.tomorrowTasks.append(task)
                self.tomorrowTableView.reloadData()
                
            })
            editAction.backgroundColor = UIColor.systemYellow
            
            // action two
            let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
                self.todayTasks.remove(at: indexPath.row)
                
                // delete the table view row
                self.todayTableView.deleteRows(at: [indexPath], with: .fade)
            })
            deleteAction.backgroundColor = UIColor.systemRed
            
            return [editAction, deleteAction]
            
        }
        
        return nil
    }
    
    
}
