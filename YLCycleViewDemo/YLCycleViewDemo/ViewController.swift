//
//  ViewController.swift
//  YLCycleViewDemo
//
//  Created by Raindew on 2016/11/1.
//  Copyright © 2016年 Raindew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    @IBAction func button(_ sender: Any) {
        navigationController?.pushViewController(ScondViewController(), animated: true)
    }
}
