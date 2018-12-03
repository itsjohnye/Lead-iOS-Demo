//
//  SSlogo.swift
//  Lead
//
//  Created by Ye on 2018/11/20.
//  Copyright © 2018 Ye. All rights reserved.



import UIKit

public class SSlogo : NSObject {

    //// Drawing Methods

    @objc dynamic public class func drawSSlogo(frame: CGRect = CGRect(x: 27, y: 13, width: 189, height: 184)) {
        //// Color Declarations
        let fillColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.96966 * frame.width, y: frame.minY + 0.02899 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.80035 * frame.width, y: frame.minY + 0.75942 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.44409 * frame.width, y: frame.minY + 0.65072 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.80035 * frame.width, y: frame.minY + 0.75942 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.53933 * frame.width, y: frame.minY + 0.68333 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.75450 * frame.width, y: frame.minY + 0.26232 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.32416 * frame.width, y: frame.minY + 0.61159 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.03704 * frame.width, y: frame.minY + 0.51449 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.96966 * frame.width, y: frame.minY + 0.02899 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.44621 * frame.width, y: frame.minY + 0.73406 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.55485 * frame.width, y: frame.minY + 0.77029 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.44268 * frame.width, y: frame.minY + 0.94203 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.44621 * frame.width, y: frame.minY + 0.73406 * frame.height))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()
    }

}
