//
//  ToDoKayitViewController.swift
//  ToDoApplication
//
//  Created by Damla Sahin on 5.10.2023.
//

import UIKit

class ToDoKayitViewController: UIViewController {

    @IBOutlet weak var tfTodoName: UITextField!
    
    var viewModel = ToDoKayitViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func buttonKaydet(_ sender: Any) {
        if let ad = tfTodoName.text {
            viewModel.kaydet(todo_name: ad)
        }
    }
    
}
