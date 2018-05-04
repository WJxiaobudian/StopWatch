//
//  TheTimerViewController.swift
//  StopWatchSwift
//
//  Created by WJ on 2018/5/3.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit

class TheTimerViewController: UIViewController{
    var pickerView = WJPickerView()
    
    fileprivate let mainStopwatch:Stopwatch = Stopwatch()
    private var isplay:Bool = false
    private var ispause:Bool = false
    private let stopButton = UIButton.init(type: .custom)
    private let startButton = UIButton.init(type: .custom)
    private let backView = UIView()
    private let backLabel = UILabel()
    
    var hour:Int?
    var minute:Int?
    var second:Int = 00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hexColor: "f8f8f8")
        stopButton.isEnabled = false
        setupPickerView()
        
    }
    
    func setupPickerView()  {
        
        backView.backgroundColor = UIColor.white
        self.view.addSubview(backView)
        backView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(64)
            make.right.equalTo()(0)
            make.left.equalTo()(0)
            make.height.equalTo()(200)
        }
        
        pickerView = WJPickerView.init(frame: CGRect(x:0,y:0,width:0,height:0))
        pickerView.backgroundColor = UIColor.white
        backView.addSubview(pickerView)
        pickerView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(backView.mas_top)
            make.right.equalTo()(-50)
            make.left.equalTo()(50)
            make.bottom.equalTo()(backView.mas_bottom)
        }
        
        backLabel.backgroundColor = UIColor.white
        backLabel.textAlignment = .center
        backLabel.text = "00:00:00"
        backLabel.font = UIFont.systemFont(ofSize: 55)
        backView.addSubview(backLabel)
        backLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(backView.mas_top)
            make.right.equalTo()(0)
            make.left.equalTo()(0)
            make.bottom.equalTo()(backView.mas_bottom)
        }
        
        backView.bringSubview(toFront: pickerView)
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        self.view.addSubview(lineView)
        lineView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(pickerView.mas_bottom)
            make.right.left().equalTo()(self.view)
            make.height.equalTo()(0.5)
        }
        
        
        stopButton .setTitle("暂停", for: .normal)
        stopButton .setTitleColor(UIColor.lightGray, for: .normal)
        stopButton .addTarget(self, action: #selector(stopContinueButton), for: .touchUpInside)
        self.view.addSubview(stopButton)
        stopButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(lineView.mas_bottom)?.offset()(50)
            make.left.equalTo()(self.view)?.offset()(88)
            make.width.height().equalTo()(88)
        }
        
        startButton.setTitle("开始计时", for: .normal)
        startButton.setTitleColor(UIColor.green, for: .normal)
        startButton .addTarget(self, action: #selector(startCancelButton), for: .touchUpInside)
        self.view.addSubview(startButton)
        startButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(stopButton.mas_top)
            make.right.equalTo()(self.view)?.offset()(-88)
            make.width.height().equalTo()(stopButton)
        }
        
        let initcircleButton:(UIButton) ->Void = { button in
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 44
            button.backgroundColor = UIColor.white
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 0.5
        }
        
        initcircleButton(stopButton)
        initcircleButton(startButton)
    }
    
    // 暂停 继续
    @objc private func stopContinueButton () {
        if ispause {
            changeButton(stopButton, title: "继续", titleColor: UIColor.black)
            print("暂停")
           mainStopwatch.timer.fireDate = Date.distantFuture
            ispause = false
        } else {
            changeButton(stopButton, title: "暂停", titleColor: UIColor.black)
            print("继续")
            mainStopwatch.timer.fireDate = NSDate.init() as Date
            ispause = true
            
        }
    }
    
    // 开始 取消
    @objc private func startCancelButton () {
        
        if isplay {
            changeButton(startButton, title: "开始计时", titleColor: UIColor.green)
            changeButton(stopButton, title: "暂停", titleColor: UIColor.lightGray)
            backView.bringSubview(toFront: pickerView)
            mainStopwatch.timer.invalidate()
            hour = 00
            minute = 00
            second = 00

            ispause = false
            stopButton.isEnabled = false
            isplay = false
        } else {
            changeButton(startButton, title: "取消", titleColor: UIColor.red)
            changeButton(stopButton, title: "暂停", titleColor: UIColor.black)
            backView.bringSubview(toFront: backLabel)
            hour = Int(String(describing: pickerView.hourStr))
            minute = Int(String(describing: pickerView.minuteStr))
            if (minute == nil) {
                minute = 00
            }
            if hour == nil {
                hour = 00
            }
            backLabel.text = "\((String(format:"%02d",hour!))):\((String(format:"%02d",minute!))):00"
            ispause = true
            stopButton.isEnabled = true
            isplay = true
            
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func updateTimer() {
        print("11111")
        
        if second <= 0 {
            if minute! > 0 {
                minute = minute! - 1
                second = 59
            }else if hour! > 0 {
                hour = hour! - 1
                minute = 59
                second = 59
            } else {
                print("123")
                mainStopwatch.timer.invalidate()
            }
        }
        print("\((String(format:"%02d",hour!))):\((String(format:"%02d",minute!))):\(String(format:"%02d",second))")
        backLabel.text = "\((String(format:"%02d",hour!))):\((String(format:"%02d",minute!))):\(String(format:"%02d",second))"
        second -= 1
    }
    
    private func changeButton(_ button:UIButton, title:String, titleColor:UIColor) {
        button .setTitle(title, for: UIControlState())
        button .setTitleColor(titleColor, for: UIControlState())
    }

}
