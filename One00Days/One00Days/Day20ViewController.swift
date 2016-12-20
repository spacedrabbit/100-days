//
//  Day20ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/11/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day20ViewController: UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = ColorSwatch.sr_coolWhite
    
    self.setupViewHierarchy()
    self.configureConstraints()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  internal func configureConstraints() {
    
    self.topContainterView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view.snp.top)
      make.left.equalTo(self.view.snp.left)
      make.right.equalTo(self.view.snp.right)
      make.height.equalTo(200.0)
    }
    
    self.bottomContainerView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.topContainterView.snp.bottom)
      make.left.equalTo(self.view.snp.left)
      make.right.equalTo(self.view.snp.right)
      make.bottom.equalTo(self.view.snp.bottom)
    }
    
    self.libraryScrollView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(topContainterView.snp.edges)
    }
    
    self.gridScrollView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(bottomContainerView.snp.edges)
    }
    
    self.topStackView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.libraryScrollView)
      make.height.equalTo(self.topContainterView)
    }
    
    self.bottomStackView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.gridScrollView.snp.edges)
      make.height.equalTo(self.bottomContainerView)
    }
    
    for stackedView in self.topStackView.arrangedSubviews {
      stackedView.snp.makeConstraints({ (make) -> Void in
        make.size.equalTo(CGSize(width: 175.0, height: 175.0))
      })
    }
    
    for stackView in self.bottomStackView.arrangedSubviews {
      if let actualStackView: UIStackView = stackView as? UIStackView {
        for arrangedView in actualStackView.arrangedSubviews {
          arrangedView.snp.makeConstraints({ (make) -> Void in
            make.size.equalTo(CGSize(width: 75.0, height: 75.0))
          })
        }
      }
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(topContainterView)
    self.view.addSubview(bottomContainerView)
    
    self.topContainterView.addSubview(libraryScrollView)
    self.bottomContainerView.addSubview(gridScrollView)
    
    self.libraryScrollView.addSubview(topStackView)
    self.gridScrollView.addSubview(bottomStackView)
    
    self.bottomStackView.addArrangedSubview(bottomStackViewRow1)
    self.bottomStackView.addArrangedSubview(bottomStackViewRow2)
    self.bottomStackView.addArrangedSubview(bottomStackViewRow3)

    for _ in 1...25 {
      self.topStackView.addArrangedSubview(randomColorView())
      
      for _ in 1...self.bottomStackView.arrangedSubviews.count {
        self.bottomStackViewRow1.addArrangedSubview(randomColorView())
        self.bottomStackViewRow2.addArrangedSubview(randomColorView())
        self.bottomStackViewRow3.addArrangedSubview(randomColorView())
      }
    }
   
    self.view.layoutIfNeeded()
  }
  
  
  internal func randomColorView() -> UIView {
    
    let view: UIView = UIView()
    view.backgroundColor = UIColor.init(red: CGFloat(Double(arc4random_uniform(255))/255.0), green: CGFloat(Double(arc4random_uniform(255))/255.0), blue: CGFloat(Double(arc4random_uniform(255))/255.0), alpha: 1.0)
    return view
  }
  
  // MARK: - Lazys
  
  //alignments
  lazy var topContainterView: UIView = {
    let view: UIView = UIView()
    return view
  }()
  
  lazy var bottomContainerView: UIView = {
    let view: UIView = UIView()
    return view
  }()
  
  
  // scrolls
  lazy var libraryScrollView: UIScrollView = {
    let view: UIScrollView = UIScrollView()
    view.backgroundColor = UIColor.yellow
    return view
  }()
  
  lazy var gridScrollView: UIScrollView = {
    let view: UIScrollView = UIScrollView()
    view.backgroundColor = UIColor.red
    return view
  }()
  
  
  // top stack
  lazy var topStackView: UIStackView = {
    let view: UIStackView = UIStackView()
    view.distribution = .equalSpacing
    view.alignment = .center
    view.axis = .horizontal
    return view
  }()
  
  // bottom stack
  lazy var bottomStackView: UIStackView = {
    let view: UIStackView = UIStackView()
    
    view.distribution = .fillEqually
    view.alignment = .fill
    view.axis = .vertical
    
    return view
  }()
  
  // bottom rows
  lazy var bottomStackViewRow1: UIStackView = {
    let view: UIStackView = UIStackView()
    
    view.distribution = .equalSpacing
    view.alignment = .center
    view.axis = .vertical
    
    return view
  }()
  
  lazy var bottomStackViewRow2: UIStackView = {
    let view: UIStackView = UIStackView()
    
    view.distribution = .equalSpacing
    view.alignment = .center
    view.axis = .horizontal

    return view
  }()
  
  lazy var bottomStackViewRow3: UIStackView = {
    let view: UIStackView = UIStackView()
    
    view.distribution = .equalSpacing
    view.alignment = .center
    view.axis = .horizontal
    
    return view
  }()
  
}
