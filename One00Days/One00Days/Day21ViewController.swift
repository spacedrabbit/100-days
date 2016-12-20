//
//  Day21ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/12/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class GridView: UIView {
  override func draw(_ rect: CGRect) {
    let wt = rect.size.width; let ht = rect.size.height
    
    let ctx = UIGraphicsGetCurrentContext()
    ctx?.setFillColor(UIColor.black.cgColor)
    ctx?.fill(rect)
    
    ctx?.setLineWidth(1.0)
    for step in 0...Int(ceil(ht / 10.0)) {
      ctx?.move(to: CGPoint(x: 0.0, y: CGFloat(step) * 10.0)) // horizontal
      ctx?.addLine(to: CGPoint(x: wt, y: CGFloat(step) * 10.0))
    }
    
    for step in 0...Int(ceil(wt / 10.0)) {
      ctx?.move(to: CGPoint(x: CGFloat(step) * 10.0, y: 0.0)) // vertical
      ctx?.addLine(to: CGPoint(x: CGFloat(step) * 10.0, y: ht))
    }
    
    ctx?.setStrokeColor(ColorSwatch.sr_darkTeal.cgColor)
    ctx?.drawPath(using: CGPathDrawingMode.stroke)
  }
}

class AskewGridView: UIView {
  
  override func draw(_ rect: CGRect) {
    let xt = rect.origin.x; let yt = rect.origin.y
    let wt = rect.size.width; let ht = rect.size.height

    let ctx = UIGraphicsGetCurrentContext()
    ctx?.move(to: CGPoint(x: xt, y: yt)) // necessary call
    
    // start off by drawing the layer black
    ctx?.setFillColor(UIColor.black.cgColor)
    ctx?.fill(rect)
    
    // Purposefully set the line width to 5.0 here for save/restores. Currently, in this state the next stroke 
    // should produce lines of 5.0 width
    ctx?.setLineWidth(5.0)
    
    // The current context is saved as is, and popped off onto a separate stack
    ctx?.saveGState()
    
    // This begins a new context, where i set the line width to be 1
    ctx?.setLineWidth(1.0)
    for step in 0...Int(ceil(ht / 10.0)) {
      ctx?.move(to: CGPoint(x: 0.0, y: CGFloat(step) * 10.0)) // horizontal
      ctx?.addLine(to: CGPoint(x: wt, y: CGFloat(step) * 10.0))
    }

    // then i go and draw the grid lines
    ctx?.setStrokeColor(ColorSwatch.sr_mintGreen.cgColor)
    ctx?.drawPath(using: CGPathDrawingMode.stroke)
    
    // This call to restore, pushes the previous context back to be the current one. That context still has its
    // line width values set to 5.0, so that is why the following draw call produces thicker lines running parallel
    // to the y-axis
    ctx?.restoreGState()
    
    
    for step in 0...Int(ceil(wt / 10.0)) {
      ctx?.move(to: CGPoint(x: CGFloat(step) * 10.0, y: 0.0)) // vertical
      ctx?.addLine(to: CGPoint(x: CGFloat(step) * 10.0, y: ht))
    }
    
    ctx?.setStrokeColor(ColorSwatch.sr_darkTeal.cgColor)
    ctx?.drawPath(using: CGPathDrawingMode.eoFillStroke)
    
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.simulationView.clipsToBounds = false
    self.simulationView.layer.masksToBounds = false
  
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  internal func addTapGestureToView() {
    let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Day21ViewController.tappedView(_:)))
    self.simulationView.addGestureRecognizer(gesture)
  }
  
  internal func tappedView(_ sender: AnyObject?) {
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
    
    
    self.simulationView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
//    self.simulationView.layer.anchorPointZ = -150.0
    self.simulationView.layer.position = CGPoint(x: self.simulationView.frame.minX - self.simulationView.bounds.midX,y: self.simulationView.frame.minY - self.simulationView.bounds.midY)
    
    
    UIView.animate(withDuration: 5.0, delay: 0.0, options: [.repeat], animations: { () -> Void in
      self.simulationView.layer.transform = t
//      self.simulationView.layer.anchorPointZ = -200.0
      }) { (complete: Bool) -> Void in
        //        self.simulationView.layer.transform = CATransform3DIdentity
//        self.simulationView.layer.anchorPoint = CGPointMake(0.5, 0.5)
    }

  }
  
  internal func configureConstraints() {
    self.simulationView.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(CGSize(width: 125.0, height: 125.0))
      make.center.equalTo(self.gridView)
    }
    
    self.gridView.snp.makeConstraints { (make) -> Void in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(250.0)
    }
    
    self.bottomView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.simulationView.snp.bottom)
      make.left.right.bottom.equalTo(self.view)
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func drawSmileyFace(_ view: UIView) {
    let midX = view.bounds.midX
    let midY = view.bounds.midY
    let quarterW = view.bounds.width / 4.0
    let quarterH = view.bounds.height / 4.0
    
    let path: UIBezierPath = UIBezierPath(ovalIn: view.bounds.insetBy(dx: 1, dy: 1)) // inset by 1 b/c of 2pt line width
    
    let circle: CAShapeLayer = CAShapeLayer()
    circle.path = path.cgPath
    circle.fillColor = UIColor.yellow.cgColor
    circle.strokeColor = UIColor.yellow.cgColor
    circle.lineWidth = 2.0
    
    let leftEye: UIBezierPath = UIBezierPath(ovalIn: CGRect(x: quarterW, y: quarterH - 15.0, width: 20.0, height: 40.0))
    let leftEyeLayer: CAShapeLayer = CAShapeLayer()
    leftEyeLayer.path = leftEye.cgPath
    leftEyeLayer.strokeColor = UIColor.black.cgColor
    leftEyeLayer.fillColor = UIColor.black.cgColor
    leftEyeLayer.lineWidth = 1.0
    
    circle.addSublayer(leftEyeLayer)
    
    let rightEye: UIBezierPath = UIBezierPath(ovalIn: CGRect(x: midX + (midX - quarterW) - 15.0, y: quarterH - 15.0 , width: 20.0, height: 40.0))
    let rightEyeLayer: CAShapeLayer = CAShapeLayer()
    rightEyeLayer.path = rightEye.cgPath
    rightEyeLayer.strokeColor = UIColor.black.cgColor
    rightEyeLayer.fillColor = UIColor.black.cgColor
    rightEyeLayer.lineWidth = 1.0
    
    circle.addSublayer(rightEyeLayer)
    
    let smile: UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: midX, y: midY), radius: quarterW, startAngle: 0.0, endAngle: CGFloat(M_PI), clockwise: true)
    
    let smileLayer: CAShapeLayer = CAShapeLayer()
    smileLayer.path = smile.cgPath
    smileLayer.strokeColor = UIColor.black.cgColor
    smileLayer.fillColor = UIColor.yellow.cgColor
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
