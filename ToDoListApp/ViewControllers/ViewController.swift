//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Алексей Гайдуков on 28.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //Setup
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        // get all current saved tasks
        updateTasks()
    }
    
    func updateTasks() {
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else { return }
        for x in 0..<count {
            if let task  = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        tableView.reloadData()
    }

    @IBAction func didTapAdd() {
        guard let vc = storyboard?.instantiateViewController(identifier: "entry") as? EntryViewController else { return }
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        guard let vc = storyboard?.instantiateViewController(identifier: "task") as? TasksViewController else { return }
        vc.title = "New Task"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}

