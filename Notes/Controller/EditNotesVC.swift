//
//  EditNotesVC.swift
//  Notes
//
//  Created by tranthanh on 10/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

protocol MyDelegateEdit : class {
    
    func getdataEdit(dulieu: Note)

}


class EditNotesVC: UIViewController {
    
    var note : Note?
    
    let textView : UITextView = {
        let tv = UITextView()
        tv.text = ""
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.backgroundColor = .clear
        return tv
    }()
    
    weak var myDelegateEdit : MyDelegateEdit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textView)
        
        textView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        title = "Sửa ghi chú"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButton))
        textView.text = note?.title
        
    }
    

    @objc func saveButton(){
        // lấy dữ liệu từ textView
        let noteTitle = textView.text!
        if noteTitle == "" { return }
        let note = Note(title: noteTitle, date: ConvertHelper.stringFromDate(date: Date(), format: "dd/MM/yyyy"), isSelected: false)
        myDelegateEdit?.getdataEdit(dulieu: note)
        self.navigationController?.popViewController(animated: true)
    }
}


