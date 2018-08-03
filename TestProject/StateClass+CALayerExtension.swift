//
//  StateClass+CALayerExtension.swift
//  TestProject
//
//  Created by Ibrahim Hassan on 04/08/18.
//  Copyright © 2018 Ibrahim Hassan. All rights reserved.
//

//
//  Swift-File.swift
//  TestObj-C
//
//  Created by Ibrahim Hassan on 04/08/18.
//  Copyright © 2018 Ibrahim Hassan. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class StateView : UIView {
    
    let maskImageView = UIImageView()
    
    @IBInspectable
    var maskImage : UIImage? {
        didSet {
            maskImageView.image = maskImage
            mask = maskImageView
        }
    }
    
    @IBInspectable
    var stateName : String?
    
    override func layoutSubviews() {
        maskImageView.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        maskImageView.frame = bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        if let color : CGColor = self.layer.colorOfPoint(point: location) {
            if (color.alpha != 0) {
                print ("Touched \(String(describing: stateName))")
            }
        }
    }
}

extension CALayer {
    
    func colorOfPoint(point:CGPoint) -> CGColor {
        
        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context!.translateBy(x: -point.x, y: -point.y)
        
        self.render(in: context!)
        
        let red: CGFloat   = CGFloat(pixel[0]) / 255.0
        let green: CGFloat = CGFloat(pixel[1]) / 255.0
        let blue: CGFloat  = CGFloat(pixel[2]) / 255.0
        let alpha: CGFloat = CGFloat(pixel[3]) / 255.0
        
        let color = UIColor(red:red, green: green, blue:blue, alpha:alpha)
        
        return color.cgColor
    }
}

