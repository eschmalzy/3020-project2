//
//  DrawableView.swift
//  Notey
//
//  Created by Ethan Schmalz on 10/20/17.
//  Copyright © 2017 Ethan Schmalz. All rights reserved.
//

import UIKit

class DrawableView: UIView {
    
    let path = UIBezierPath()
    var previousPoint:CGPoint
    var lineWidth:CGFloat = 5.0
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override init(frame: CGRect) {
        previousPoint = CGPoint.zero
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        previousPoint = CGPoint.zero
        super.init(coder: aDecoder)
        
        let panGestureRecognizer=UIPanGestureRecognizer(target: self, action: #selector(pan))
        panGestureRecognizer.maximumNumberOfTouches = 1
        
        self.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.black.setStroke()
        path.stroke()
        path.lineWidth = lineWidth
    }
    
    func pan(panGestureRecognizer:UIPanGestureRecognizer)->Void{
        let currentPoint=panGestureRecognizer.location(in: self)
        let midPoint=self.midPoint(p0: previousPoint, p1: currentPoint)
        
        
        if panGestureRecognizer.state == .began{
            path.move(to: currentPoint)
        }
        else if panGestureRecognizer.state == .changed{
            path.addQuadCurve(to: midPoint,controlPoint: previousPoint)
        }
        
        previousPoint=currentPoint
        self.setNeedsDisplay()
    }
    
    func midPoint(p0:CGPoint,p1:CGPoint)->CGPoint{
        let x=(p0.x+p1.x)/2
        let y=(p0.y+p1.y)/2
        return CGPoint(x: x, y: y)
    }
    
}

extension UIView {
    
    func createImage() -> UIImage {
        
        let rect: CGRect = self.frame
        
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
        
    }
    
}
