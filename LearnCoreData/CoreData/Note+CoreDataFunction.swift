//
//  Note+CoreDataFunction.swift
//  LearnCoreData
//
//  Created by Toan on 6/13/20.
//  Copyright © 2020 Toan. All rights reserved.
//

import Foundation
import CoreData

extension Entity {
    static var share = Entity()
   
    func insertNewNote( _ username :String , _ content : String, _ dateTime : String ) {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: AppDelegate.managerObjectContext!) as! Entity
        note.id = UUID().uuidString // ham UUid().iiidString de generate ra 1 chuoi ki tu ko trung nhau
        note.username = username
        note.content = content
        note.date = dateTime
        note.isSelected = false
        // tien hanh luu giu lieu vao database
        do {
            try AppDelegate.managerObjectContext?.save()
            
        }catch{
            let err = error as NSError
            print("ko the them vao ghi chu . loi la \(err), \(err.userInfo)")
            
        }
        print("ghi chu thanh cong voi noi dung \(note.content ?? "") \n \(note.username ?? "")")
        
    }
    // tao ham lay giu lieu
    func getNote() -> [Entity] {
        var resurt = [Entity]()
        let moc = AppDelegate.managerObjectContext
        do{
            resurt = try moc!.fetch(Entity.fetchRequest() )as! [Entity]
        }catch {
            print("khong the fecth giu lieu \(error)")
        }
        return resurt
    }
    // xoa
    func deleteAllData(){
        let moc  = AppDelegate.managerObjectContext
        let notes = Entity.share.getNote()
        for i in notes {
            moc?.delete(i)
        }
        do {
            try AppDelegate.managerObjectContext?.save()
            print("xoa toan bo du lieu")
        }catch{
            let err =  error as NSError
            print("loi ko xoa dc \(err)")
        }
    }
    // xoa id
    func deleteById(_ id : String){
        let moc = AppDelegate.managerObjectContext
        let notes = Entity.share.getNote()
        for i in notes{
            if i.id  == id {
                moc?.delete(i)
            }
        }
        do{
            try AppDelegate.managerObjectContext?.save()
            print("xoa du lieu voi id")
        }catch {
            let err =  error as NSError
            print("loi ko xoa dc \(err)")
        }
    }
    // sua id
    func editCoreData(_ editId : String , _ username :String , _ content : String) {

        let note = Entity.share.getNote()
        for i in note {
            if i.id == editId{
                i.username = username
                i.content = content
                formatter.dateFormat = "dd.MM.yyyy"
                let resurt = formatter.string(from: date1)
                i.date = resurt
            
            }
        
    }
        
}
}
extension Entity {
    func getRequest(entityName : String ) -> NSFetchRequest<NSManagedObject>{
        return NSFetchRequest(entityName: entityName)
    }
    func findBy(entityName : String , predicate : NSPredicate? , sucess : (([NSManagedObject?])-> Void)?,fail : ((Error) -> Void)?){
        let request = getRequest(entityName: entityName)
        request.predicate = predicate
        do{
            let resurt = try AppDelegate.managerObjectContext?.fetch(request)
            sucess?(resurt!)
        }catch{
            fail?(error)
        }
    }
    func seachCoreData(_ text : String )  -> [Entity]{
    let predicate = NSPredicate(format: "username contains[c] %@", "\(text)")
        var data = [Entity]()
        findBy(entityName: "Entity", predicate: predicate, sucess: { (user) in
            guard let user = user as? [Entity] else{return}
            print(user)
            data = user
            
        }) { (err) in
            print(err)
            return
        }
        return data
    }
    
    
    
}
