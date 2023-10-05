//
//  ToDoDaoRepository.swift
//  ToDoApplication
//
//  Created by Damla Sahin on 5.10.2023.
//

import Foundation
import RxSwift

class ToDoDaoRepository {
    var todoList = BehaviorSubject<[ToDos]>(value: [ToDos]())
    
    let db: FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veriTabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("toDos.sqlite")
        db = FMDatabase(path: veriTabaniURL.path)
    }
    
    func kaydet(todo_name:String){
        
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO todo (todo_name) VALUES (?)", values: [todo_name])
            
        } catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func guncelle(todo_id:Int, todo_name:String){
        db?.open()
        do{
            try db!.executeUpdate("UPDAE todo SET todo_name=? WHERE todo_id=?", values: [todo_name,todo_id])
            
        } catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func ara(aramaKelimesi: String) {
        db?.open()
        var liste = [ToDos]()
        do{
            let rs = try db!.executeQuery("SELECT * FROM todo WHERE todo_name like '%\(aramaKelimesi)%'", values: nil)
            while rs.next() {
                let todo_id = Int(rs.string(forColumn: "todo_id"))!
                let todo_name = rs.string(forColumn: "todo_name")!
                
                let todo = ToDos(todo_id: todo_id, todo_name: todo_name)
                liste.append(todo)
            }
            
            
            todoList.onNext(liste)
        } catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func sil(todo_id: Int) {
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM todo WHERE todo_id=?", values: [todo_id])
            
        } catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func toDoYukle() {
        db?.open()
        var liste = [ToDos]()
        do{
            let rs = try db!.executeQuery("SELECT * FROM todo", values: nil)
            while rs.next() {
                let todo_id = Int(rs.string(forColumn: "todo_id"))!
                let todo_name = rs.string(forColumn: "todo_name")!
                
                let todo = ToDos(todo_id: todo_id, todo_name: todo_name)
                liste.append(todo)
            }
            
            
            todoList.onNext(liste)
        } catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func veritabaniKopyala(){
            let bundleYolu = Bundle.main.path(forResource: "toDos", ofType: ".sqlite")
            let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("toDos.sqlite")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: kopyalanacakYer.path){
                print("Veritabanı zaten var")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                }catch{}
            }
        }
}
