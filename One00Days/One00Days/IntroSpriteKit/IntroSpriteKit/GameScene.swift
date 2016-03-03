//
//  GameScene.swift
//  IntroSpriteKit
//
//  Created by Louis Tur on 3/2/16.
//  Copyright (c) 2016 SRLabs. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -4.9) 
      
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
      for touch in touches {
        let sprite: StarNode = StarNode.star(touch.locationInNode(self))
        self.addChild(sprite)
      }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
