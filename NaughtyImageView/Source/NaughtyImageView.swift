//
//  NaughtyImageView.swift
//
//
//  Created by kevinzhow on 15/7/13.
//
//

import UIKit

open class NaughtyImageView: UIImageView {
    
    open var horizontalImages: Int!
    
    open var verticalImages: Int!
    
    var floatingImage: UIImageView!
    
    var positionMatrix = [CGPoint(x: 0, y: 0)]
    
    open var currentIndex = 0 {
        didSet {
            
            let location = locateFrame(currentIndex)
            
            floatingImage.frame = CGRect(x: -location.x * frame.width, y: -location.y * frame.height, width: floatingImage.frame.width, height: floatingImage.frame.height)
        }
    }
    
    var displayLink: CADisplayLink!
    
    open var naughtyAnimating = false
    
    open var frameSkip = 0
    
    fileprivate var frameCount = 0
    
    open var loop = true
    
    fileprivate var finished = false
    
    open var naughtyAnimationDidStop: ((Bool) -> Void)?
    
    open var debug = false {
        didSet {
            if debug {
                clipsToBounds = false
                layer.borderColor = UIColor.red.cgColor
                layer.borderWidth = 1.0
            } else {
                clipsToBounds = true
            }
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initFloatingImageView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFloatingImageView()
    }
    
    func initFloatingImageView() {
        floatingImage = UIImageView(frame: CGRect.zero)
        addSubview(floatingImage)
    }
    
    open func setupWithImage(_ newImage: UIImage, horizontalImages: Int, verticalImages: Int) {
        
        if !debug {
            clipsToBounds = true
        }
        
        floatingImage.frame = CGRect(x: 0, y: 0, width: frame.width * CGFloat(horizontalImages), height: frame.height * CGFloat(verticalImages))
        
        floatingImage.image = newImage
        
        self.horizontalImages = horizontalImages
        self.verticalImages = verticalImages
        
        floatingImage.contentMode = .topLeft
        
        var index = 1
        
        var tempX = 1
        
        var tempY = 0
        
        while index <= (horizontalImages * verticalImages - 1) {
            
            positionMatrix.append(CGPoint(x: tempX, y: tempY))
            
            if tempX + 1 > horizontalImages - 1 {
                tempX = 0
                tempY += 1
            } else {
                tempX += 1
            }
            
            index += 1
        }
        
        #if DEBUG
            println("\(horizontalImages) \(verticalImages)")
            println(positionMatrix)
        #endif
        
    }
    
    func locateFrame(_ frameIndex: Int) -> CGPoint {
        
        let location: CGPoint = positionMatrix[frameIndex]
        
        return location
    }
    
    open func toNewFrame(_ frameIndex: Int) {
        
        if frameIndex + 1 <= positionMatrix.count {
            currentIndex = frameIndex
        } else {
            if loop {
                currentIndex = 0
            } else {
                finished = true
                stopNaughtyAnimation()
            }
            
        }
    }
    
    open func startNaughtyAnimation() {
        finished = false
        naughtyAnimating = true
        displayLink = CADisplayLink(target: self, selector: #selector(NaughtyImageView.callbackNaughtyAnimation))
        displayLink.add(to: .current, forMode: .common)
    }
    
    @objc open func callbackNaughtyAnimation() {
        
        if frameCount == frameSkip {
            toNewFrame(currentIndex + 1)
            frameCount = 0
        } else {
            frameCount += 1
        }
        
    }
    
    open func stopNaughtyAnimation() {
        naughtyAnimating = false
        displayLink.invalidate()
        
        if let naughtyAnimationDidStop = naughtyAnimationDidStop {
            naughtyAnimationDidStop(finished)
        }
        
    }
}
