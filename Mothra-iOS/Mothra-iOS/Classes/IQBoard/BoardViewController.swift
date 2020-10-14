//
//  BoardViewController.swift
//  Mothra
//
//  Created by kuroky on 2019/7/3.
//  Copyright © 2019 Emucoo. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "IQKeyboardManager"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 60;
    }
    
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        var text = cell.contentView.viewWithTag(101) as? UITextField
        if text == nil {
            text = UITextField(frame: CGRect.init(x: 10, y: 10, width: 300, height: 45))
            cell.contentView.addSubview(text!)
            text!.tag = 101
        }
        text?.placeholder = "请输入"
        
        return cell
    }
}
