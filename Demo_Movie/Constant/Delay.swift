//
//  Delay.swift
//  Demo-Vimal
//
//  Created by Vimal Bosamiya on 06/06/20.
//  Copyright © 2020 Vimal Bosamiya. All rights reserved.
//

import UIKit

class Delay: NSObject {
    var callback: (() -> ())
    var delay: Double
    weak var timer: Timer?
    
    init(delay: Double, callback: @escaping (() -> ())) {
        self.delay = delay
        self.callback = callback
    }
    
    func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(Delay.fireNow), userInfo: nil, repeats: false)
        timer = nextTimer
    }
    
    @objc func fireNow() {
        self.callback()
    }
}
