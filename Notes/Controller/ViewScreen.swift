//
//  ViewScreen.swift
//  Notes
//
//  Created by tranthanh on 10/5/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit


//b1:tạo protocol
protocol MyDelegateAppend : class {
    //b2: tạo phuong thuc bat buoc
    func getdataAppend(dulieu: Note)
}

class ViewScreen: UIViewController {

    
    var note : Note?
    // khởi tạo biến date
    let date = Date()
    
    //b3 : tạo 1 biến dalegate
    weak var myDelegate : MyDelegateAppend?
    
    let textView : UITextView = {
        let tv = UITextView()
        tv.text = ""
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.backgroundColor = .clear
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white
        view.addSubview(textView)
        textView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        title = "Tạo ghi chú"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButton))
        
    }
    
    @objc func saveButton(){
        // lấy dữ liệu từ textView
        let noteTitle = textView.text!
        if noteTitle == "" { return }
        let note = Note(title: noteTitle, date: ConvertHelper.stringFromDate(date: Date(), format: "dd/MM/yyyy"), isSelected: false)
        //b4: truyền dữ liệu vào delegate
        myDelegate?.getdataAppend(dulieu: note)
          self.navigationController?.popViewController(animated: true)
  }
}

class ConvertHelper {
    // hàm này để convert ngày tháng năm (kiểu Date) thành chuỗi (kiểu String)
    static func stringFromDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let string = formatter.string(from: date)
        return string
    }
}
