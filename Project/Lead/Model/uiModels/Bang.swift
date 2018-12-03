//
//  Bang.swift
//  Lead
//
//  Created by Ye on 2018/11/6.
//  Copyright © 2018 Ye. All rights reserved.



import UIKit

public class Bang : NSObject {

    //// Drawing Methods

    @objc dynamic public class func drawBang(frame: CGRect = CGRect(x: 207, y: 226, width: 207, height: 670)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        //// Color Declarations
        let grayColor2 = UIColor(red: 0.874, green: 0.874, blue: 0.874, alpha: 1.000)

        //// Gradient Declarations
        let gray = CGGradient(colorsSpace: nil, colors: [grayColor2.cgColor, UIColor.white.cgColor] as CFArray, locations: [0, 1])!

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.00000 * frame.width, y: frame.minY + 0.00000 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.45894 * frame.width, y: frame.minY + 0.08358 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.00000 * frame.width, y: frame.minY + 0.00000 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.33333 * frame.width, y: frame.minY + 0.04030 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.69082 * frame.width, y: frame.minY + 0.31493 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.59035 * frame.width, y: frame.minY + 0.12887 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.65753 * frame.width, y: frame.minY + 0.16240 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.69101 * frame.width, y: frame.minY + 0.84179 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.72411 * frame.width, y: frame.minY + 0.46745 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.69101 * frame.width, y: frame.minY + 0.84179 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.99518 * frame.width, y: frame.minY + 0.84179 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 1.00000 * frame.width, y: frame.minY + 0.00000 * frame.height))
        context.saveGState()
        bezierPath.addClip()
        let bezierBounds: CGRect = bezierPath.cgPath.boundingBoxOfPath
        context.drawLinearGradient(gray,
            start: CGPoint(x: bezierBounds.midX + 103.55 * bezierBounds.width / 207, y: bezierBounds.midY + -282 * bezierBounds.height / 564),
            end: CGPoint(x: bezierBounds.midX + 43 * bezierBounds.width / 207, y: bezierBounds.midY + 282.73 * bezierBounds.height / 564),
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context.restoreGState()
    }

}
