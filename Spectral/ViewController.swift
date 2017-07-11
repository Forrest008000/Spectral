//
//  ViewController.swift
//  Spectral
//
//  Created by Forrest on 7/9/17.
//  Copyright © 2017 Forrest. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        //Creating an empty scene.
        let scene = SCNScene()
        
        sceneView.scene = scene
        sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = ARWorldTrackingSessionConfiguration.PlaneDetection.horizontal
        
        sceneView.session.run(configuration)
    }
    
    func addNewEnemy() {
        let cubeNode = Enemy()
        
        let posX = floatBetween(-0.5, and: 0.5)
        let posY = floatBetween(-0.5, and: 0.5  )
        cubeNode.position = SCNVector3(posX, posY, -1) // SceneKit/AR coordinates are in meters
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    func floatBetween(_ first: Float,  and second: Float) -> Float {
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
    
    func getUserDirection() -> SCNVector3 {
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform)
            return SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
        }
        return SCNVector3(0, 0, -1)
    }
    
    //Better delegate name needed.
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        contact.nodeA.removeFromParentNode()
        contact.nodeB.removeFromParentNode()
        print("Hit ship!")
        self.addNewEnemy()
        
    }

}

struct CollisionCategory: OptionSet {
    let rawValue: Int
    
    static let bullets  = CollisionCategory(rawValue: 1 << 0) // 00...01
    static let enemy = CollisionCategory(rawValue: 1 << 1) // 00..10
}

