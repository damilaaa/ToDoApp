//
//  ViewController.swift
//  ToDoApplication
//
//  Created by Damla Sahin on 5.10.2023.
//

import UIKit

class AnasayfaViewController: UIViewController {

    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var todoList = [ToDos]()
    
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        _ = viewModel.toDoList.subscribe(onNext: { liste in
            self.todoList = liste
            self.toDoTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.toDoYukle()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let todo = sender as? ToDos {
                let gidilecekVC = segue.destination as! ToDoDetayViewController
                gidilecekVC.todo = todo
            }
        }
    }

}

extension AnasayfaViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.ara(aramaKelimesi: searchText)
    }
}

extension AnasayfaViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hucre = tableView.dequeueReusableCell(withIdentifier: "ToDosHucre") as! ToDosHucre
        
        let todo = todoList[indexPath.row]
        
        hucre.labeltoDoName.text = todo.todo_name
        
        return hucre
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todoList[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: todo)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil") {contexualAction,view,bool in
            let todo = self.todoList[indexPath.row]
            let alert = UIAlertController(title: "Silme islemi", message: "\(todo.todo_name!) silinsin mi?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            let okAction = UIAlertAction(title: "Evet", style: .destructive) {action in
                self.viewModel.sil(todo_id: todo.todo_id!)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
}
