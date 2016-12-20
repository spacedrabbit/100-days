//
//  Day6ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/26/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day6ViewController: UIViewController {
  
  var isOpen: Bool = false
  
  lazy var doorView: UIView = {
    var view:UIView = UIView()
    view.backgroundColor = UIColor.darkGray
    return view
  }()
  
  lazy var interiorView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.yellow
    return view
  }()
  
  lazy var wallView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.lightGray
    return view
  }()
  
  lazy var rodrigoSignView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.black
    return view
  }()
  
  lazy var shiftSignView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.yellow
    return view
  }()
  
  lazy var posseSignView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.red
    return view
  }()
  
  lazy var rodrigoLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "RODRIGO"
    label.adjustsFontSizeToFitWidth = true
    label.textColor = UIColor.white
    return label
  }()
  
  lazy var shiftLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "SHIFT"
    label.adjustsFontSizeToFitWidth = true
    label.textColor = UIColor.white
    return label
  }()
  
  lazy var posseLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "POSSE"
    label.adjustsFontSizeToFitWidth = true
    label.textColor = UIColor.white
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.setupDoorAsButton()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  internal func configureConstraints() {
    
    self.wallView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view.snp.edges)
    }
    
    self.interiorView.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.wallView.snp.center)
      make.height.equalTo(225.0)
      make.width.equalTo(160.0)
    }
    
    self.doorView.snp.makeConstraints { (make) -> Void in
//      make.edges.equalTo(self.interiorView.snp.edges).offset(UIEdgeInsetsMake(4.0, 4.0, -4.0, 4.0))
      make.edges.equalTo(self.interiorView.snp.edges).offset(4)
    }
    
    self.rodrigoSignView.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(50.0)
      make.height.equalTo(20.0)
      make.trailing.equalTo(self.doorView.snp.trailing).inset(15.0)
      make.top.equalTo(self.doorView.snp.top).offset(40.0)
    }
    
    self.shiftSignView.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(self.rodrigoSignView.snp.size)
      make.centerX.equalTo(self.rodrigoSignView.snp.centerX)
      make.top.equalTo(self.rodrigoSignView.snp.bottom).offset(8.0)
    }
    
    self.posseSignView.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(self.rodrigoSignView.snp.size)
      make.centerX.equalTo(self.rodrigoSignView.snp.centerX)
      make.top.equalTo(self.shiftSignView.snp.bottom).offset(8.0)
    }

    self.rodrigoLabel.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.rodrigoSignView.snp.edges)
    }
    
    self.shiftLabel.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.shiftSignView.snp.edges)
    }
    
    self.posseLabel.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.posseSignView.snp.edges)
    }
    
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.wallView)
    self.wallView.addSubview(self.interiorView)
    self.interiorView.addSubview(self.doorView)
    
    self.doorView.addSubview(self.rodrigoSignView)
    self.doorView.addSubview(self.shiftSignView)
    self.doorView.addSubview(self.posseSignView)
    
    self.rodrigoSignView.addSubview(self.rodrigoLabel)
    self.shiftSignView.addSubview(self.shiftLabel)
    self.posseSignView.addSubview(self.posseLabel)
  }
  
  internal func setupDoorAsButton() {
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Day6ViewController.toggleDoor))
    self.doorView.addGestureRecognizer(tapGesture)
  }
  
  internal func degreeToRad(_ x: Double) -> Double {
    return (x * (M_PI / 180.0))
  }
  
  internal func toggleDoor() {
    let angleAsRads: Double = self.degreeToRad(75.0)
    self.doorView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
    self.doorView.layer.position = CGPoint(x: self.doorView.layer.bounds.maxX + 4.0, y: self.doorView.layer.bounds.midY + 4.0)
    
    if !self.isOpen {
      let doorOpenTransform: CATransform3D = CATransform3DMakeRotation( CGFloat(angleAsRads), 0.0, 1.0, 0.0)
      
      UIView.animate(withDuration: 1.75, animations: { () -> Void in
        self.doorView.layer.transform = doorOpenTransform
        }, completion: { (complete: Bool) -> Void in
          if complete {
            self.isOpen = true
          }
      }) 
    } else {
      UIView.animate(withDuration: 1.75, animations: { () -> Void in
        self.doorView.layer.transform = CATransform3DIdentity
        }, completion: { (complete: Bool) -> Void in
          if complete {
            self.isOpen = false
          }
      }) 

    }

  }
  

}
