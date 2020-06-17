//
//  ViewController.swift
//  LearnCoreData
//
//  Created by Toan on 6/13/20.
//  Copyright © 2020 Toan. All rights reserved.
//

import UIKit
 
class ViewController: UIViewController {
    var data   = Entity.share.getNote()
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.sizeToFit()
        searchBar.placeholder = "Your placeholder"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        self.navigationItem.leftBarButtonItems = [add,leftNavBarButton]
        self.table.delegate = self
        self.table.dataSource = self
        table.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "datacell")
        let deleteButton = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(delete1))
        self.navigationItem.rightBarButtonItem = deleteButton
        self.searchBar.delegate = self
    }
    @objc func delete1(){
        Entity.share.deleteAllData()
        table.reloadData()
    }
    @objc func addItem(){
        let vc  = CreatViewController()
        vc.isEditing = false
        self.navigationController?.pushViewController(vc, animated: true)
        table.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        data = Entity.share.getNote()
        table.reloadData()
    }

}
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = table.dequeueReusableCell(withIdentifier: "datacell", for: indexPath) as! DataTableViewCell
        cell.name.text =  data[indexPath.row].username
        cell.content.text = data[indexPath.row].content
        cell.time.text = data[indexPath.row].date
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {[weak self](action, view, completion) in
            guard let  strongSelf = self else {return}
            let data = Entity.share.getNote()[indexPath.row]
            Entity.share.deleteById(data.id)
            strongSelf.table.reloadData()
            
            }
        
        let edit = UIContextualAction(style: .destructive, title: "Edit") {[weak self](action, view, completion) in
        guard let  strongSelf = self else {return}
        let data = Entity.share.getNote()[indexPath.row]
          let vc = CreatViewController()
            for i in strongSelf.data{
                if data.id ==  i.id {
                    vc.content = i.content!
                    vc.name = i.username!
                    vc.editId = i.id
                    vc.isEditing = true
                    strongSelf.navigationController?.pushViewController(vc, animated: true)
                }
            }
        
        }
       
       
        delete.backgroundColor = .red
        let configration = UISwipeActionsConfiguration(actions: [delete,edit])
        
        return configration
        
    }
    
}
extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            data = Entity.share.getNote()
            
        }else {
            data = Entity.share.seachCoreData(searchText)
        }
        table.reloadData()
    }
}

