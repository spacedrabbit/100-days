//
//  StackTestViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/8/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class StackTestViewController: UIViewController {
  
  lazy var stackView: UIStackView = {
    let stackView: UIStackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    stackView.spacing = 10.0
    return stackView
  }()
  
  lazy var scrollingView: UIScrollView = {
    let scrollView: UIScrollView = UIScrollView()
    scrollView.alwaysBounceHorizontal = false
    scrollView.backgroundColor = UIColor.red
    return scrollView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    
    setupViewHierarchy()
    configureConstraints()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  internal func configureConstraints() {
    
    scrollingView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view.snp.edges)
    }
    
    stackView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.scrollingView.snp.edges)
    }
    
    for view in stackView.arrangedSubviews {
      view.snp.makeConstraints({ (make) -> Void in
        make.size.equalTo(CGSize(width: self.view.bounds.width, height: 200.0))
      })
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(scrollingView)
    self.scrollingView.addSubview(stackView)
    
    let viewsArray: [UIView] = [createView(), createView(), createView(), createView(), createView(), createView(), createView()]
    for (idx, view) in viewsArray.enumerated() {
      view.tag = idx
      self.stackView.addArrangedSubview(view)
    }
    
  }
  
  internal func createView() -> UIView {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.init(red: CGFloat(Double(arc4random_uniform(255))/255.0), green: CGFloat(Double(arc4random_uniform(255))/255.0), blue: CGFloat(Double(arc4random_uniform(255))/255.0), alpha: 1.0)
    return view
  }

}
