//
//  Constants.swift
//  Lead
//
//  Created by Ye on 2018/10/14.
//  Copyright © 2018 Ye. All rights reserved.


import Foundation
import UIKit

//Constrains
struct Colors {
    static let white = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    static let lightBlue = UIColor(red: 92/255.0, green: 233/255.0, blue: 255/255.0, alpha: 1.0)
    static let deepBlue = UIColor(red: 82/255.0, green: 177/255.0, blue: 255/255.0, alpha: 1.0)
    static let amber = UIColor(red: 255/255.0, green: 193/255.0, blue: 7/255.0, alpha: 1.0)
}

//UIView+extension
extension UIView {
    
    func setGradientBackground(topColor:UIColor,bottomColor:UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.locations = [0.0, 1.0]               //设置背景比例
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    

}
