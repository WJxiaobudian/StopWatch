//
//  StopWatchViewController.swift
//  StopWatchSwift
//
//  Created by WJ on 2018/5/3.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController, UITableViewDelegate {
    
    fileprivate let mainStopwatch:Stopwatch = Stopwatch()
    fileprivate let lapStopwatch:Stopwatch = Stopwatch()
    fileprivate var isPlay:Bool = false
    fileprivate var laps:[String] = []
    
    let backView = UIView()
    let bigTimerLabel = UILabel()
    let smallTimerLabel = UILabel()
    
    let LapButton = UIButton.init(type: .custom)
    let startButton = UIButton.init(type: .custom)
    let tableView = UITableView.init(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.init(hexColor: "f8f8f8")
        
        self.title = "秒表"
        SetbackView()
        SetBigTimer()
        SetSmallTimer()
        SetLapButton()
        SetStartButton()
        SetTableView()
        let initcircleButton:(UIButton) ->Void = {button in
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 33
            button.backgroundColor = UIColor.white
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 0.5
        }
        initcircleButton(LapButton)
        initcircleButton(startButton)
        
        LapButton.isEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func SetbackView() -> Void  {
        backView.backgroundColor = UIColor.white
        self.view.addSubview(backView)
        backView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make!.top.equalTo()(HEIGHT_NAVBAR)
            make!.left.equalTo()(0)
            make!.right.equalTo()(self.view)
            make!.height.equalTo()(150)
        }
    }
    func SetBigTimer() -> Void {
        bigTimerLabel.font = UIFont.systemFont(ofSize: 40)
        bigTimerLabel.textAlignment = .center
        bigTimerLabel.text = "00:00.00"
        backView.addSubview(bigTimerLabel)
        bigTimerLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make!.center.equalTo()(backView.center)
            make!.width.equalTo()(170)
        }
    }
    func SetSmallTimer() -> Void {
        smallTimerLabel.textAlignment = .right
        smallTimerLabel.text = "00:00:00"
        smallTimerLabel.font = UIFont.systemFont(ofSize: 17)
        backView.addSubview(smallTimerLabel)
        smallTimerLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make!.right.equalTo()(bigTimerLabel.mas_right)
            make!.height.equalTo()(30)
            make!.bottom.equalTo()(bigTimerLabel.mas_top)
        }
    }
    
    func SetLapButton() -> Void {
        LapButton .setTitle("Lap", for: .normal)
        LapButton .setTitleColor(UIColor.lightGray, for: .normal)
        LapButton .addTarget(self, action: #selector(lapButton(sender:)), for: .touchUpInside)
        
        
        self.view.addSubview(LapButton)
        LapButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(backView.mas_bottom)?.offset()(20)
            make.left.equalTo()(100)
            make.width.height().equalTo()(66)
        }
        
    }
    
    func SetStartButton() -> Void {
        startButton .setTitle("start", for: .normal)
        startButton .setTitleColor(UIColor.orange, for: .normal)
        startButton .addTarget(self, action: #selector(startButton(sender:)), for: .touchUpInside)
        self.view.addSubview(startButton)
        startButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(LapButton.mas_top)
            make.width.height().equalTo()(LapButton)
            make.right.equalTo()(-100)
        }
    }
    
    func SetTableView() -> Void {
        tableView.backgroundColor = UIColor.init(hexColor: "f8f8f8")
        self.view.addSubview(tableView)
        tableView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(startButton.mas_bottom)?.offset()(20)
            make.left.right().equalTo()(self.view)
            make.bottom.equalTo()(self.view)
        }
    }
    
    @objc func lapButton(sender:UIButton) -> Void {
        
        if !isPlay {
            resetLapTimer()
            resetMainTimer()
            changeButton(button: LapButton, title: "Lap", titleColor: UIColor.lightGray)
            LapButton.isEnabled = false
        } else {
            if let timerLabelText = bigTimerLabel.text {
                laps.append(timerLabelText)
            }
            tableView.reloadData()
            resetLapTimer()
            unowned let weakSelf = self
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: .commonModes)
        }
    }
    
    @objc func startButton(sender:UIButton) -> Void {
        LapButton.isEnabled = true
        changeButton(button: LapButton, title: "Lap", titleColor: UIColor.black)
        if !isPlay {
            unowned let weakSelf = self
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateMainTimer), userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(mainStopwatch.timer, forMode: .commonModes)
            RunLoop.current.add(lapStopwatch.timer, forMode: .commonModes)
            isPlay = true
            changeButton(button: startButton, title: "Stop", titleColor: UIColor.red)
        } else {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isPlay = false
            changeButton(button: LapButton, title: "Reset", titleColor: UIColor.black)
            changeButton(button: startButton, title: "Start", titleColor: UIColor.green)
        }
        
    }
    
    fileprivate func changeButton(button:UIButton ,title:String, titleColor:UIColor) {
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(titleColor, for: UIControlState())
    }
    
    
    @objc func updateMainTimer() {
        updateTimer(mainStopwatch, label: bigTimerLabel)
    }
    
    @objc func updateLapTimer() {
        updateTimer(lapStopwatch, label: smallTimerLabel)
    }
    
    func updateTimer(_ stopwatch:Stopwatch, label:UILabel) -> Void {
        stopwatch.counter = stopwatch.counter + 0.035
        var minutes:String = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        var seconds:String = String(format:"%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        label.text = minutes + ":" + seconds
        
    }
    
    fileprivate func resetLapTimer() {
        resetTimer(lapStopwatch, label: smallTimerLabel)
    }
    
    fileprivate func resetMainTimer() {
        resetTimer(mainStopwatch, label: bigTimerLabel)
        laps.removeAll()
        tableView.reloadData()
    }
    
    fileprivate func resetTimer (_ stopwatch:Stopwatch, label:UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
}

extension StopWatchViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:String = "lapCell"
        
        let cell:UITableViewCell = UITableViewCell.init(style: .value1, reuseIdentifier: identifier)
        
        cell.textLabel?.text = "Lap \(laps.count - (indexPath as NSIndexPath).row)"
        
        cell.detailTextLabel?.text = laps[laps.count - (indexPath as NSIndexPath).row - 1]
        
        return cell
    }
}

