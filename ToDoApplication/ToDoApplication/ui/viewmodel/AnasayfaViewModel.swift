//
//  AnasayfaViewModel.swift
//  ToDoApplication
//
//  Created by Damla Sahin on 5.10.2023.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var tRepo = ToDoDaoRepository()
    var toDoList = BehaviorSubject<[ToDos]>(value: [ToDos]())

    init() {
        tRepo.veritabaniKopyala()
        toDoList = tRepo.todoList
    }
    
    func ara(aramaKelimesi: String) {
        tRepo.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func sil(todo_id: Int) {
        tRepo.sil(todo_id: todo_id)
        toDoYukle()
    }
    
    func toDoYukle() {
        tRepo.toDoYukle()
    }
}
