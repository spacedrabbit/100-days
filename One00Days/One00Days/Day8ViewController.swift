//
//  Dat8ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/28/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day8ViewController: UIViewController {
  
  let frontCardView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.lightGray
    return view
  }()
  
  let backCardView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.blue
    return view
  }()
  
  let frontCardText: UILabel = {
    let label: UILabel = UILabel()
    label.text = "Hello world, how are you"
    label.font = UIFont(name: "Menlo", size: 40.0)
    label.numberOfLines = 3
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  let insideCardText: UILabel = {
    let label: UILabel = UILabel()
    label.text = "World keeps turning and I've been better"
    label.font = UIFont(name: "Menlo", size: 40.0)
    label.adjustsFontSizeToFitWidth = true
    label.numberOfLines = 3
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.brown
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
    self.applyTransform()
  }
  
  override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
  
  internal func configureConstraints() {
    self.frontCardView.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(200.0)
      make.height.equalTo(170.0)
      make.center.equalTo(self.view.snp.center)
    }
    
    self.backCardView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.frontCardView.snp.edges)
    }
    
    self.frontCardText.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.frontCardView.snp.edges)
    }
    
    self.insideCardText.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.backCardView.snp.edges)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.backCardView)
    self.view.addSubview(self.frontCardView)
    
    self.frontCardView.addSubview(self.frontCardText)
    
    self.backCardView.addSubview(self.insideCardText)
  }
  
  internal func applyTransform() {
    
    let frontCardAngle: CGFloat = degreesToRadians(35.0)
    let sideTwist: CGFloat = degreesToRadians(20.0)
    self.frontCardView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
//    self.frontCardView.layer.position = CGPointMake( CGRectGetMidX(self.frontCardView.frame), CGRectGetMaxY(self.frontCardView.frame))
    let rotateForwardOnX = CATransform3DMakeRotation(frontCardAngle, 1.0, 0.0, 0.0)
    let rotateLeftOnY = CATransform3DMakeRotation(sideTwist, 0.0, -1.0, 0.0)
    
    self.frontCardView.layer.transform = CATransform3DConcat(rotateForwardOnX, rotateLeftOnY)
    
  }
  
  
}
