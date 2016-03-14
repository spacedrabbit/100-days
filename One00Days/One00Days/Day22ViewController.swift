//
//  Day22ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/13/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

internal struct MatrixKey {
  static let M31: Int = 1
  static let M32: Int = 2
  static let M33: Int = 3
  static let M34: Int = 4
}

public class Random {
  class func Color() -> UIColor {
    return UIColor.init(red: CGFloat(Double(arc4random_uniform(255))/255.0), green: CGFloat(Double(arc4random_uniform(255))/255.0), blue: CGFloat(Double(arc4random_uniform(255))/255.0), alpha: 1.0)
  }
}

class Day22ViewController: UIViewController {
  
  lazy var gridView: GridView = {
    let grid: GridView = GridView()
    return grid
  }()
  
  lazy var transformView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = ColorSwatch.sr_mediumTeal
    return view
  }()
  
  lazy var stackView: UIStackView = {
    let stack: UIStackView = UIStackView()
    stack.axis = .Vertical
    stack.alignment = .Fill
    stack.distribution = .EqualSpacing
    return stack
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    configureConstraints()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func addTapGestureToView () {
    let g: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTapTransformView:")
  }
  
  internal func didTapTransformView(sender: AnyObject?) {
    
  }
  
  internal func configureConstraints() {
    
    self.gridView.snp_makeConstraints { (make) -> Void in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(400.0)
    }
    
    self.transformView.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.gridView)
      make.size.equalTo(CGSizeMake(150.0, 150.0))
    }
    
    self.stackView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.gridView.snp_bottom)
      make.left.bottom.right.equalTo(self.view).inset(10.0)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(gridView)
    self.view.addSubview(stackView)
    self.gridView.addSubview(transformView)
    
    for idx in 1...4 {
      let sliderView: UISlider = UISlider()
      sliderView.minimumValue = -1.0
      sliderView.maximumValue = 1.0
      sliderView.setValue(0.0, animated: false)
      sliderView.minimumTrackTintColor = Random.Color()
      sliderView.tag = idx
      self.stackView.addArrangedSubview(sliderView)
    }
  }
  
}
