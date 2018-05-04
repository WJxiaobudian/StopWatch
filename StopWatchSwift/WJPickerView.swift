//
//  WJPickerView.swift
//  StopWatchSwift
//
//  Created by WJ on 2018/5/4.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit

class WJPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    private  var hourArr:NSArray = []
    private  var minuteArr:NSArray = []
    
    var hourStr:String = ""
    var minuteStr:String = ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.dataSource = self
        self.delegate = self
        setupData()
        

    }

    func setupData() {

        if let path = Bundle.main.path(forResource: "SynTimePlistFile", ofType: "plist") {
            if let tempDict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                hourArr = tempDict["hour"] as! NSArray
                minuteArr = tempDict["minute"] as! NSArray
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hourArr.count
        }
        if component == 2 {
            return 120_000
        }
        if component == 1 {
            return 1
        }
        if  component == 3 {
            return 1
        }
        return 0
    }

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let  label = UILabel()
        if component == 0 {
            label.textAlignment = .right
            label.text = hourArr[row % hourArr.count] as? String
        } else if component == 1 {
            label.text = "小时"
            label.textAlignment = .left
        } else if component == 2 {
            label.textAlignment = .right
            label.text = minuteArr[row % minuteArr.count] as? String
        } else {
            label.text = "分钟"
            label.textAlignment = .left
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            hourStr = hourArr[row % hourArr.count] as! String
        }else if component == 2 {
            minuteStr = minuteArr[row % minuteArr.count] as! String
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
