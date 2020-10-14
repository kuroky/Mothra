//
//  ImageDetailViewController.swift
//  Mothra
//
//  Created by kuroky on 2019/7/4.
//  Copyright © 2019 Emucoo. All rights reserved.
//

import UIKit
import Mothra

class ImageDetailViewController: UIViewController {

    var imageView: UIImageView!
    let url = "https://wx1.sinaimg.cn/large/a7d296e6ly1g2zdmm9ld5j20sg0sgwig.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.title = "图片缓存"
        imageView = UIImageView(frame: CGRect.zero)
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.leading).offset(15)
            make.trailing.equalTo(self.view.snp.trailing).offset(-15)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.height.equalTo(300)
        }
        
        ImageCacheManager.getImage(forKey: url) { [weak self] image in
            if let image = image {
                self?.imageView.image = image
            }
            else {
                self?.imageView.backgroundColor = UIColor.lightGray
                MTHUD.toast(title: "no cache image found")
            }
        }
        
        var btn = UIButton.init(frame: CGRect.zero)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.leading).offset(50)
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        btn.backgroundColor = UIColor.lightGray
        btn.setTitle("relad", for: .normal)
        btn.addTarget(self, action: #selector(reload), for: .touchUpInside)
        
        btn = UIButton.init(frame: CGRect.zero)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.trailing.equalTo(self.view.snp.trailing).offset(-50)
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        btn.backgroundColor = UIColor.lightGray
        btn.setTitle("clear", for: .normal)
        btn.addTarget(self, action: #selector(clear), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ImageCacheManager.getDiskCost { value in
            molog.debug("\(value)")
        }
    }
    
    @objc func reload() {
        self.imageView.setImage(url: self.url, size: CGSize(width: 300, height: 300), cornerRadius: 4.0)
    }
    
    @objc func clear() {
        ImageCacheManager.removeImage(forKey: self.url, type: .all)
        self.imageView.image = nil
    }
}
