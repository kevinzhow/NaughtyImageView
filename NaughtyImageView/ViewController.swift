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
    
    var starImageView = NaughtyImageView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starImageView.frame = CGRect(x: view.frame.width/2.0 - 32/2.0, y: 100, width: 32, height: 32)
        
        starImageView.debug = false
        
        view.addSubview(starImageView)
        
        starImageView.setupWithImage(UIImage(named: "fav")!, horizontalImages: 8, verticalImages: 12)
        
        slider.maximumValue = Float(starImageView.horizontalImages * starImageView.verticalImages) - 1
        
        slider.value = 0
        
        slider.isContinuous = true
        
        slider.addTarget(self, action: #selector(ViewController.valueChanged(_:)), for: UIControl.Event.valueChanged)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func valueChanged(_ slider: UISlider) {
        
        let frameIndex = Int(slider.value)
        
        starImageView.toNewFrame(frameIndex)
        
        
    }

    @IBAction func start(_ sender: AnyObject) {
        if starImageView.naughtyAnimating {
            starImageView.stopNaughtyAnimation()
        } else {
            starImageView.startNaughtyAnimation()
        }

    }

}

