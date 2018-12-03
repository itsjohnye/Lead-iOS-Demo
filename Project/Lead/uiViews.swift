//
//  wavesView.swift
//  UI
//
//  Created by Ye on 2018/10/24.
//  Copyright © 2018 Ye. All rights reserved.
//

import UIKit

//RippleView
class RippleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            let location = t.location(in: self)
            
            //RIPPLE BORDER
            rippleBorder(location:location, color: UIColor.white)
        }
    }
    
}

class WavesView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        Waves.drawWaves(frame: self.bounds)  //必须要加frame：self.bounds，否则是Paintcode中画布的视图
    }
}


class ConnectButtonView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        ConnectButton.drawConnectButton(frame: self.bounds) //必须要加frame：self.bounds，否则是Paintcode中画布的视图
    }
}


class SSlogoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        SSlogo.drawSSlogo(frame: self.bounds) //必须要加frame：self.bounds，否则是Paintcode中画布的视图
    }
}


class BangView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        Bang.drawBang(frame: self.bounds) //必须要加frame：self.bounds，否则是Paintcode中画布的视图
    }
}



