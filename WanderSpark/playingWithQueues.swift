//
//  playingWithQueues.swift
//  WanderSpark
//
//  Created by Betty Fung on 8/10/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation

class DelayOperation: NSOperation {
    
    private let timeInterval: NSTimeInterval
    
    override var asynchronous: Bool {
        get{
            return true
        }
    }
    
    private var _executing: Bool = false
    override var executing:Bool {
        get { return _executing }
        set {
            willChangeValueForKey("isExecuting")
            _executing = newValue
            didChangeValueForKey("isExecuting")
            if _cancelled == true {
                self.finished = true
            }
        }
    }
    private var _finished: Bool = false
    override var finished:Bool {
        get { return _finished }
        set {
            willChangeValueForKey("isFinished")
            _finished = newValue
            didChangeValueForKey("isFinished")
        }
    }
    
    private var _cancelled: Bool = false
    override var cancelled: Bool {
        get { return _cancelled }
        set {
            willChangeValueForKey("isCancelled")
            _cancelled = newValue
            didChangeValueForKey("isCancelled")
        }
    }
    
    init(timeInterval: NSTimeInterval) {
        self.timeInterval = timeInterval
    }
    
    override func start() {
        super.start()
        self.executing = true
    }
    
    override func main() {
        if cancelled {
            executing = false
            finished = true
            return
        }
        let when = dispatch_time(DISPATCH_TIME_NOW, Int64(timeInterval * Double(NSEC_PER_SEC)))
        dispatch_after(when, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
            self.finished = true
            self.executing = false
        }
    }
}