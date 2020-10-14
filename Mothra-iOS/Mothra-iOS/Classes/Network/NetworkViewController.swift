//
//  NetworkViewController.swift
//  Mothra
//
//  Created by kuroky on 2019/7/2.
//  Copyright © 2019 Emucoo. All rights reserved.
//

import UIKit
import Mothra
import Moya

class NetworkViewController: UITableViewController {

    private let dataList = ["normal", "hud", "cancel"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 60
        self.navigationItem.title = "Network"
        
        NetworkConfig.shared.showConsole = false;
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
        let para = ["mobile": "wbd",
                    "password": "e10adc3949ba59abbe56e057f20f883e",
                    "pushToken": ""]
        let login = NetworkAPI(method: .login(para: ["data": para]))
        
        if title == "normal" {
            login.startRequest { resp in
                print(resp)
            }
        }
        else if title == "hud" {
            login.startRequestWithHUD { resp in
                print(resp)
            }
        }
        else if title == "cancel" {
            //let para = ["appVersion": "2.5.1.4", "appType": "1"]
            //let cancel = FetchCancel(target: .versionCheck(para: para)) { resp in
                //print(resp)
            //}
            //cancel.cancel()
         
        }
    }
}


