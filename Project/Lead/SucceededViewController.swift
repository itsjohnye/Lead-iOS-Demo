//
//  SucceededViewController.swift
//  UI
//
//  Created by Ye on 2018/11/13.
//  Copyright © 2018 Ye. All rights reserved.
//

import UIKit
import SnapKit

class SucceededViewController: UIViewController {
    
    let succeededLabel = UILabel()
    let checkView = UIImageView()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //设置gradient背景色
        view.setGradientBackground(topColor:Colors.lightBlue,bottomColor: Colors.deepBlue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let wavesView = WavesView()
        self.view.addSubview(wavesView)
        wavesView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.height.equalTo(38)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
    
        succeededLabel.text = NSLocalizedString("Configured!", comment: "")
        succeededLabel.textColor = UIColor.white
        succeededLabel.backgroundColor = UIColor.clear
        succeededLabel.textAlignment = .center
        succeededLabel.font = UIFont.boldSystemFont(ofSize: 24)
        succeededLabel.adjustsFontSizeToFitWidth = true //当文字超出标签宽度时，自动调整文字大小，使其不被截断
        self.view.addSubview(succeededLabel)
        succeededLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.height.equalTo(50)
            make.width.equalTo(120)
            make.centerX.equalTo(view)
            
        }
        
        checkView.backgroundColor = UIColor.clear
        checkView.image = UIImage(named:"check")
        self.view.addSubview(checkView)
        checkView.snp.makeConstraints { (make) in
            make.size.equalTo(115)
            make.centerX.equalTo(view)
            make.top.equalTo(succeededLabel.snp.bottom).offset(48)
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkView.alpha = 0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.57, delay: 0, options: .curveEaseInOut, animations: {
            self.checkView.alpha = 1
        })
    }
   
    
}
