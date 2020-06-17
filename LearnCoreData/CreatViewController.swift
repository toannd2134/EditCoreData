//
//  CreatViewController.swift
//  LearnCoreData
//
//  Created by Toan on 6/13/20.
//  Copyright © 2020 Toan. All rights reserved.
//

import UIKit

class CreatViewController: UIViewController {
     var data   = Entity.share.getNote()
    let isEdit = false
    @IBOutlet weak var contentTextView: UITextView!{
        didSet{
            contentTextView.text = content
        }
    }
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var namtextField: UITextField!{
        didSet {
            namtextField.text = name
        }
    }
    var editId = String()
    let date = Date()
    let formatter = DateFormatter()
    var name = String()
    var content = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        contentTextView.layer.cornerRadius = 5
        let saveButton = UIBarButtonItem(title: "Luu ", style: .done, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isEditing == false {
            edit.isHidden = true
        }else{
            edit.isHidden = false
        }
    }
    @objc func save () {
        
            
                guard let name = namtextField.text , let content = contentTextView.text else {
                    return
                }
                formatter.dateFormat = "dd.MM.yyyy"
                let resurt = formatter.string(from: date)
                Entity.share.insertNewNote(name, content, resurt)
                
                self.navigationController?.popViewController(animated: true)
            
        
    }
    
   
    @IBAction func editAction(_ sender: Any) {
        
        Entity.share.editCoreData(editId, namtextField.text! , contentTextView.text!)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
