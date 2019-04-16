//
//  ViewController.swift
//  test-impact
//
//  Created by JG Development  on 4/16/19.
//  Copyright © 2019 in.geesl.justin. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let motion = CMMotionManager()
    var queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motion.startDeviceMotionUpdates()
        startQueuedUpdates()
    }

    func startQueuedUpdates() {
        print("Starting to get queued updates..")
        if motion.isDeviceMotionAvailable {
            self.motion.deviceMotionUpdateInterval = 5.0 / 60.0
            self.motion.showsDeviceMovementDisplay = true
            self.motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical,
                                                 to: self.queue, withHandler: { (data, error) in
                // Make sure the data is valid before accessing it.
                if let validData = data {
                    let maxAccel = abs(validData.userAcceleration.z)
                    
                    if (maxAccel > 1) {
                        print("OUCH! Are you okay?");
                    }
                    
                    
                }
            })
        }
        else {
            print("Device Motion not available")
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
//        motion.stopDeviceMotionUpdates()
    }
}

