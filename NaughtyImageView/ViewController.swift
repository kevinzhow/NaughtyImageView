//
//  ViewController.swift
//  NaughtyImageView
//
//  Created by kevinzhow on 15/7/13.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    var starImageView = NaughtyImageView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starImageView.frame = CGRectMake(view.frame.width/2.0 - 110.5/2.0, 100, 110.5, 34)
        
        starImageView.debug = false
        
        view.addSubview(starImageView)
        
        starImageView.setupWithImage(UIImage(named: "pull")!, horizontalImages: 10, verticalImages: 27)
        
        slider.maximumValue = Float(starImageView.horizontalImages * starImageView.verticalImages) - 1
        
        slider.value = 0
        
        slider.continuous = true
        
        slider.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func valueChanged(slider: UISlider) {
        
        var frameIndex = Int(slider.value)
        
        starImageView.toNewFrame(frameIndex)
        
        
    }

    @IBAction func start(sender: AnyObject) {
        if starImageView.naughtyAnimating {
            starImageView.stopNaughtyAnimation()
        } else {
            starImageView.startNaughtyAnimation()
        }

    }

}

