//
//  UnOfficialDay44ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 5/1/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import Foundation
import UIKit

class UnOfficialDay44ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  
  internal func configureConstraints() {
    self.backgroundView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view)
    }
    
    self.theSunView.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(self.backgroundView)
      make.size.equalTo(CGSize(width: 150.0, height: 150.0))
      make.top.equalTo(self.backgroundView.snp.centerY)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(backgroundView)
    self.backgroundView.addSubview(theSunView)
  }
  
  // MARK: - Lazy
  lazy var backgroundView: BackgroundView = {
    let view: BackgroundView = BackgroundView(forTimeOfDay: .afternoon)
    return view
  }()
  
  lazy var theSunView: TheSunView = {
    let view: TheSunView = TheSunView()
    return view
  }()
  
}
