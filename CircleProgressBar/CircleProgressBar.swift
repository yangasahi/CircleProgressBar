//
//  CircleProgressBar.swift
//  CircleProgressBar
//
//  Created by YANG XU on 2018/07/21.
//  Copyright © 2018年 YANG XU. All rights reserved.
//

import UIKit

public class CircleProgressBar: UIView {
    
    public var animationTimeDuring: CGFloat = 1.0
    public var startAngle: CGFloat = 270
    public var isClockwise = true
    
    private var circleProgressBarItems = [CircleProgressBarItem]()
    private var isAnimating = false
    
    private var startValue: CGFloat = 0
    private var indexOfArray = 0
    
    public func show() {
        guard circleProgressBarItems.count > 0, !isAnimating else {
            return
        }
        
        isAnimating = true
        
        removeAllSublayers()
        addMaskLayer()
        configCircleProgressBar()
    }
    
    public func add(_ circleProgressBarItem: CircleProgressBarItem) {
        circleProgressBarItems.append(circleProgressBarItem)
    }
    
    private func configCircleProgressBar() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = circleProgressBarItems[indexOfArray].strokeWidth
        shapeLayer.strokeColor = circleProgressBarItems[indexOfArray].strokeColor.cgColor
        
        let center = CGPoint(x: shapeLayer.frame.width / 2, y: shapeLayer.frame.height / 2)
        let radius = min(center.x, center.y)
        
        let uiBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle / 180.0 * CGFloat.pi, endAngle: (startAngle + 360) / 180.0 * CGFloat.pi, clockwise: isClockwise)
        
        let caBasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        caBasicAnimation.duration = getAnimationTime(from: circleProgressBarItems[indexOfArray].value)
        caBasicAnimation.fromValue = startValue
        caBasicAnimation.toValue = circleProgressBarItems[indexOfArray].value + startValue
        caBasicAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        caBasicAnimation.delegate = self
        shapeLayer.add(caBasicAnimation, forKey: "strokeEnd")
        
        shapeLayer.path = uiBezierPath.cgPath
        shapeLayer.strokeStart = startValue
        shapeLayer.strokeEnd = circleProgressBarItems[indexOfArray].value + startValue
        startValue = shapeLayer.strokeEnd
        
        indexOfArray += 1
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    private func getAnimationTime(from value: CGFloat) -> TimeInterval {
        var totalValue: CGFloat = 0
        for circleProgressBarItem in circleProgressBarItems {
            totalValue += circleProgressBarItem.value
        }
        return TimeInterval(value * animationTimeDuring / totalValue)
    }
    
    private func removeAllSublayers() {
        self.layer.sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
    }
    
    private func addMaskLayer() {
        var smallerStrokeWidth = circleProgressBarItems[0].strokeWidth
        
        for circleProgressBar in circleProgressBarItems {
            if circleProgressBar.strokeWidth < smallerStrokeWidth {
                smallerStrokeWidth = circleProgressBar.strokeWidth
            }
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = smallerStrokeWidth
        let center = CGPoint(x: shapeLayer.frame.width / 2, y: shapeLayer.frame.height / 2)
        let radius = min(center.x, center.y)
        
        let uiBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle / 180.0 * CGFloat.pi, endAngle: (startAngle + 360) / 180.0 * CGFloat.pi, clockwise: isClockwise)
        
        shapeLayer.path = uiBezierPath.cgPath
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        
        self.layer.addSublayer(shapeLayer)
    }
}

extension CircleProgressBar: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard flag else {
            return
        }
        guard indexOfArray < circleProgressBarItems.count else {
            indexOfArray = 0
            startValue = 0
            isAnimating = false
            return
        }
        configCircleProgressBar()
    }
}
