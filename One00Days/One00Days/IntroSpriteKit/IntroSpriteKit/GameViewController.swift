//
//  GameViewController.swift
//  IntroSpriteKit
//
//  Created by Louis Tur on 3/2/16.
//  Copyright (c) 2016 SRLabs. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

  var lastRotation = CGFloat(0.0)
  @IBAction func rotationGesture(sender: UIRotationGestureRecognizer) {
    if(sender.state == UIGestureRecognizerState.Ended) {
      lastRotation = 0.0;
      return
    }
    
    let rotation = 0.0 - (sender.rotation - lastRotation)
    let trans = CGAffineTransformMakeRotation(rotation)
    
    let skView = self.view as! SKView
    if let skScene = skView.scene {
      let newGravity = CGPointApplyAffineTransform(CGPointMake(skScene.physicsWorld.gravity.dx, skScene.physicsWorld.gravity.dy), trans)
      skScene.physicsWorld.gravity = CGVectorMake(newGravity.x, newGravity.y)
    }
    
    lastRotation = sender.rotation
    
  }
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .Portrait
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
