//
//  HUDViewController.swift
//  Mothra
//
//  Created by kuroky on 2019/7/3.
//  Copyright © 2019 Emucoo. All rights reserved.
//

import UIKit
import Mothra

class HUDViewController: UITableViewController {

    private let dataList = ["Animated progress", "Animated Success", "toast", "custom"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 60
        self.navigationItem.title = "HUD"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.dataList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = self.dataList[indexPath.row]
        
        if title == "Animated progress" {
            MTHUD.showSuccess()
        }
        else if title == "Animated Success" {
            MTHUD.showProgress(title: "")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                MTHUD.hide()
            }
        }
        else if title == "toast" {
            DispatchQueue.global().async {
                MTHUD.toast(title: "this is a toast")
            }
        }
        else if title == "custom" {
            MTHUD.showCustomPorgress()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                MTHUD.showSuccess()
            }
        }
    }
}
