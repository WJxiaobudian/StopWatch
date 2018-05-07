//
//  SystemDefine.h
//  StopWatchSwift
//
//  Created by 王洁 on 2018/5/7.
//  Copyright © 2018年 WJ. All rights reserved.
//

#ifndef SystemDefine_h
#define SystemDefine_h

//最低支持IOS9及以上
//是否iOS8
#define IS_iOS8 ([UIDevice currentDevice].systemVersion.floatValue>=8.0)
//是否iOS9
#define IS_iOS9 ([UIDevice currentDevice].systemVersion.floatValue>=9.0)
//是否iOS11
#define IS_iOS11 ([UIDevice currentDevice].systemVersion.floatValue>=11.0)
//是否高清屏
#define ISRETINA  ([UIScreen mainScreen].scale >1)

//是否iphone5
//#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6
//#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6+
//#define kDevice_Is_iPhone6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iphone X
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define HEIGHT_NAVBAR                   (HEIGHT_STATUSBAR+44.0)
#define HEIGHT_STATUSBAR                ((kDevice_Is_iPhoneX)?44.0:20.0)

#define ORIGINX(view)                   (view.frame.origin.x)
#define ORIGINY(view)                   (view.frame.origin.y)
#define WIDTH(view)                     (view.bounds.size.width)
#define HEIGHT(view)                    (view.bounds.size.height)

#define kScreenSize           [[UIScreen mainScreen] bounds].size                 //(e.g. 320,480)
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height          //(e.g. 480)

#define kScaleWidth(width)      ((width)*kScreenWidth)/320     //宽度按比例适配
#define kScaleHeight(height)   (kIphone4?(height):((height)*kScreenHeight)/568)    //高度按比例适配

#define kApplicationSize      [[UIScreen mainScreen] applicationFrame].size       //(e.g. 320,460)
#define kApplicationWidth     [[UIScreen mainScreen] applicationFrame].size.width //(e.g. 320)
#define kApplicationHeight    [[UIScreen mainScreen] applicationFrame].size.height//不包含状态bar的高度(e.g. 460)

#define kIOS7OffHeight (kIOSVersions>=7.0 ? 64 : 0)
#define kStatusBarHeight         20
#define kNavigationBarHeight     44
#define kNavigationheightForIOS7 64
#define kContentHeight           (kApplicationHeight - kNavigationBarHeight)
#define kTabBarHeight            49
#define kSeekTabBarHeight (kIOSVersions>=7.0 ? 0 : 49)

#endif /* SystemDefine_h */


