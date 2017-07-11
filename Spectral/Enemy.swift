//
//  Enemy.swift
//  Spectral
//
//  Created by Forrest on 7/9/17.
//  Copyright © 2017 Forrest. All rights reserved.
//

import UIKit
import SceneKit


//  Enemy is a box for now.
class Enemy: SCNNode {
    override init() {
        super.init()
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        self.geometry = box
        let shape = SCNPhysicsShape(geometry: box, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        self.physicsBody?.categoryBitMask = CollisionCategory.enemy.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.bullets.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
