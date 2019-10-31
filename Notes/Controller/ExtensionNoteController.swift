//
//  ExtensiveNoteController.swift
//  Notes
//
//  Created by tranthanh on 10/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

extension NotesController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let viewFooter = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 64))
        let countLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        countLabel.center = viewFooter.center
        countLabel.text = "\(notes.count ) ghi chú"
        viewFooter.addSubview(countLabel)
        viewFooter.backgroundColor = UIColor.groupTableViewBackground
        return viewFooter
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
}

