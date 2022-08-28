//
//  TasksViewController.swift
//  ToDoListApp
//
//  Created by Алексей Гайдуков on 28.08.2022.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet var lable: UILabel!
    
    var task: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lable.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask() {
        guard let count = UserDefaults().value(forKey: "count") as? Int else { return }
        let newCount = count - 1
        
        UserDefaults().setValue(newCount, forKey: "count")
        UserDefaults().setValue(nil, forKey: "task_\(newCount)")
    }


}
