//
//  ViewController.swift
//  Lead
//
//  Created by Ye on 2018/5/31.
//  Copyright © 2018 Ye. All rights reserved.
//

import UIKit
import NetworkExtension
import SnapKit
import SideMenu
import SCLAlertView


//warning setting
let emptyConfigWarning = NSLocalizedString("Please set the Configuration at first", comment: "")
let emptyAddressWarning = NSLocalizedString("Please enter the Address", comment: "")
let emptyPortWarning = NSLocalizedString("Please enter the Port", comment: "")
let emptyMethodWarning = NSLocalizedString("Please select a Method", comment: "")
let emptyPasswordWarning = NSLocalizedString("Please enter the Password", comment: "")
let alerViewAppearance = SCLAlertView.SCLAppearance(
    kDefaultShadowOpacity: 0.78,
    kTitleTop:45,
    kTextHeight: 0,
    kTextViewdHeight:0,
    kTitleFont: UIFont(name: "Avenir-Black", size: 20)!,
    kTextFont: UIFont(name: "Avenir-Light", size: 0)!,
    kButtonFont: UIFont(name: "Avenir-Black", size: 18)!,
    showCloseButton: true,
    fieldCornerRadius: 20,
    buttonCornerRadius: 20
)

class HomeViewController: UIViewController {
 
    let commentLabel = UILabel()  //"点击添加“标签
    let connectButton = UIButton() //“链接”按钮
    let connectButtonView = ConnectButtonView()
    let ssLogoView = SSlogoView()
    let configLabel = UILabel()
    let rippleView = RippleView()
    
    //监听状态
    var status: VPNStatus {
        didSet(o) {
            updateConnectButton()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.status = .off
        NotificationCenter.default.addObserver(self, selector: #selector(onVPNStatusChanged), name: NSNotification.Name(rawValue: kProxyServiceVPNStatusNotification), object: nil)
    }
    //反初始化，释放实例
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //设置gradient背景色
        view.setGradientBackground(topColor:Colors.lightBlue,bottomColor: Colors.deepBlue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.sleep(forTimeInterval: 2.0) //启动延长2秒，看LaunchScreen
        
        //网络状态监测
        let reachability = Reachability()!
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        setUI()
    }
    
    func setUI(){
        
        //rippleView
        rippleView.frame = self.view.frame
        self.view.addSubview(rippleView)
        
        let wavesView = WavesView()  //在下面snp中设置constrains
        self.view.addSubview(wavesView)
        wavesView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.height.equalTo(38)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        //小飞机
        self.view.addSubview(ssLogoView)
        ssLogoView.snp.makeConstraints { (make) in
            make.size.equalTo(60)
            make.top.equalTo(view).offset(145)
            make.rightMargin.equalTo(-80)
        }
        
        
        configLabel.text = NSLocalizedString("Configuration", comment: "")
        configLabel.textColor = UIColor.white
        configLabel.backgroundColor = UIColor.clear
        configLabel.textAlignment = .center
        configLabel.font = UIFont.boldSystemFont(ofSize: 28)
        configLabel.adjustsFontSizeToFitWidth = true //当文字超出标签宽度时，自动调整文字大小，使其不被截断
        self.view.addSubview(configLabel)
        configLabel.snp.makeConstraints { (make) in
            make.height.equalTo(28)
            make.width.equalTo(125)
            make.bottomMargin.equalTo(wavesView).offset(-43)
            make.centerX.equalTo(view)
        }
        
        commentLabel.text = NSLocalizedString("Click", comment: "")
        commentLabel.textColor = UIColor.white
        commentLabel.backgroundColor = UIColor.clear
        commentLabel.textAlignment = .center
        commentLabel.font = UIFont.systemFont(ofSize: 17.5, weight: .light)
        commentLabel.adjustsFontSizeToFitWidth = true //当文字超出标签宽度时，自动调整文字大小，使其不被截断
        self.view.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25)
            make.width.equalTo(100)
            make.topMargin.equalTo(wavesView).offset(36)
            make.centerX.equalTo(view)
        }
        updateCommentLabel()
        
        
        let menuButton = UIButton()
        menuButton.setImage(UIImage(named: "menu"), for: .normal)
        menuButton.addTarget(self, action: #selector(sideMenuButtonTapped), for: .touchUpInside)
        self.view.addSubview(menuButton)
        menuButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(32)
            make.topMargin.equalTo(45)
            make.leftMargin.equalTo(33)
        }
        prepareSideMenuView()
        
        //connectButtonView
        connectButtonView.backgroundColor = UIColor.clear
        self.view.addSubview(connectButtonView)
        connectButtonView.snp.makeConstraints { (make) in
            make.size.equalTo(112)
            make.bottomMargin.equalTo(-66)
            make.centerX.equalTo(view)
        }
        
        //链接按钮
        connectButton.setTitle(NSLocalizedString("Connect", comment: ""), for: .normal)
        connectButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        connectButton.setTitleColor(UIColor.white, for: .normal)
        connectButton.titleLabel?.adjustsFontSizeToFitWidth = true
        connectButton.backgroundColor = UIColor.clear
        connectButton.setBackgroundImage(UIImage(named: "triple"), for: .normal)
        connectButton.addTarget(self, action: #selector(connectButtonTapped), for: .touchUpInside)
        self.view.addSubview(connectButton)
        connectButton.snp.makeConstraints { (make) in
            make.size.equalTo(80)
            make.center.equalTo(connectButtonView)
        }
        
        //配置按钮的视图
        let settingConfiguration = UIButton()
        settingConfiguration.backgroundColor = UIColor.clear
        settingConfiguration.addTarget(self, action: #selector(goToSecondView), for: .touchUpInside)
        self.view.addSubview(settingConfiguration)
        settingConfiguration.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.size.equalTo(120)
        }

    }
    
    //定义SideMenu视图,SideMenu库
    func prepareSideMenuView(){
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        // (Optional) Prevent status bar area from turning black when menu appears:
        SideMenuManager.default.menuFadeStatusBar = false
        //自定义
        SideMenuManager.default.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuWidth = max(round(min((UIScreen.main.bounds.width), (UIScreen.main.bounds.height)) * 0.75), 240)  //屏幕的0.75比例
    }
    
    //第二视图
    @objc func goToSecondView(sender: UIButton!) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let svc = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.present(svc, animated: true, completion: nil)
        
    }
    
    //SideMenu按键
    @objc func sideMenuButtonTapped(sender: AnyObject){
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    //连接按钮点击
    @objc func connectButtonTapped() {
        buttonViewRotaion()
        print("connect tap")
        let address = UserDefaults.standard.string(forKey: "address")
        if address == nil {
            //warning
            let alert = SCLAlertView(appearance: alerViewAppearance)
            alert.showWarning(emptyConfigWarning, subTitle: "", closeButtonTitle: NSLocalizedString("OK", comment: ""), colorStyle: 0xFFC107, colorTextButton: 0xFFFFFF, circleIconImage: UIImage(named: "warning"))
        } else {
            //开关
            if(VpnManager.shared.vpnStatus == .off){
                VpnManager.shared.connect()
                plantTakesOff()
            }else{
                VpnManager.shared.disconnect()
            }
        }
    }
    
    func buttonViewRotaion(){
        //Trick: start rotating with 180 degrees first and then rotate with 360 degrees. Use 2 animations with delay. In order to make it smooth, the delay for the second "animateWithDuration" needs to be half the size of the animation duration.
        UIView.animate(withDuration: 0.5) {
            self.connectButtonView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        UIView.animate(withDuration: 0.5, delay: 0.25, options:.curveEaseInOut, animations: {
            self.connectButtonView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
    }
    
    //更新配置标签
    func updateCommentLabel(){
        let address = UserDefaults.standard.string(forKey: "address")
        let comment = UserDefaults.standard.string(forKey: "comment")
        if address == nil {     //必须是nil，初始化时显示。之后是必填
            self.commentLabel.text = NSLocalizedString("Click", comment: "")
            return
        } else {
            if comment == "" {
                self.commentLabel.text = NSLocalizedString("Configured", comment: "")
            }else{
                self.commentLabel.text = comment
            }
        }
    }
    
    //按钮状态
    @objc func onVPNStatusChanged(){
        self.status = VpnManager.shared.vpnStatus
    }
    
    func updateConnectButton(){
        switch status {
        case .connecting:
            connectButton.setTitle(NSLocalizedString("Connecting", comment: ""), for: UIControl.State())
        case .disconnecting:
            connectButton.setTitle(NSLocalizedString("Disconnecting", comment: ""), for: UIControl.State())
        case .on:
            connectButton.setTitle(NSLocalizedString("Connected", comment: ""), for: UIControl.State())
        case .off:
            connectButton.setTitle(NSLocalizedString("Disconnect", comment: ""), for: UIControl.State())
        }
        connectButton.isEnabled = [VPNStatus.on,VPNStatus.off].contains(VpnManager.shared.vpnStatus)
    }
    
    //飞机起飞
    @objc func plantTakesOff(){
        let originalCenter = ssLogoView.center
        UIView.animateKeyframes(withDuration: 1.5, delay: 1, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                self.ssLogoView.center.x += 80.0
                self.ssLogoView.center.y -= 10.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.ssLogoView.center.x += 100.0
                self.ssLogoView.center.y -= 50
                self.ssLogoView.alpha = 0.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4, animations: {
                self.ssLogoView.transform = CGAffineTransform(rotationAngle: -.pi/8)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01, animations: {
                self.ssLogoView.transform = CGAffineTransform.identity
                self.ssLogoView.center = CGPoint(x: 0, y: originalCenter.y)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45, animations: {
                self.ssLogoView.alpha = 1.0
                self.ssLogoView.center = originalCenter
            })
        }, completion: nil)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCommentLabel()
        self.status = VpnManager.shared.vpnStatus   //改变状态
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
    
