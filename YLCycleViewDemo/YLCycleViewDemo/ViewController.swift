//
//  ViewController.swift
//  YLCycleViewDemo
//
//  Created by shuogao on 2016/11/1.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,YLCycleViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray


        let images = ["http://c.hiphotos.baidu.com/image/pic/item/b58f8c5494eef01f50d40bbee5fe9925bd317d8c.jpg", "1", "2", "3", "4"]
        let titles = ["Raindew","无限轮播", "QQ群：511860085", "欢迎加入", "喜欢请Star"]
        let cycleView = YLCycleView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 150), images: images, titles: titles)
        cycleView.delegate = self;
        view.addSubview(cycleView)

    }

    func  clickedCycleView(_ cycleView : YLCycleView, selectedIndex index: Int) {

        print("点击了第\(index)页")
    }
    
}
