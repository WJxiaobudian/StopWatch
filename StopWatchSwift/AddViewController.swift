//
//  AddViewController.swift
//  StopWatchSwift
//
//  Created by WJ on 2018/5/3.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.red
 
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"backItemImage"), style: .plain, target: self, action: #selector(goBack))
        // Do any additional setup after loading the view.
    }

    @objc private func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
