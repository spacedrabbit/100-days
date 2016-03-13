//
//  Day21ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/12/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class GridView: UIView {
  override func drawRect(rect: CGRect) {
    let wt = rect.size.width; let ht = rect.size.height
    
    let ctx = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(ctx, UIColor.blackColor().CGColor)
    CGContextFillRect(ctx, rect)
    
    CGContextSetLineWidth(ctx, 1.0)
    for step in 0...Int(ceil(ht / 10.0)) {
      CGContextMoveToPoint(ctx, 0.0, CGFloat(step) * 10.0) // horizontal
      CGContextAddLineToPoint(ctx, wt, CGFloat(step) * 10.0)
    }
    
    for step in 0...Int(ceil(wt / 10.0)) {
      CGContextMoveToPoint(ctx, CGFloat(step) * 10.0, 0.0) // vertical
      CGContextAddLineToPoint(ctx, CGFloat(step) * 10.0, ht)
    }
    
    CGContextSetStrokeColorWithColor(ctx, ColorSwatch.sr_darkTeal.CGColor)
    CGContextDrawPath(ctx, CGPathDrawingMode.Stroke)
  }
}

class AskewGridView: UIView {
  
  override func drawRect(rect: CGRect) {
    let xt = rect.origin.x; let yt = rect.origin.y
    let wt = rect.size.width; let ht = rect.size.height

    let ctx = UIGraphicsGetCurrentContext()
    CGContextMoveToPoint(ctx, xt, yt) // necessary call
    
    // start off by drawing the layer black
    CGContextSetFillColorWithColor(ctx, UIColor.blackColor().CGColor)
    CGContextFillRect(ctx, rect)
    
    // Purposefully set the line width to 5.0 here for save/restores. Currently, in this state the next stroke 
    // should produce lines of 5.0 width
    CGContextSetLineWidth(ctx, 5.0)
    
    // The current context is saved as is, and popped off onto a separate stack
    CGContextSaveGState(ctx)
    
    // This begins a new context, where i set the line width to be 1
    CGContextSetLineWidth(ctx, 1.0)
    for step in 0...Int(ceil(ht / 10.0)) {
      CGContextMoveToPoint(ctx, 0.0, CGFloat(step) * 10.0) // horizontal
      CGContextAddLineToPoint(ctx, wt, CGFloat(step) * 10.0)
    }

    // then i go and draw the grid lines
    CGContextSetStrokeColorWithColor(ctx, ColorSwatch.sr_mintGreen.CGColor)
    CGContextDrawPath(ctx, CGPathDrawingMode.Stroke)
    
    // This call to restore, pushes the previous context back to be the current one. That context still has its
    // line width values set to 5.0, so that is why the following draw call produces thicker lines running parallel
    // to the y-axis
    CGContextRestoreGState(ctx)
    
    
    for step in 0...Int(ceil(wt / 10.0)) {
      CGContextMoveToPoint(ctx, CGFloat(step) * 10.0, 0.0) // vertical
      CGContextAddLineToPoint(ctx, CGFloat(step) * 10.0, ht)
    }
    
    CGContextSetStrokeColorWithColor(ctx, ColorSwatch.sr_darkTeal.CGColor)
    CGContextDrawPath(ctx, CGPathDrawingMode.EOFillStroke)
    
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(coder: aDecoder)
  }
  
}

class Day21ViewController: UIViewController {
  
  lazy var simulationView: UIView = {
    let view: UIView = UIView()
//    view.backgroundColor = ColorSwatch.sr_darkChalkGreen
    return view
  }()
  
  lazy var gridView: GridView = {
    let view: GridView = GridView()
    return view
  }()
  
  lazy var bottomView: UIView = {
    let view: UIView = UIView()
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = ColorSwatch.sr_coolWhite
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.addTapGestureToView()
    self.drawSmileyFace(self.simulationView)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.simulationView.clipsToBounds = false
    self.simulationView.layer.masksToBounds = false
  
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  internal func addTapGestureToView() {
    let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tappedView:")
    self.simulationView.addGestureRecognizer(gesture)
  }
  
  internal func tappedView(sender: AnyObject?) {
    var t = CATransform3DIdentity
//    t.m14 = -0.1
//    t.m24 = -0.1
//    t.m34 = -1.0
//    t.m41 = 100.0
//    t.m42 = 50.0
//    t.m43 = -1.0
    
//    t.m13 = 1.0
    t.m23 = -1.0
    t.m33 = -0.5
    
    
    self.simulationView.layer.anchorPoint = CGPointMake(0.0, 0.0)
//    self.simulationView.layer.anchorPointZ = -150.0
    self.simulationView.layer.position = CGPointMake(CGRectGetMinX(self.simulationView.frame) - CGRectGetMidX(self.simulationView.bounds),CGRectGetMinY(self.simulationView.frame) - CGRectGetMidY(self.simulationView.bounds))
    
    
    UIView.animateWithDuration(5.0, delay: 0.0, options: [.Repeat], animations: { () -> Void in
      self.simulationView.layer.transform = t
//      self.simulationView.layer.anchorPointZ = -200.0
      }) { (complete: Bool) -> Void in
        //        self.simulationView.layer.transform = CATransform3DIdentity
//        self.simulationView.layer.anchorPoint = CGPointMake(0.5, 0.5)
    }

  }
  
  internal func configureConstraints() {
    self.simulationView.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(125.0, 125.0))
      make.center.equalTo(self.gridView)
    }
    
    self.gridView.snp_makeConstraints { (make) -> Void in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(250.0)
    }
    
    self.bottomView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.simulationView.snp_bottom)
      make.left.right.bottom.equalTo(self.view)
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func drawSmileyFace(view: UIView) {
    let midX = CGRectGetMidX(view.bounds)
    let midY = CGRectGetMidY(view.bounds)
    let quarterW = CGRectGetWidth(view.bounds) / 4.0
    let quarterH = CGRectGetHeight(view.bounds) / 4.0
    
    let path: UIBezierPath = UIBezierPath(ovalInRect: CGRectInset(view.bounds, 1, 1)) // inset by 1 b/c of 2pt line width
    
    let circle: CAShapeLayer = CAShapeLayer()
    circle.path = path.CGPath
    circle.fillColor = UIColor.yellowColor().CGColor
    circle.strokeColor = UIColor.yellowColor().CGColor
    circle.lineWidth = 2.0
    
    let leftEye: UIBezierPath = UIBezierPath(ovalInRect: CGRectMake(quarterW, quarterH - 15.0, 20.0, 40.0))
    let leftEyeLayer: CAShapeLayer = CAShapeLayer()
    leftEyeLayer.path = leftEye.CGPath
    leftEyeLayer.strokeColor = UIColor.blackColor().CGColor
    leftEyeLayer.fillColor = UIColor.blackColor().CGColor
    leftEyeLayer.lineWidth = 1.0
    
    circle.addSublayer(leftEyeLayer)
    
    let rightEye: UIBezierPath = UIBezierPath(ovalInRect: CGRectMake(midX + (midX - quarterW) - 15.0, quarterH - 15.0 , 20.0, 40.0))
    let rightEyeLayer: CAShapeLayer = CAShapeLayer()
    rightEyeLayer.path = rightEye.CGPath
    rightEyeLayer.strokeColor = UIColor.blackColor().CGColor
    rightEyeLayer.fillColor = UIColor.blackColor().CGColor
    rightEyeLayer.lineWidth = 1.0
    
    circle.addSublayer(rightEyeLayer)
    
    let smile: UIBezierPath = UIBezierPath(arcCenter: CGPointMake(midX, midY), radius: quarterW, startAngle: 0.0, endAngle: CGFloat(M_PI), clockwise: true)
    
    let smileLayer: CAShapeLayer = CAShapeLayer()
    smileLayer.path = smile.CGPath
    smileLayer.strokeColor = UIColor.blackColor().CGColor
    smileLayer.fillColor = UIColor.yellowColor().CGColor
    smileLayer.lineWidth = 3.0
    smileLayer.lineCap = kCALineCapRound
    
    circle.addSublayer(smileLayer)
    
//    view.layer.backgroundColor = UIColor.redColor().CGColor
    view.layer.addSublayer(circle)
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(gridView)
    self.gridView.addSubview(simulationView)
    self.view.addSubview(bottomView)
  }
  
}
