//
//  ImageViewController.swift
//  Mothra
//
//  Created by kuroky on 2019/7/3.
//  Copyright © 2019 Emucoo. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataList = ["List", "Detail"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 60;
    }
}

extension ImageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.dataList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = self.dataList[indexPath.row]
        if title == "List" {
            self.navigationController?.pushViewController(ImageListViewController(), animated: true)
        }
        else if title == "Detail" {
            self.navigationController?.pushViewController(ImageDetailViewController(), animated: true)
        }
    }
}
