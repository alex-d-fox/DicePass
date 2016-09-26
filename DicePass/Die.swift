//
//  Die.swift
//  DicePass
//
//  Created by Alexander Fox on 9/24/16.
//  Copyright © 2016 Alex Fox. All rights reserved.
//

import UIKit
import SceneKit

class Die: SCNNode {
    
    private let imageNamed = [ "dog", "cat", "snail" ]
    private let numbers = [ "one", "two", "three", "four", "five", "six"]
    
    init(random: Bool) {
        super.init()
        let boxSide :CGFloat = 15.0
        let box :SCNBox = SCNBox.init(width: boxSide, height: boxSide, length: boxSide, chamferRadius: 1)
        if random {
            box.materials = [material(color: randomColor()),material(color: randomColor()),material(color: randomColor()),material(color: randomColor()),material(color: randomColor()),material(color: randomColor())]
            self.name = "RandomDie"
        }
        else {
            let myColor = randomColor()
            box.materials = [material(color: myColor, named: numbers[0]),material(color: myColor, named: numbers[1]),material(color: myColor, named: numbers[2]),material(color: myColor, named: numbers[3]),material(color: myColor, named: numbers[4]),material(color: myColor, named: numbers[5])]
            self.name = "NumbersDie"
        }
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 100)
        self.addChildNode(cameraNode)
        self.geometry = box
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func material(color: UIColor? = UIColor.white, named: String? = "") -> SCNMaterial {
        let material = SCNMaterial()
        var image = UIImage()
        if named != "" {
            image = UIImage(named: named!)!
        } else {
            let i = Int(arc4random()) % imageNamed.count
            image = UIImage(named: imageNamed[i])!
        }
        material.diffuse.contents = image.imageWithColor(color: color!)
        material.locksAmbientWithDiffuse = true
        return material
    }
    
    func randomColor() -> UIColor {
        let hue = CGFloat(arc4random()).truncatingRemainder(dividingBy:256) / 256.0
        let saturation = CGFloat(arc4random()).truncatingRemainder(dividingBy:128) / 256.0  + 0.5
        let brightness = CGFloat(arc4random()).truncatingRemainder(dividingBy:128) / 256.0  + 0.5
        let color = UIColor.init(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        return color
    }
    
}

extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
