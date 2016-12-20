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

open class Random {
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
    stack.axis = .vertical
    stack.alignment = .fill
    stack.distribution = .equalSpacing
    return stack
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    configureConstraints()
    addTapGestureToView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func addTapGestureToView () {
    let g: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Day22ViewController.didTapTransformView(_:)))
    self.transformView.addGestureRecognizer(g)
  }
  
  internal func didTapTransformView(_ sender: AnyObject?) {
    if let tapG: UITapGestureRecognizer = sender as? UITapGestureRecognizer {
      if tapG.view == self.transformView {
        self.getCurrentSliderValuesAndAnimate()
      }
    }
  }
  
  internal func addTransform(_ transform: CATransform3D?) {
    self.transformView.layer.transform = CATransform3DIdentity
    if var t = transform {
//      t.m41 = 0.0
//      t.m42 = 0.40
//      t.m43 = 0.40
//      t.m44 = 0.0
      
      t.m23 = -1.0
//      t.m31 = -1.0
//      t.m34 = -1.0
//      t.m33 = -0.5
//      print("\(t)")
      let originalFrame: CGRect = self.transformView.layer.frame
      let originalBounds: CGRect = self.transformView.layer.bounds
      
      self.transformView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
//      self.transformView.layer.position = CGPointMake(CGRectGetMinX(self.transformView.frame) - CGRectGetMidX(self.transformView.bounds), CGRectGetMinY(self.transformView.frame) - CGRectGetMidY(self.transformView.bounds))
      UIView.animate(withDuration: 3.0, delay: 0.0, options: [.layoutSubviews], animations: { () -> Void in
        self.transformView.layer.transform = t
        }, completion: { (complete: Bool) -> Void in
          self.transformView.layer.frame = originalFrame
          self.transformView.layer.position = originalFrame.origin
      })
    }
  }
  
  internal func getCurrentSliderValuesAndAnimate() {
    var trans: CATransform3D?
    for slider in self.stackView.arrangedSubviews {
      if let actuallyASlider: UISlider = slider as? UISlider {
          self.updateTransform(&trans, slider: actuallyASlider)
      }
    }
//    print("\(trans)")
    self.addTransform(trans)
  }
  
  internal func updateTransform(_ transform: inout CATransform3D?, slider: UISlider) {
    if var t = transform {
      switch slider.tag {
      case MatrixKey.M31:
        t.m31 = CGFloat(slider.value)
        print("M31: \(slider.value)")
        
      case MatrixKey.M32:
        t.m32 = CGFloat(slider.value)
        print("M32: \(slider.value)")
        
      case MatrixKey.M33:
        t.m33 = CGFloat(slider.value)
        print("M33: \(slider.value)")
        
      case MatrixKey.M34:
        t.m34 = CGFloat(slider.value)
        print("M34: \(slider.value)\n\n")
        
      default:
        print("unknown slider tag")
      }
    } else {
      print("identity")
      transform = CATransform3DIdentity
      self.updateTransform(&transform, slider: slider)
    }
  }
  
  internal func configureConstraints() {
    
    self.gridView.snp.makeConstraints { (make) -> Void in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(400.0)
    }
    
    self.transformView.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.gridView)
      make.size.equalTo(CGSize(width: 150.0, height: 150.0))
    }
    
    self.stackView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.gridView.snp.bottom)
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
