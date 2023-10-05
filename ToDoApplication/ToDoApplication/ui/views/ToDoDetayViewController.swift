//
//  ToDoDetayViewController.swift
//  ToDoApplication
//
//  Created by Damla Sahin on 5.10.2023.
//

import UIKit

class ToDoDetayViewController: UIViewController {

    @IBOutlet weak var tfTodoName: UITextField!
    
    var todo: ToDos?
    var viewModel = ToDoDetayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let t = todo {
            tfTodoName.text = t.todo_name
        }

    }
    
    @IBAction func buttonGuncelle(_ sender: Any) {
        if let ad = tfTodoName.text, let t = todo {
            viewModel.guncelle(todo_id: t.todo_id!, todo_name: ad)
        }
    }
    
}
