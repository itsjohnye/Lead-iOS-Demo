//
//  MoreViewController.swift
//  Lead
//
//  Created by Ye on 2018/6/1.
//  Copyright © 2018 Ye. All rights reserved.
//

import UIKit
import Eureka
import SafariServices
import MessageUI


//init ActionRow
public final class ActionRow: _LabelRow, RowType {
    
    public required init(tag: String?) {
        super.init(tag: tag)
    }
    
    public override func updateCell() {
        super.updateCell()
        cell.selectionStyle = .default
        cell.accessoryType = .disclosureIndicator
    }
    
    public override func didSelect() {
        super.didSelect()
        cell.setSelected(false, animated: true)
    }
    
}

class MoreViewController: FormViewController, SFSafariViewControllerDelegate, MFMailComposeViewControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section()
            <<< ActionRow(){
                $0.title = NSLocalizedString("User guide", comment: "")
                }.onCellSelection ({(cell, row) in
                    let urs = "https://github.com/shadowsocks/shadowsocks/wiki/Shadowsocks-%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E"
                    let url:URL? = URL.init(string: urs)
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url!)
                    }
                })
            
            +++ Section()
            <<< ActionRow(){
                $0.title = NSLocalizedString("Share to friends", comment: "")
                }.onCellSelection({ [unowned self] (cell, row) -> () in
                    var shareItems: [AnyObject] = [self]
                    shareItems.append("Lead: https://itunes.apple.com/" as AnyObject)
                    shareItems.append(UIImage(named: "AppIcon60x60")!)
                    let shareVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
                    if let presenter = shareVC.popoverPresentationController {
                        presenter.sourceView = cell
                        presenter.sourceRect = cell.bounds
                    }
                    self.present(shareVC, animated: true, completion: nil)
                })
            
            <<< ActionRow(){
                $0.title = NSLocalizedString("Feedback", comment: "")
                }.onCellSelection ({(cell, row) in
                    
                    if MFMailComposeViewController.canSendMail() {
                        let composer = MFMailComposeViewController()
                        composer.mailComposeDelegate = self
                        composer.setToRecipients(["itsjohnye@gmail.com"])
                        let currentDevice = UIDevice.current
                        var body = [String]()
                        body.append("")
                        body.append("-")
                        body.append("System info: ")
                        body.append(currentDevice.systemName)
                        body.append(currentDevice.systemVersion)
                        body.append(currentDevice.model)
                        composer.setMessageBody(body.joined(separator: "\r\n"), isHTML: false)
                        self.present(composer, animated: true, completion: nil)
                    } else {
                        let urs = "mailto://itsjohnye@gmail.com"
                        let url:URL? = URL.init(string: urs)
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url!)
                        }
                    }
                })
            
            <<< ActionRow(){
                $0.title = NSLocalizedString("Rate on App Store", comment: "")
                }.onCellSelection({ (cell, row) in
                    let urs="itms-apps://itunes.apple.com/"
                    let url:URL?=URL.init(string: urs)
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url!)
                    }
                })
            
            +++ Section(footer: "Copyright © 2018 Ye. All rights reserved.")
            <<< LabelRow() {
                $0.title = NSLocalizedString("Version", comment: "")
                $0.value = "V 1.0.0"
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // UIActivityItemSource
    
    @objc func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: String) -> Any? {
        if activityType.contains("com.tencent") {
            return "Lead iOS: https://github.com/itsjohnye"
        }
        return "Lead: https://itunes.apple.com/"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: String?) -> String {
        return "Lead"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: String!, suggestedSize size: CGSize) -> UIImage! {
        return UIImage(named: "AppIcon60x60")
    }
    
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
