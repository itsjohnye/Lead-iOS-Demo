//
//  ConnectButton.swift
//  Lead
//
//  Created by Ye on 2018/11/20.
//  Copyright © 2018 Ye. All rights reserved.



import UIKit

public class ConnectButton : NSObject {

    //// Drawing Methods

    @objc dynamic public class func drawConnectButton(frame: CGRect = CGRect(x: 58, y: 25, width: 122, height: 116)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        // This non-generic function dramatically improves compilation times of complex expressions.
        func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }

        //// Color Declarations
        let strokeColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.656)
        let strokeColor2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.483)
        let fillColor2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.90459 * frame.width, y: frame.minY + 0.30839 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.41967 * frame.width, y: frame.minY + 0.93926 * frame.height), controlPoint1: CGPoint(x: frame.minX + 1.06696 * frame.width, y: frame.minY + 0.52705 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.81824 * frame.width, y: frame.minY + 0.93926 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.19442 * frame.width, y: frame.minY + 0.17631 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.02111 * frame.width, y: frame.minY + 0.93926 * frame.height), controlPoint2: CGPoint(x: frame.minX + -0.03082 * frame.width, y: frame.minY + 0.31582 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.90459 * frame.width, y: frame.minY + 0.30839 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.41967 * frame.width, y: frame.minY + 0.03681 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.74223 * frame.width, y: frame.minY + 0.08973 * frame.height))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()


        //// Oval Drawing
        context.saveGState()
        context.translateBy(x: frame.minX + 0.50614 * frame.width, y: frame.minY + 0.49296 * frame.height)
        context.rotate(by: -14 * CGFloat.pi/180)

        let ovalPath = UIBezierPath(ovalIn: CGRect(x: -48.94, y: -52.26, width: 97.89, height: 104.53))
        strokeColor2.setStroke()
        ovalPath.lineWidth = 2
        ovalPath.stroke()

        context.restoreGState()


        //// Oval 2 Drawing
        context.saveGState()
        context.setBlendMode(.luminosity)

        let oval2Path = UIBezierPath(ovalIn: CGRect(x: frame.minX + fastFloor((frame.width - 90) * 0.50000 + 0.5), y: frame.minY + fastFloor((frame.height - 85) * 0.48387 + 0.5), width: 90, height: 85))
        fillColor2.setFill()
        oval2Path.fill()

        context.restoreGState()
    }

}
