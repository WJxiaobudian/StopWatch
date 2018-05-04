//
//  Stopwatch.swift
//  StopWatchSwift
//
//  Created by WJ on 2018/5/3.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit

class Stopwatch: NSObject {
    var counter:Double
    var timer:Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
}
