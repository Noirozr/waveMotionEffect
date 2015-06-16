//
//  ViewController.swift
//  waveMotionEffect
//
//  Created by Noirozr on 15/6/15.
//  Copyright (c) 2015年 Yongjia Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var startPath: UIBezierPath!
    var endPath: UIBezierPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.view.frame.size.width)
        println(self.view.frame.size.height)
        //self.view.layer.sublayers.removeAll(keepCapacity: false)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if let touch = touches.first as? UITouch {
            var point = touch.locationInView(self.view)
            var layer = CAShapeLayer()
            //layer.lineDashPattern = [NSNumber(int: 15), NSNumber(int: 6), NSNumber(int: 9)]
            layer.lineWidth = 1
            layer.lineCap = kCALineCapRound
            layer.strokeColor = UIColor(red:0.06, green:0.05, blue:0.04, alpha:1).CGColor
            layer.fillColor = UIColor.clearColor().CGColor
            startPath = UIBezierPath()
            startPath.addArcWithCenter(CGPointMake(point.x, point.y), radius: 20, startAngle: CGFloat(0), endAngle: 2 * CGFloat(M_PI), clockwise: true)
            endPath = UIBezierPath()
            endPath.addArcWithCenter(CGPointMake(point.x, point.y), radius: 80, startAngle: CGFloat(0), endAngle: 2 * CGFloat(M_PI), clockwise: true)
            layer.path = startPath.CGPath
            self.view.layer.addSublayer(layer)
            
        }
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if let layer = self.view.layer.sublayers.last as? CAShapeLayer {
            
            var pathAnimation = CABasicAnimation(keyPath: "path")
            pathAnimation.fromValue = self.startPath.CGPath
            pathAnimation.toValue = self.endPath.CGPath
            

            var dashAnimation = CABasicAnimation(keyPath: "lineDashPattern")
            dashAnimation.fromValue = [NSNumber(int: 12)]
            dashAnimation.toValue = [NSNumber(int: 24)]
            dashAnimation.beginTime = 0.5
            
            var group = CAAnimationGroup()
            group.duration = 1.0
            //group.beginTime = CACurrentMediaTime() + 0.5
            group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            group.animations = [pathAnimation, dashAnimation]
            layer.addAnimation(group, forKey: "animationKey")
//            layer.path = self.endPath.CGPath
//            layer.strokeColor = UIColor.orangeColor().CGColor
            

            
            
        }
        
        let layerQueue = dispatch_queue_create("layerQueue", nil)
        dispatch_async(layerQueue) {
            
            NSThread.sleepForTimeInterval(0.9)
            dispatch_async(dispatch_get_main_queue()) {
                self.view.layer.sublayers.removeAtIndex(2)

            }
        }
        super.touchesEnded(touches, withEvent: event)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

