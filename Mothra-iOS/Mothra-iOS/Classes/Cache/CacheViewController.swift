//
//  CacheViewController.swift
//  Mothra
//
//  Created by kuroky on 2020/3/27.
//  Copyright © 2020 Emucoo. All rights reserved.
//

import UIKit
import AVFoundation
import Mothra

class CacheViewController: UITableViewController {

    let dataList = ["Objc-Codable", "GetCache-Codable", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.title = "Cache"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 45
    }
}

extension CacheViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  dataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = dataList[indexPath.row]
        if title == "Objc-Codable" {
            let user = User.init(city: "sh", name: "tom")
            MTCache.shared.setObject(objc: user, forkey: "user") { succse in
                print("succse: \(succse)")
            }
        }
        else if title == "GetCache-Codable" {
            let key = "user"
            guard let user = MTCache.shared.getObject(for: key, type: User.self) else {
                print("no cache for key \(key)")
                return
            }
            
            print("cache :\(user)")
        }
    }
}
