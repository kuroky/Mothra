//
//  ViewController.swift
//  Mothra-iOS
//
//  Created by kuroky on 2020/3/31.
//  Copyright © 2020 Emucoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var tableView: UITableView!
    private let dataList = ["Network", "Image", "HUD", "IQKeyboardManager", "Cache", "Utils"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 60
        
        self.navigationItem.title = "Test"
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cell.textLabel?.text = self.dataList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = self.dataList[indexPath.row]
        if title == "Network" {
            self.navigationController?.pushViewController(NetworkViewController(), animated: true)
        }
        else if title == "HUD" {
            self.navigationController?.pushViewController(HUDViewController(), animated: true)
        }
        else if title == "IQKeyboardManager" {
            self.navigationController?.pushViewController(BoardViewController(), animated: true)
        }
        else if title == "Cache" {
            self.navigationController?.pushViewController(CacheViewController(), animated: true)
        }
        else if title == "Image" {
            self.navigationController?.pushViewController(ImageViewController(), animated: true)
        }
        else if title == "Utils" {
            self.navigationController?.pushViewController(UtilsViewController(), animated: true)
        }
    }
}

