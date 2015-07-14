//
//  NaughtyImageView.swift
//
//
//  Created by kevinzhow on 15/7/13.
//
//

import UIKit

public class NaughtyImageView: UIImageView {

    public var horizontalImages: Int!

    public var verticalImages: Int!

    var floatingImage: UIImageView!

    var positionMatrix = [CGPoint(x: 0, y: 0)]

    public var currentIndex = 0 {
        didSet {

            var location = locateFrame(currentIndex)

            floatingImage.frame = CGRectMake(-location.x * frame.width, -location.y * frame.height, floatingImage.frame.width, floatingImage.frame.height)
        }
    }

    var displayLink: CADisplayLink!

    public var naughtyAnimating = false

    public var frameSkip = 0

    private var frameCount = 0

    public var debug = false {
        didSet {
            if debug {
                clipsToBounds = false
                layer.borderColor = UIColor.redColor().CGColor
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

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFloatingImageView()
    }

    func initFloatingImageView() {
        floatingImage = UIImageView(frame: CGRectZero)
        addSubview(floatingImage)
    }

    public func setupWithImage(newImage: UIImage, horizontalImages: Int, verticalImages: Int) {

        if !debug {
            clipsToBounds = true
        }

        floatingImage.frame = CGRectMake(0, 0, frame.width * CGFloat(horizontalImages), frame.height * CGFloat(verticalImages))

        floatingImage.image = newImage

        self.horizontalImages = horizontalImages
        self.verticalImages = verticalImages

        floatingImage.contentMode = UIViewContentMode.TopLeft

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

        println("\(horizontalImages) \(verticalImages)")

        println(positionMatrix)

    }

    func locateFrame(frameIndex: Int) -> CGPoint {

        var location: CGPoint = positionMatrix[frameIndex]

        return location
    }

    public func toNewFrame(frameIndex: Int) {

        if frameIndex + 1 <= positionMatrix.count {
            currentIndex = frameIndex
        } else {
            currentIndex = 0
        }
    }

    public func startNaughtyAnimation() {
        naughtyAnimating = true
        displayLink = CADisplayLink(target: self, selector: Selector("callbackNaughtyAnimation"))
        displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }

    public func callbackNaughtyAnimation() {

        if frameCount == frameSkip {
            toNewFrame(currentIndex + 1)
            frameCount = 0
        } else {
            frameCount += 1
        }

    }

    public func stopNaughtyAnimation() {
        naughtyAnimating = false
        displayLink.invalidate()
    }
}
