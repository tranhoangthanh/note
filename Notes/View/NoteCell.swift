//
//  NoteCell.swift
//  Notes
//
//  Created by tranthanh on 10/4/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class NoteCell : UITableViewCell {

    let titleLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "tên sach"
        lbl.font = UIFont.systemFont(ofSize: 15)
        
        return lbl
    }()
    let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "29/12/2013"
        return label
    }()
    
    lazy var selectButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleBtn), for: .touchUpInside)
        btn.backgroundColor = .clear
        return btn
    }()
    
    var indexPath: IndexPath!
    
    //b1 khai báo  cloruse.
    //Void là biểu thị nó k trả về cái gì
    var selectAction: ((IndexPath) -> Void)?
    
    @objc func handleBtn(){
        
       // b2 : truyền dữ liệu vào closure
        self.selectAction?(self.indexPath)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(titleLbl)
        addSubview(dateLabel)
        addSubview(selectButton)
        
        titleLbl.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        dateLabel.anchor(top: titleLbl.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
        selectButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 25, height: 25)
        
      
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

