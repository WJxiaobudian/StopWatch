//
//  SystemDefine.swift
//  StopWatchSwift
//
//  Created by 王洁 on 2018/5/7.
//  Copyright © 2018年 WJ. All rights reserved.
//

import Foundation

let IS_iOS8 = (UIDevice.current.systemVersion as NSString).floatValue >= 8.0
let IS_iOS9 = (UIDevice.current.systemVersion as NSString).floatValue >= 9.0
let IS_iOS11 = (UIDevice.current.systemVersion as NSString).floatValue >= 11.0
let ISRETINA = UIScreen.main.scale > 1

let kDevice_Is_iPhoneX = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), (UIScreen.main.currentMode?.size)!) : false)

let HEIGHT_STATUSBAR = ((kDevice_Is_iPhoneX) ? 44.0 : 22.0)

let HEIGHT_NAVBAR = (HEIGHT_STATUSBAR + 44.0)
func ORIGINX(view:UIView) -> CGFloat {
    return view.frame.origin.x
}
func ORIGINY(view:UIView) -> CGFloat {
    return view.frame.origin.y
}
func WIDTH(view:UIView) -> CGFloat {
    return view.frame.size.width
}
func HEIGHT(view:UIView) -> CGFloat {
    return view.frame.size.height
}
let kScreenSize = UIScreen.main.bounds.size
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

func kScaleWidth(width:CGFloat) -> CGFloat {
    return ((width) * kScreenWidth/320)
}
//func kScaleHeight(height:CGFloat) -> CGFloat {
//    return (kIphone)
//}









