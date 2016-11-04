//
//  ScondViewController.swift
//  YLCycleViewDemo
//
//  Created by shuogao on 2016/11/2.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class ScondViewController: UIViewController,YLCycleViewDelegate,YLSinglerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        self.automaticallyAdjustsScrollViewInsets = false


        let images = ["http://c.hiphotos.baidu.com/image/pic/item/b58f8c5494eef01f50d40bbee5fe9925bd317d8c.jpg", "1", "2", "3", "4"]
        let titles = ["Raindew","无限轮播", "QQ群：511860085", "欢迎加入", "帅的人已经Star"]
        //创建无限轮播
        let cycleView = YLCycleView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 150), images: images, titles: titles)
        cycleView.delegate = self;
        //        cycleView.pageControl.pageIndicatorTintColor = .white
        //        cycleView.pageControl.currentPageIndicatorTintColor = .darkGray
        view.addSubview(cycleView)


        let singlerView = YLSinglerowView(frame: CGRect(x: 50, y: 350, width: 200, height: 30), scrollStyle: .up, roundTime: 5, contentSource: ["这是一条重大新闻","吃货节到了钱包准备好了吗","独家福利来就送!"], tagSource: ["新闻", "吃货节", "福利"])
        singlerView.delegate = self
        //更多公开属性自行查找
        //        singlerView.backColor = .darkGray
        //        singlerView.contentTextColor = .purple
        //        singlerView.tagBackgroundColors = [.white,.yellow,.cyan]
        //        singlerView.tagTextColors = [.red,.blue,.black]

        view.addSubview(singlerView)


    }
    //MARK: -- YLCycleViewDelegate
    func  clickedCycleView(_ cycleView : YLCycleView, selectedIndex index: Int) {

        print("点击了第\(index)页")
    }


    //MARK: -- YLSinglerViewDelegate

    func singlerView(_ singlerowView: YLSinglerowView, selectedIndex index: Int) {
        
        print("点击了第\(index)个数据")
        
    }
    
    deinit {
        print("scond控制器销毁了")
    }
    
}
