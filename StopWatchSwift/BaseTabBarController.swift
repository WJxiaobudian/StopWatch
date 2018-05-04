//
//  BaseTabBarController.swift
//  StopWatchSwift
//
//  Created by WJ on 2018/5/3.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 此时 tabBarButton 都已经创建
        print(tabBar.subviews)
        // 初始化加号按钮
        setAddButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChildVC(childVC: WorldTimeViewController(), childTitle: "世界时钟", imageName: "", selectedImageName: "")
        self.addChildVC(childVC: AlarmViewController(), childTitle: "闹铃", imageName: "", selectedImageName: "")
        self.addChildVC(childVC: AlarmViewController(), childTitle: "", imageName: "", selectedImageName: "")
        self.addChildVC(childVC: StopWatchViewController(), childTitle: "秒表", imageName: "", selectedImageName: "")
        self.addChildVC(childVC: TheTimerViewController(), childTitle: "计时器", imageName: "", selectedImageName: "")
        // Do any additional setup after loading the view.
    }
    
    private func addChildVC(childVC:UIViewController, childTitle:String, imageName: String, selectedImageName:String) {
        
        let navigation = BaseNavController(rootViewController: childVC)
        childVC.title = childTitle
        childVC.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        self.addChildViewController(navigation)
        
    }
    private var addButton:UIButton =  {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setImage(UIImage(named:"tabbar_add"), for: .normal)
        button.addTarget(self, action: #selector(addButtonClick), for: .touchUpInside)
        return button
    }()
    
    private  func setAddButton() {
        tabBar.addSubview(addButton)
        let width = tabBar.bounds.width / CGFloat(viewControllers!.count)
        let rect = CGRect(x:0, y:0 ,width:width, height:tabBar.bounds.height)
        addButton.frame = rect.offsetBy(dx:width * 2, dy:0)
    }
    
    @objc func addButtonClick() {
        let navigation = BaseNavController(rootViewController:AddViewController())
        navigation.navigationBar.barTintColor = UIColor.lightGray
        self.present(navigation, animated: true, completion: nil)
        print("1212312312131")
    }
    
}
