//
//  ToDos.swift
//  ToDoApplication
//
//  Created by Damla Sahin on 5.10.2023.
//

import Foundation

class ToDos {
    
    var todo_id: Int?
    var todo_name: String?

    init(){
        
    }

    init(todo_id: Int? , todo_name: String?) {
       self.todo_id = todo_id
       self.todo_name = todo_name
   }
}
