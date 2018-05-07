//
//  TheTimerViewController.swift
//  StopWatchSwift
//
//  Created by WJ on 2018/5/3.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit

class TheTimerViewController: UIViewController{
    
    fileprivate let mainStopwatch:Stopwatch = Stopwatch()
    private var isplay:Bool = false
    private var ispause:Bool = false
    private let stopButton = UIButton.init(type: .custom)
    private let startButton = UIButton.init(type: .custom)
    private let backView = UIView()
    private let backLabel = UILabel()
    private var dateTimer:UIDatePicker!
   
    private var countTimer = TimeInterval()
    
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
        
        dateTimer = UIDatePicker.init(frame: CGRect(x:0,y:0,width:0,height:0))
        dateTimer.locale = Locale(identifier: "zh_CN")
        dateTimer.datePickerMode = .countDownTimer
        dateTimer.backgroundColor = UIColor.white
        backView.addSubview(dateTimer)
        dateTimer.mas_makeConstraints { (make:MASConstraintMaker!) in
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

        backView.bringSubview(toFront: dateTimer)

        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        self.view.addSubview(lineView)
        lineView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(dateTimer.mas_bottom)
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
    
  @objc  func timerChanged() {
    print("您选择倒计时间为：\(dateTimer.countDownDuration)")
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
            backView.bringSubview(toFront: dateTimer)
            
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
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let date = dateTimer.date
            countTimer = date.timeIntervalSince1970
            let dateText = formatter.string(from: date)
            backLabel.text = dateText
            
            ispause = true
            stopButton.isEnabled = true
            isplay = true
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func updateTimer() {
        //获取当前时间
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyyMMdd"
        print("当前日期时间：\(dformatter.string(from: now))")
        let tempDate = dformatter.string(from: now)
        let d = dformatter.date(from: tempDate)
        //当前时间的时间戳
        let timeInterval:TimeInterval = d!.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        print("当前时间的时间戳：\(timeStamp)")
        print("\(countTimer)")
        
        if countTimer - TimeInterval(timeStamp) > 0 {
            countTimer -= 1
        } else {
            mainStopwatch.timer.invalidate()
            let alertController = UIAlertController.init(title: "时间到", message: "", preferredStyle: .alert)
            let defaultAction = UIAlertAction.init(title: "确定", style: .default) { (action) in
                self.backView.bringSubview(toFront: self.dateTimer)
                self.changeButton(self.stopButton, title: "暂停", titleColor: UIColor.lightGray)
                self.changeButton(self.startButton, title: "开始计时", titleColor: UIColor.green)
                alertController .dismiss(animated: true, completion: nil)
            }
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }

        let dfmatter = DateFormatter()
        dfmatter.dateFormat="HH:mm:ss"
        let date = NSDate(timeIntervalSince1970: countTimer)
        let dateText = dfmatter.string(from: date as Date)
        backLabel.text = dateText
        
    }
    
    private func changeButton(_ button:UIButton, title:String, titleColor:UIColor) {
        button .setTitle(title, for: UIControlState())
        button .setTitleColor(titleColor, for: UIControlState())
    }

}
