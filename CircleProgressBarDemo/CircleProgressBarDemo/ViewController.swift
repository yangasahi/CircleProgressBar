//
//  ViewController.swift
//  CircleProgressBarDemo
//
//  Created by YANG XU on 2018/07/20.
//  Copyright © 2018年 YANG XU. All rights reserved.
//

import UIKit
import CircleProgressBar

class ViewController: UIViewController {

    @IBOutlet weak var circleProgressBar: CircleProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let circlePrigressBarItem1 = CircleProgressBarItem(40.0 / 60.0, strokeWidth: 15, strokeColor: UIColor.green)
        let circlePrigressBarItem2 = CircleProgressBarItem(15.0 / 60.0, strokeWidth: 10, strokeColor: UIColor.black)
        let circlePrigressBarItem3 = CircleProgressBarItem(5.0 / 60.0, strokeWidth: 10, strokeColor: UIColor.brown)
        
        circleProgressBar.add(circlePrigressBarItem1)
        circleProgressBar.add(circlePrigressBarItem2)
        circleProgressBar.add(circlePrigressBarItem3)
        
        circleProgressBar.show()
    }

    @IBAction func refreshProgressBar(_ sender: Any) {
        circleProgressBar.show()
    }
    
}

