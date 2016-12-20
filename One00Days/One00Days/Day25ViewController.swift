//
//  Day25ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/16/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day25ViewController: UIViewController {
  lazy var circularGradientView: UIView = {
  let view: UIView = UIView()
    view.backgroundColor = ColorSwatch.sr_mediumTeal
  return view
  }()
  
  
  lazy var gView: GradientView = {
  let view: GradientView = GradientView()
  
  return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    
    setupViewHierarchy()
    configureConstraints()
    
    let g: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Day25ViewController.addAnimation(_:)))
    self.gView.addGestureRecognizer(g)
  }
  
  internal func addAnimation(_ sender: AnyObject?) {
    
    let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
    UIView.animate(withDuration: 2.0, animations: { () -> Void in
      self.view.transform = scaleTransform
    }) 
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  internal func configureConstraints() {
    circularGradientView.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
      make.size.equalTo(180.0+&180.0)
    }
    
    gView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view)
    }
    
    self.view.layoutIfNeeded()
  }
  
  
  internal func setupViewHierarchy() {
    self.view.addSubview(circularGradientView)
    self.view.addSubview(gView)
  }
}

