//
//  SecondViewController.swift
//  UI
//
//  Created by Ye on 2018/11/6.
//  Copyright © 2018 Ye. All rights reserved.
//

import UIKit
import SnapKit
import TextFieldEffects
import SCLAlertView


class SecondViewController: UIViewController, UITextFieldDelegate {

    let bangView = BangView()
    let stepIndicatorView = StepIndicatorView()  //步骤指示
    //初始化在viewDidLoad前，对应键盘收回和snp的updateConstraints动画
    let peizhiLabel = UILabel()  //配置
    let typeLabel = UILabel()  //代理类型
    let typeButton = UIButton()  //ss
    let methodLabel = UILabel()  //加密方法
    let methodButton = UIButton()  //RC4MD5
    
    let addressTextField = HoshiTextField()
    let portTextField = HoshiTextField()
    let passwordTextField = HoshiTextField()
    let commentTextField = HoshiTextField()
    let nextStepButton = UIButton() //下一步按钮
    let previousStepButton = UIButton() //上一步按钮
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dismiss keyboard
        let tapper = UITapGestureRecognizer(target: self, action:#selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapper)
        //圆弧背景
        
        self.view.addSubview(bangView)
        bangView.snp.makeConstraints { (make) in
            make.right.equalTo(view)
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view.snp.centerX)
        }
        
        //取消键
        let cancelButton = UIButton()
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.setImage(UIImage(named: "cancel"), for:.normal)
        self.view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.size.equalTo(32)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(15)
        }
        cancelButton.addTarget(self, action:#selector(cancel), for: .touchUpInside)
        
        //Labels
        peizhiLabel.text = NSLocalizedString("Configuration", comment: "")
        peizhiLabel.textColor = UIColor.gray
        peizhiLabel.backgroundColor = UIColor.clear
        peizhiLabel.textAlignment = .left
        peizhiLabel.font = UIFont.boldSystemFont(ofSize: 23)
        peizhiLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(peizhiLabel)
        peizhiLabel.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(85)
            make.left.equalTo(50)
            make.top.equalTo(cancelButton.snp.bottom).offset(30)
        }
        
        typeLabel.text = NSLocalizedString("Proxy type", comment: "")
        typeLabel.textColor = UIColor.darkGray
        typeLabel.backgroundColor = UIColor.clear
        typeLabel.textAlignment = .left
        typeLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.view.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(85)
            make.left.equalTo(50)
            make.top.equalTo(peizhiLabel.snp.bottom).offset(20)
        }
        
        typeButton.setTitle("Shadowsocks", for: .normal)
        typeButton.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight:.medium)
        typeButton.setTitleColor(UIColor.lightGray, for: .normal)
        typeButton.layer.borderColor = UIColor.lightGray.cgColor
        typeButton.layer.borderWidth = 1.2
        typeButton.layer.cornerRadius = 7
        self.view.addSubview(typeButton)
        typeButton.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.height.equalTo(31)
            make.width.equalTo(210)
            make.top.equalTo(typeLabel.snp.bottom).offset(5)
        }
        
        //地址栏配置
        addressTextField.placeholder = NSLocalizedString("Address", comment: "")
        addressTextField.placeholderColor = UIColor.darkGray
        addressTextField.placeholderFontScale = 0.85
        addressTextField.borderActiveColor = Colors.deepBlue
        addressTextField.borderInactiveColor = .gray
        addressTextField.keyboardAppearance = .light
        addressTextField.keyboardType = .decimalPad
        addressTextField.delegate = self
        addressTextField.clearButtonMode = .whileEditing
        addressTextField.autocorrectionType = UITextAutocorrectionType.no
        addressTextField.text = UserDefaults.standard.string(forKey: "address") ?? ""
        self.view.addSubview(addressTextField)
        addressTextField.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.top.equalTo(typeButton.snp.bottom).offset(38)
            make.height.equalTo(60)
            make.width.equalTo(210)
        }
        
        //端口栏配置
        portTextField.placeholder = NSLocalizedString("Prot", comment: "")
        portTextField.placeholderColor = UIColor.darkGray
        portTextField.placeholderFontScale = 0.85
        portTextField.borderActiveColor = Colors.deepBlue
        portTextField.borderInactiveColor = .gray
        portTextField.delegate = self
        portTextField.clearButtonMode = .whileEditing
        portTextField.keyboardType = .decimalPad
        portTextField.autocorrectionType = UITextAutocorrectionType.no
        portTextField.text = UserDefaults.standard.string(forKey: "port") ?? ""
        self.view.addSubview(portTextField)
        portTextField.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.height.equalTo(60)
            make.width.equalTo(210)
            make.top.equalTo(addressTextField.snp.bottom).offset(42)
        }
        
        //加密方法
        methodLabel.text = NSLocalizedString("Method", comment: "")
        methodLabel.textColor = UIColor.darkGray
        methodLabel.backgroundColor = UIColor.clear
        methodLabel.textAlignment = .left
        methodLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.view.addSubview(methodLabel)
        methodLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(85)
            make.left.equalTo(-300)  //隐藏
            make.top.equalTo(peizhiLabel.snp.bottom).offset(20)
        }
        
        if UserDefaults.standard.string(forKey: "method") == nil {
            methodButton.setTitle(NSLocalizedString("Please select a Method", comment: ""), for: .normal)
            methodButton.setTitleColor(UIColor.lightGray, for: .normal)
        } else {
            let method = UserDefaults.standard.string(forKey: "method")
            methodButton.setTitle(method, for: .normal)
            methodButton.setTitleColor(UIColor.black, for: .normal)
        }
        methodButton.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight:.medium)
        methodButton.layer.borderColor = UIColor.lightGray.cgColor
        methodButton.layer.borderWidth = 1.2
        methodButton.layer.cornerRadius = 7
        methodButton.addTarget(self, action: #selector(selectMethod),for:.touchUpInside)
        self.view.addSubview(methodButton)
        methodButton.snp.makeConstraints { (make) in
            make.left.equalTo(-300)  //隐藏
            make.height.equalTo(31)
            make.width.equalTo(210)
            make.top.equalTo(methodLabel.snp.bottom).offset(5)
        }
 
        //密码栏
        passwordTextField.placeholder = NSLocalizedString("Password", comment: "")
        passwordTextField.placeholderColor = UIColor.darkGray
        passwordTextField.placeholderFontScale = 0.85
        passwordTextField.borderActiveColor = Colors.deepBlue
        passwordTextField.borderInactiveColor = .gray
        passwordTextField.clearButtonMode = .never
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.isSecureTextEntry = true
        
        //密码是否可见
        let rightView = UIButton(frame: CGRect(x:0, y:0, width:23, height:23))
        rightView.addTarget(self, action: #selector(changeSecureTextEntry), for: .touchUpInside)
        rightView.setImage(UIImage(named: "eye"), for: .normal)
        passwordTextField.rightView = rightView
        passwordTextField.rightViewMode = .whileEditing
        passwordTextField.delegate = self
        passwordTextField.text = UserDefaults.standard.string(forKey: "password") ?? ""
        self.view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(-300)  //隐藏
            make.top.equalTo(methodButton.snp.bottom).offset(38)
            make.height.equalTo(60)
            make.width.equalTo(210)
        }
        
        //备注栏
        commentTextField.placeholder = NSLocalizedString("Comment(optinal)", comment: "")
        commentTextField.placeholderColor = UIColor.darkGray
        commentTextField.placeholderFontScale = 0.85
        commentTextField.borderActiveColor = Colors.deepBlue
        commentTextField.clearButtonMode = .whileEditing
        commentTextField.autocorrectionType = UITextAutocorrectionType.no
        commentTextField.borderInactiveColor = .gray
        commentTextField.delegate = self
        commentTextField.text = UserDefaults.standard.string(forKey: "comment") ?? ""
        self.view.addSubview(commentTextField)
        commentTextField.snp.makeConstraints { (make) in
            make.left.equalTo(-300)  //隐藏
            make.height.equalTo(60)
            make.width.equalTo(210)
            make.top.equalTo(passwordTextField.snp.bottom).offset(42)
        }
        
        //步骤指示的设置
        stepIndicatorView.frame = CGRect(x:0, y: 0, width: 0, height: 190)  //width没有影响，height调整视图的高
        // self.stepIndicatorView.backgroundColor = UIColor.clear
        stepIndicatorView.numberOfSteps = 2
        stepIndicatorView.currentStep = 0
        stepIndicatorView.circleColor = Colors.amber  //外圈
        stepIndicatorView.circleTintColor = Colors.amber  //里点颜色
        stepIndicatorView.circleStrokeWidth = 2.0
        stepIndicatorView.circleRadius = 13.0  //圈大小
        stepIndicatorView.lineColor = UIColor.lightGray
        stepIndicatorView.lineTintColor = UIColor.orange
        stepIndicatorView.lineMargin = 8.0
        stepIndicatorView.lineStrokeWidth = 0
        stepIndicatorView.displayNumbers = false //indicates if it displays numbers at the center instead of the core circle
        stepIndicatorView.direction = .topToBottom //four directions
        bangView.addSubview(stepIndicatorView)
        stepIndicatorView.snp.makeConstraints { (make) in
            make.centerY.equalTo(bangView).offset(-190)
            make.centerX.equalTo(bangView).multipliedBy(1.38164251)
        }
        
        
        //下一步按钮
        nextStepButton.backgroundColor = UIColor.clear
        nextStepButton.setBackgroundImage(UIImage(named: "next"), for:.normal)
        nextStepButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        self.view.addSubview(nextStepButton)
        nextStepButton.snp.makeConstraints { (make) in
            make.size.equalTo(66)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-88)
            make.right.equalTo(-38)
        }
        
        //上一步按钮
        previousStepButton.backgroundColor = UIColor.clear
        previousStepButton.setImage(UIImage(named: "back"), for:.normal)
        previousStepButton.addTarget(self, action: #selector(previousStep), for: .touchUpInside)
        self.view.addSubview(previousStepButton)
        previousStepButton.snp.makeConstraints { (make) in
            make.size.equalTo(42)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-100)
            make.left.equalTo(-300)  //隐藏
        }
        
        
        //在键盘上添加“完成“按钮
        addDoneButtonOnKeyboard()
    }
    
    //method选择
    @objc func selectMethod(sender: AnyObject){
        
        let methodSelected = UIAlertController(title: nil, message: NSLocalizedString("Please select a Method", comment: ""), preferredStyle: .actionSheet)
        
        methodSelected.addAction(UIAlertAction(title: "RC4MD5", style: .default , handler:{ (UIAlertAction)in
            self.methodButton.setTitle("RC4MD5", for: .normal)
            self.methodButton.setTitleColor(UIColor.black, for: .normal)
            //保存method到UserDefaults
            let method:String = self.methodButton.title(for: .normal)!
            UserDefaults.standard.set(method,forKey: "method")
        }))
        methodSelected.addAction(UIAlertAction(title: "SALSA20", style: .default , handler:{ (UIAlertAction)in
            self.methodButton.setTitle("SALSA20", for: .normal)
            self.methodButton.setTitleColor(UIColor.black, for: .normal)
            //保存method到UserDefaults
            let method:String = self.methodButton.title(for: .normal)!
            UserDefaults.standard.set(method,forKey: "method")
        }))
        methodSelected.addAction(UIAlertAction(title: "CHACHA20", style: .default , handler:{ (UIAlertAction)in
            self.methodButton.setTitle("CHACHA20", for: .normal)
            self.methodButton.setTitleColor(UIColor.black, for: .normal)
            //保存method到UserDefaults
            let method:String = self.methodButton.title(for: .normal)!
            UserDefaults.standard.set(method,forKey: "method")
        }))
        methodSelected.addAction(UIAlertAction(title: "AES128CFB", style: .default , handler:{ (UIAlertAction)in
            self.methodButton.setTitle("AES128CFB", for: .normal)
            self.methodButton.setTitleColor(UIColor.black, for: .normal)
            //保存method到UserDefaults
            let method:String = self.methodButton.title(for: .normal)!
            UserDefaults.standard.set(method,forKey: "method")
        }))
        methodSelected.addAction(UIAlertAction(title: "AES192CFB", style: .default , handler:{ (UIAlertAction)in
            self.methodButton.setTitle("AES192CFB", for: .normal)
            self.methodButton.setTitleColor(UIColor.black, for: .normal)
            //保存method到UserDefaults
            let method:String = self.methodButton.title(for: .normal)!
            UserDefaults.standard.set(method,forKey: "method")
        }))
        methodSelected.addAction(UIAlertAction(title: "AES256CFB", style: .default , handler:{ (UIAlertAction)in
            self.methodButton.setTitle("AES256CFB", for: .normal)
            self.methodButton.setTitleColor(UIColor.black, for: .normal)
            //保存method到UserDefaults
            let method:String = self.methodButton.title(for: .normal)!
            UserDefaults.standard.set(method,forKey: "method")
        }))

        methodSelected.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler:nil))
        
        // On iPad, action sheets must be presented from a popover.
        methodSelected.popoverPresentationController?.sourceView = bangView
        
        self.present(methodSelected, animated: true, completion: nil)
    }
    
    
    
    //下一步操作
    @objc func nextStep(){
        if stepIndicatorView.currentStep == 0 {
            stepIndicatorView.currentStep += 1
            print(stepIndicatorView.currentStep)
            
            //out
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.typeLabel.snp.updateConstraints { make in
                    make.left.equalTo(-300)
                }
                self.typeButton.snp.updateConstraints({ (make) in
                    make.left.equalTo(-300)
                })
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
                self.addressTextField.snp.updateConstraints { make in
                    make.left.equalTo(-300)
                }
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
                self.portTextField.snp.updateConstraints { make in
                    make.left.equalTo(-300)
                }
                self.view.layoutIfNeeded()
            })
            
            //in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.methodLabel.snp.updateConstraints { make in
                    make.left.equalTo(50)
                }
                self.methodButton.snp.updateConstraints { make in
                    make.left.equalTo(50)
                }
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
                self.passwordTextField.snp.updateConstraints { make in
                    make.left.equalTo(50)
                }
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
                self.commentTextField.snp.updateConstraints { make in
                    make.left.equalTo(50)
                }
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.previousStepButton.snp.updateConstraints { make in
                    make.left.equalTo(42)
                }
                self.view.layoutIfNeeded()
            })
  
            
        } else if stepIndicatorView.currentStep == 1{
            
            //检查应填项目是否为空
            if (addressTextField.text?.isEmpty)! {
                let alert = SCLAlertView(appearance: alerViewAppearance)
                alert.showWarning(emptyAddressWarning, subTitle: "", closeButtonTitle: NSLocalizedString("OK", comment: ""), colorStyle: 0xFFC107, colorTextButton: 0xFFFFFF, circleIconImage: UIImage(named: "warning"))
            }
            else if (portTextField.text?.isEmpty)! {
                let alert = SCLAlertView(appearance: alerViewAppearance)
                alert.showWarning(emptyPortWarning, subTitle: "", closeButtonTitle:  NSLocalizedString("OK", comment: ""), colorStyle: 0xFFC107, colorTextButton: 0xFFFFFF, circleIconImage: UIImage(named: "warning"))
                
            }
            else if methodButton.currentTitle ==  NSLocalizedString("请选择加密方法", comment: "") {
                let alert = SCLAlertView(appearance: alerViewAppearance)
                alert.showWarning(emptyMethodWarning, subTitle: "", closeButtonTitle:  NSLocalizedString("OK", comment: ""), colorStyle: 0xFFC107, colorTextButton: 0xFFFFFF, circleIconImage: UIImage(named: "warning"))
            }
            else if (passwordTextField.text?.isEmpty)! {
                let alert = SCLAlertView(appearance: alerViewAppearance)
                alert.showWarning(emptyPasswordWarning, subTitle: "", closeButtonTitle:  NSLocalizedString("OK", comment: ""), colorStyle: 0xFFC107, colorTextButton: 0xFFFFFF, circleIconImage: UIImage(named: "warning"))
            }
            else {
                stepIndicatorView.currentStep += 1
                print(stepIndicatorView.currentStep)
                saveAction()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.goToSucceededView()
                })
            }
            
        } else {
            return print(stepIndicatorView.currentStep)
        }
    }
    //第三视图
    @objc func goToSucceededView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let succeededView = storyboard.instantiateViewController(withIdentifier: "SucceededViewController") as! SucceededViewController
        self.present(succeededView, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentingViewController?.dismiss(animated: false, completion: nil)  //取消第二视图，回到根视图
        }
        
    }
    
    //上一步操作
    @objc func previousStep(){
        if stepIndicatorView.currentStep == 1 || stepIndicatorView.currentStep == 2{
            stepIndicatorView.currentStep = 0
            print(stepIndicatorView.currentStep)
            
            //out
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
                self.methodLabel.snp.updateConstraints { make in
                    make.left.equalTo(-300)
                }
                self.methodButton.snp.updateConstraints { make in
                    make.left.equalTo(-300)
                }
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
                self.passwordTextField.snp.updateConstraints { make in
                    make.left.equalTo(-300)
                }
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
                self.commentTextField.snp.updateConstraints { make in
                    make.left.equalTo(-300)
                }
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.previousStepButton.snp.updateConstraints { make in
                    make.left.equalTo(-300)
                }
                self.view.layoutIfNeeded()
            })
            //in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.typeLabel.snp.updateConstraints { make in
                    make.left.equalTo(50)
                }
                self.typeButton.snp.updateConstraints({ (make) in
                    make.left.equalTo(50)
                })
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
                self.addressTextField.snp.updateConstraints { make in
                    make.left.equalTo(50)
                }
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
                self.portTextField.snp.updateConstraints { make in
                    make.left.equalTo(50)
                }
                self.view.layoutIfNeeded()
            })
            
        } else {
            return print(stepIndicatorView.currentStep)
        }
    }
    
    //保存
    @objc func saveAction() {
        
        let address:String = addressTextField.text!
        UserDefaults.standard.set(address,forKey: "address")
        
        let port:String = portTextField.text!
        UserDefaults.standard.set(port,forKey: "port")
        
        let password:String = passwordTextField.text!
        UserDefaults.standard.set(password,forKey: "password")
        
        let comment = commentTextField.text     //comment 可以为空
        UserDefaults.standard.set(comment, forKey: "comment")

    }
    //取消视图
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //键盘收起,和super.viewDidLoad()中的dismiss keyboard对应。
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        addressTextField.resignFirstResponder()
        portTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        commentTextField.resignFirstResponder()
        self.view.frame.origin.y = 0
    }
    
    //密码是否可见
    var iconClick = true
    @objc func changeSecureTextEntry(sender: UIButton){
        if(iconClick == true) {
            self.passwordTextField.isSecureTextEntry = false
        } else {
            self.passwordTextField.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    //在键盘上添加“完成“按钮
    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar()
        //左侧的空隙
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        //右侧的完成按钮
        let done: UIBarButtonItem = UIBarButtonItem(title:  NSLocalizedString("Done", comment: ""), style: .done,
                                                    target: self,
                                                    action: #selector(doneButtonAction))
        
        var items:[UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.addressTextField.inputAccessoryView = doneToolbar
        self.portTextField.inputAccessoryView = doneToolbar
        self.passwordTextField.inputAccessoryView = doneToolbar
        self.commentTextField.inputAccessoryView = doneToolbar
    }
    
    //“完成“按钮点击响应
    @objc func doneButtonAction() {
        //收起键盘
        self.addressTextField.resignFirstResponder()
        self.portTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.commentTextField.resignFirstResponder()
    }
   
    //TextFieldDelegate
    public func textFieldDidBeginEditing(_ textField:UITextField) {
        //view弹起跟随键盘，高可根据自己定义
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.frame.origin.y = -100
        })
        
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.frame.origin.y = 0
        })
        
    }
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.frame.origin.y = 0
        })
       return true
    }
}

