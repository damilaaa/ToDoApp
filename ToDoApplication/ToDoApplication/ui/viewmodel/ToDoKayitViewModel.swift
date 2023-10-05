//
//  ToDoKayitViewModel.swift
//  ToDoApplication
//
//  Created by Damla Sahin on 5.10.2023.
//

import Foundation

class ToDoKayitViewModel {
    var tRepo = ToDoDaoRepository()
    
    func kaydet(todo_name:String){
        tRepo.kaydet(todo_name: todo_name)
    }
}
