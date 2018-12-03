
## Lead
[![Swift Version](https://img.shields.io/badge/Swift Version-4.2-orange.svg)](https://docs.swift.org/swift-book/) [![GitHub license](https://img.shields.io/badge/Lisence-GPLv3-blue.svg)](LICENSE.md)
![](/images/header.png)

** - a featherweight iOS proxy with interactive UI.**

Lead is currently compatible with [Shadowsocks](https://shadowsocks.org/en/index.html).

For more information, see the demo vedio [URL](https://v.youku.com/v_show/id_XMzk0NDk5NjM2OA==.html?spm=a2h).

![](/images/sample.png)


### Todo List
- Other avaliable proxy types:
  - [ ] HTTP
  - [ ] HTTPS
  - [ ] ShadowsocksR

### Usage

This project needs an `Apple developer account` and must be run at a physical device.

1. In Terminal,
```
cd ~/your project path/
pod install
carthage update --no-use-binaries --platform ios
```

2. In Xcode,

>'PROJECT' -> 'TARGETS' -> 'Lead' ->'Signing', change the Signing with *'Yours'*.

>'PROJECT' -> 'TARGETS' -> 'PacketTunnel' ->'Signing', change the Signing with *'Yours'*.


3. Run it:

  -to test the UI, run it on the Simulator.

  -to test the VPN connection, run it on a real iOS device.

### Customizing

It is available to modify rules in NEKitRule.conf which is written by yaml.



### Credits
Show the respect to those open-source projects:
- [Eureka](https://github.com/xmartlabs/Eureka)
- [NEKit](https://github.com/zhuhaow/NEKit)
- [RabbitVpnDemo](https://github.com/yichengchen/RabbitVpnDemo)
- [Rechability](https://github.com/ashleymills/Reachability.swift)
- [SCLAlertView](https://github.com/vikmeup/SCLAlertView-Swift)
- [SideMenu](https://github.com/jonkykong/SideMenu)
- [Snapkit](https://github.com/SnapKit/SnapKit)
- [StepIndicator](https://github.com/chenyun122/StepIndicator)
- [TextFieldEffects](https://github.com/raulriera/TextFieldEffects)

### Lisence
Lead-iOS is published under the [GPLv3](LICENSE.md) license.
Copyright (c) 2018 itsjohnye, all right reserved.
