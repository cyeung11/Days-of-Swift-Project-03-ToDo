//
//  ViewController.swift
//  Project 03 ToDo
//
//  Created by Chris on 18/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {
    
    var todo: ToDo?
    var currentSelection = ToDo.Category.work

    @IBOutlet weak var titleField: UITextField!{
        didSet{
            titleField.delegate = self
            titleField.placeholder = "Title"
            titleField.adjustsFontSizeToFitWidth = true
            titleField.minimumFontSize = 12.0
            titleField.returnKeyType = .done
        }
    }
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var work: UIImageView!
    @IBOutlet weak var money: UIImageView!
    @IBOutlet weak var shopping: UIImageView!
    @IBOutlet weak var people: UIImageView!
    @IBOutlet weak var food: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo{
            titleField.text = todo.title
            date.setDate(todo.date, animated: false)
            currentSelection = todo.category
        }
        selectCategory(category: todo?.category)
    }
    
    //MARK: DELEGATE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: ACTION
    @IBAction func selectedImage(recognizer: UITapGestureRecognizer) {
        switch recognizer.view {
        case work:
            currentSelection = .work
        case money:
            currentSelection = .money
        case shopping:
            currentSelection = .shopping
        case people:
            currentSelection = .people
        case food:
            currentSelection = .food
        default:
            return
        }
        selectCategory(category: currentSelection)
    }
    
    @IBAction func save(_ sender: Any) {
        let title = (titleField.text ?? "Untitled") == "" ?"Untitled" :(titleField.text ?? "Untitled")
        
        if let navVC = splitViewController?.viewControllers.first as? UINavigationController, let toDoTableViewVC = navVC.topViewController as? ToDoTableViewController{
            if todo == nil{
                toDoTableViewVC.todoList.append(ToDo(title: title, date: date.date, category: currentSelection))
                toDoTableViewVC.tableView.insertRows(at: [IndexPath(row: toDoTableViewVC.todoList.count-1, section: 0)], with: .top)
            } else {
                if let index = toDoTableViewVC.todoList.index(of: todo!){
                    toDoTableViewVC.todoList[index] = ToDo(title: title, date: date.date, category: currentSelection)
                    toDoTableViewVC.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
        } else if let navigationVC = navigationController,
            let toDoTableViewVC = navigationVC.viewControllers[navigationVC.viewControllers.count-2] as? ToDoTableViewController{
            if todo == nil{
                toDoTableViewVC.todoList.append(ToDo(title: title, date: date.date, category: currentSelection))
                toDoTableViewVC.tableView.insertRows(at: [IndexPath(row: toDoTableViewVC.todoList.count-1, section: 0)], with: .top)
            } else {
                if let index = toDoTableViewVC.todoList.index(of: todo!){
                    toDoTableViewVC.todoList[index] = ToDo(title: title, date: date.date, category: currentSelection)
                    toDoTableViewVC.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    private func selectCategory(category: ToDo.Category?){
        work.image = UIImage(named: "work")?.grayScaleImage
        money.image = UIImage(named: "money")?.grayScaleImage
        shopping.image = UIImage(named: "shopping")?.grayScaleImage
        people.image = UIImage(named: "people")?.grayScaleImage
        food.image = UIImage(named: "food")?.grayScaleImage
        
        if let category = category{
            switch category{
            case .work:
                work.image = UIImage(named: "work")
            case .money:
                money.image = UIImage(named: "money")
            case .food:
                food.image = UIImage(named: "food")
            case .people:
                people.image = UIImage(named: "people")
            case .shopping:
                shopping.image = UIImage(named: "shopping")
            }
        }
    }
}

extension UIImage{
    var grayScaleImage: UIImage?{
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        currentFilter!.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        if let output = output{
            let cgImage = CIContext(options: nil).createCGImage(output, from: output.extent)
            return UIImage(cgImage: cgImage!)
        } else {
            return nil
        }
    }
}

