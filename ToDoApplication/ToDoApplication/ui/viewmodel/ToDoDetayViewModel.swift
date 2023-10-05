//
//  ToDoDetayViewModel.swift
//  ToDoApplication
//
//  Created by Damla Sahin on 5.10.2023.
//

import Foundation

class ToDoDetayViewModel {
    
    var tRepo = ToDoDaoRepository()
    
    func guncelle(todo_id:Int, todo_name:String){
        tRepo.guncelle(todo_id: todo_id, todo_name: todo_name)
    }
}
