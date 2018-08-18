//
//  ToDoTableViewController.swift
//  Project 03 ToDo
//
//  Created by Chris on 18/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, UISplitViewControllerDelegate {

    var todoList = [ToDo(title: "Buy Milk", date: Date(timeIntervalSince1970: 1533139200), category: ToDo.Category.food),
                    ToDo(title: "Call Tim", date: Date(timeIntervalSince1970: 1534953600), category: ToDo.Category.people),
                    ToDo(title: "Presentation", date: Date(timeIntervalSince1970: 1534694400), category: ToDo.Category.work)]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction private func addToDo(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: nil)
    }
    
    // MARK: SplitView Delegate
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    // MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "edit", sender: todoList[indexPath.row])
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)
        let todo = todoList[indexPath.row]
        cell.imageView?.image = UIImage(named: todo.category.image())
        cell.textLabel?.text = todo.title
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        cell.detailTextLabel?.text = dateformatter.string(from: todo.date)
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let todo = todoList.remove(at: fromIndexPath.row)
        todoList.insert(todo, at: to.row)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "edit", let editVC = segue.destination as? EditViewController, let senderToDo = sender as? ToDo{
            editVC.todo = senderToDo
        }
    }

}
