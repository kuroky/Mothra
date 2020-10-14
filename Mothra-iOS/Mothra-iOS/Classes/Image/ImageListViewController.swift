//
//  ImageListViewController.swift
//  Mothra
//
//  Created by kuroky on 2019/7/4.
//  Copyright © 2019 Emucoo. All rights reserved.
//

import UIKit
import Mothra
import SnapKit

class ImageListViewController: UITableViewController {
    
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0

    var dataList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "图片加载"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 380;
                
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.dataList = ["https://wx4.sinaimg.cn/large/a7d296e6ly1g2zdmlrqmej20sg0sg0vh.jpg",
                             "https://wx1.sinaimg.cn/large/a7d296e6ly1g2zdmm9ld5j20sg0sgwig.jpg",
                             "https://wx4.sinaimg.cn/large/a7d296e6ly1g2zdmmnxloj20sg0sgq6c.jpg",
                             "https://wx1.sinaimg.cn/large/a7d296e6ly1g2zdmn254kj20sg0sgn0n.jpg",
                             "https://wx1.sinaimg.cn/large/a7d296e6gy1g2ze3q9lwvg20f0073npe.gif",
                             "https://wx4.sinaimg.cn/large/a7d296e6ly1g2zdmnjbphj20sg0sgwhh.jpg",
                             "https://wx1.sinaimg.cn/large/a7d296e6ly1g2zdmnvuuhj20sg0sgn01.jpg",
                             "https://wx4.sinaimg.cn/large/a7d296e6ly1g2zdml6xg5j20sg0sgdip.jpg",
                             "https://wx2.sinaimg.cn/large/a7d296e6ly1g2zdpjh3iqj20sg0sgwh4.jpg"]
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        width = self.view.frame.size.width - 20
        height = 300 - 20
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        var imageView = cell.contentView.viewWithTag(101) as? UIImageView
        if imageView == nil {
            imageView = UIImageView(frame: CGRect.zero)
            cell.contentView.addSubview(imageView!)
            imageView?.snp.makeConstraints({ (make) in
                make.leading.equalTo(cell.contentView.snp.leading).offset(10)
                make.trailing.equalTo(cell.contentView.snp.trailing).offset(-10)
                make.top.equalTo(cell.contentView.snp.top).offset(10)
                make.bottom.equalTo(cell.contentView.snp.bottom).offset(-10)
            })
        }
        imageView?.backgroundColor = UIColor.lightGray
        
        let url = self.dataList[indexPath.row]
        imageView?.setImage(url: url, size: CGSize(width: width, height: height))
        return cell
    }
}
