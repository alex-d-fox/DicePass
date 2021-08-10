//
//  ViewController.swift
//  DicePass
//
//  Created by Alexander Fox on 9/24/16.
//  Copyright © 2016 Alex Fox. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    var sceneView: SCNView {
        return self.view as! SCNView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        
        let scene = SCNScene()
        let die = Die(random: false)
        let die2 = Die(random: true)

        die.position.x = 0
        die2.position.x = 20
        die.position.y = 0
        die2.position.y = 0
        
        scene.rootNode.addChildNode(light(type: SCNLight.LightType.omni, color: UIColor.white, position: SCNVector3Make(0, 50, 50)))
        scene.rootNode.addChildNode(light(type: SCNLight.LightType.ambient, color: UIColor.white, position: SCNVector3Make(0, 50, 50)))
        
        scene.rootNode.addChildNode(die)
        scene.rootNode.addChildNode(die2)
        
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.scene = scene
        sceneView.backgroundColor = .black
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let move = SCNAction.rotateBy(x: CGFloat(Float(arc4random()).truncatingRemainder(dividingBy: 360)), y: CGFloat(Float(arc4random()).truncatingRemainder(dividingBy: 360)), z: CGFloat(Float(arc4random()).truncatingRemainder(dividingBy: 360)), duration: 3)
            self.sceneView.scene?.rootNode.childNode(withName: "NumbersDie" ,recursively: false)?.runAction(move)
            self.sceneView.scene?.rootNode.childNode(withName: "RandomDie" ,recursively: false)?.runAction(move)
        }
    }
    
    func light(type: SCNLight.LightType, color: UIColor, position: SCNVector3) -> SCNNode {
        let light = SCNNode()
        light.light = SCNLight()
        light.light!.type = type
        light.light!.color = color
        light.position = position
        light.castsShadow = true
        return light
    }
    
}
