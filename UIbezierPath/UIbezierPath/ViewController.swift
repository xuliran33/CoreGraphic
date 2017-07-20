//
//  ViewController.swift
//  UIbezierPath
//
//  Created by 徐丽然 on 2017/7/17.
//  Copyright © 2017年 xuliran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        let bezierView = SimpleBezierPathView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height
        ))
        bezierView.backgroundColor = UIColor.white
        self.view.addSubview(bezierView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

