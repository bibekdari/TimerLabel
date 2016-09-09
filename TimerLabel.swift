//
//  TimerLabel.swift
//  DartsCool
//
//  Created by bibek on 9/7/16.
//  Copyright © 2016 Ekbana Solutions Pte. Ltd. All rights reserved.
//

import UIKit

protocol TimerLabelDelegate: class {
    func newValue(timerLabel: TimerLabel) -> String
    func time(updateTimeIntervalFor timerLabel: TimerLabel) -> NSTimeInterval
}

class TimerLabel: UILabel {
    
    weak var delegate: TimerLabelDelegate? {
        didSet  {
            resetTimer()
            setup(delegate)
        }
    }
    
    deinit {
        delegate = nil
    }
    
    private var timer: NSTimer?
    
    private func setup(delegate: TimerLabelDelegate?) {
        guard let delegate = delegate else {return}
        let time = delegate.time(updateTimeIntervalFor: self)
        timer    = NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: #selector(ticked(_:)), userInfo: nil, repeats: time > 0)
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func ticked(timer: NSTimer?) {
        if let delegate = delegate {
            self.text = delegate.newValue(self)
        } else {
            resetTimer()
        }
    }
}
