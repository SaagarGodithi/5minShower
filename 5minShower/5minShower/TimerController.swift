//
//  TimerController.swift
//  TimerFunctions
//
//  Created by Kiran Kunigiri on 7/14/15.
//  Copyright (c) 2015 Kiran Kunigiri. All rights reserved.
//

import Foundation
import UIKit

class TimerController: NSObject {
    // Time Properties
    var timer = NSTimer()
    var startTime = NSTimeInterval()
    
    // Properties of the label string
    var strHours = "00"
    var strMinutes = "00"
    var strSeconds = "00"
    var strFraction = "00"
    
    var totalTime: NSTimeInterval = 300
    
    // Properties of actual values
    var hours = 0
    var minutes = 0
    var seconds = 0
    var fraction = 0
    
    var timeText = ""
    var label = UILabel()
    
    // MARK: Main Update Function
    func updateTime() {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //Set the elapsed time to the amount of time left in the timer
        
        var timeLeft = totalTime - elapsedTime
        
        if timeLeft <= 0 {
            self.stop()
        }
        
        //calculate the hours in elapsed time.
        
        hours = Int(timeLeft / 3600.0)
        
        timeLeft -= (NSTimeInterval(hours) * 3600)
        
        //calculate the minutes in elapsed time.
        
        minutes = Int(timeLeft / 60.0)
        
        timeLeft -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        seconds = Int(timeLeft)
        
        timeLeft -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        fraction = Int(timeLeft * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        strHours = String(format: "%02d", hours)
        strMinutes = String(format: "%02d", minutes)
        strSeconds = String(format: "%02d", seconds)
        strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        label.text = "\(strHours):\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
    
    // MARK: Setting Functions
    func resetTimer() {
        startTime = NSDate.timeIntervalSinceReferenceDate()
        var strHours = "00"
        var strMinutes = "00"
        var strSeconds = "00"
        var strFraction = "00"
        var hours = 0
        var minutes = 0
        var seconds = 0
        var fraction = 0
        label.text = "\(strHours):\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
    func resetTimerWithNewTime(newTotalTime: NSTimeInterval) {
        self.totalTime = newTotalTime
        startTime = NSDate.timeIntervalSinceReferenceDate()
        var strHours = "00"
        var strMinutes = "00"
        var strSeconds = "00"
        var strFraction = "00"
        var hours = 0
        var minutes = 0
        var seconds = 0
        var fraction = 0
        label.text = "\(strMinutes):\(strSeconds)"
    }
    
    // MARK: Start/Stop Functions
    func start() {
        if !timer.valid {
            let aSelector: Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    func stop() {
        timer.invalidate()
        resetTimer()
    }
    
    
    // MARK: Value Functions
    func getTimeLeft() -> NSTimeInterval {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        //Set the elapsed time to the amount of time left in the timer
        var timeLeft = totalTime - elapsedTime
        return timeLeft
    }
    
    func getTimeComplete() -> NSTimeInterval {
        var timeLeft = getTimeLeft()
        var timeComplete = totalTime - timeLeft
        return timeComplete
    }
    
    func getPercentageCompleted() -> Int {
        var timeLeft = getTimeLeft()
        var timeComplete = totalTime - timeLeft
        var percent = Int(timeComplete/totalTime*100)
        
        return percent
    }
    
    
    
}
