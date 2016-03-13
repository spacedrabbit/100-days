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
    view.backgroundColor = UIColor.blackColor()
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
    
    var t = CATransform3DIdentity
//    t.m44 = -1.0
//    t.m13 = 1.0
//    t.m23 = 0.0
//    t.m33 = 0.0
//    t.m34 = -0.5

    
//    UIView.animateWithDuration(3.0, delay: 0.0, options: .Autoreverse, animations: { () -> Void in
//          self.simulationView.layer.transform = t
//      }) { (complete: Bool) -> Void in
//        self.simulationView.layer.transform = CATransform3DIdentity
//    }
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  internal func configureConstraints() {
    self.simulationView.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(125.0, 125.0))
      make.center.equalTo(self.gridView)
    }
    
    self.gridView.snp_makeConstraints { (make) -> Void in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(220.0)
    }
    
    self.bottomView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.simulationView.snp_bottom)
      make.left.right.bottom.equalTo(self.view)
    }
    
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(simulationView)
    self.view.addSubview(gridView)
    self.view.addSubview(bottomView)
  }
  
}
