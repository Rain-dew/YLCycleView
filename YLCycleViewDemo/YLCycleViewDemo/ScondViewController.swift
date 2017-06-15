//
//  ScondViewController.swift
//  YLCycleViewDemo
//
//  Created by shuogao on 2016/11/2.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class ScondViewController: UIViewController {

    //  MARK: Lifecycle
    deinit {
        print("scond控制器销毁了")
    }

    //  MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        self.automaticallyAdjustsScrollViewInsets = false


        let images = ["http://c.hiphotos.baidu.com/image/pic/item/b58f8c5494eef01f50d40bbee5fe9925bd317d8c.jpg", "1", "2", "3", "4"]
        let titles = ["Raindew","无限轮播", "QQ群：511860085", "欢迎加入", "帅的人已经Star"]
        //  创建无限轮播
        let cycleView = YLCycleView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 150), images: images, titles: titles)
        cycleView.delegate = self;
//        cycleView.pageControl.pageIndicatorTintColor = .white
//        cycleView.pageControl.currentPageIndicatorTintColor = .darkGray
        view.addSubview(cycleView)


        let singlerView = YLSinglerowView(frame: CGRect(x: 50, y: 280, width: 200, height: 30), scrollStyle: .up, roundTime: 5, contentSource: ["这是一条重大新闻","吃货节到了钱包准备好了吗","独家福利来就送!"], tagSource: ["新闻", "吃货节", "福利"])
        singlerView.delegate = self
        //  更多公开属性自行查找
//        singlerView.backColor = .darkGray
//        singlerView.contentTextColor = .purple
//        singlerView.tagBackgroundColors = [.white,.yellow,.cyan]
//        singlerView.tagTextColors = [.red,.blue,.black]

        view.addSubview(singlerView)
        let menuView = YLMenuView.ylMenuView()
        menuView.frame = CGRect(x: 10, y: 320, width: self.view.bounds.width - 20, height: 250)
        menuView.delegate = self
        menuView.imageArray = ["http://tx.haiqq.com/uploads/allimg/150322/021422Lb-10.jpg",
                               "http://img.wzfzl.cn/uploads/allimg/150522/co150522214536-15.jpg",
                               "http://img.wzfzl.cn/uploads/allimg/150119/co150119220K2-18.jpg",
                               "http://uploads.xuexila.com/allimg/1608/704-160Q5100Z6.jpg",
                               "http://tx.haiqq.com/uploads/allimg/150326/1P4511163-9.jpg",
                               "http://tx.haiqq.com/uploads/allimg/150323/15135032M-1.jpg",
                               "http://img.wzfzl.cn/uploads/allimg/150522/co150522214536-15.jpg",
                               "http://img.wzfzl.cn/uploads/allimg/150119/co150119220K2-18.jpg",
                               "http://uploads.xuexila.com/allimg/1608/704-160Q5100Z6.jpg",
                               "http://tx.haiqq.com/uploads/allimg/150326/1P4511163-9.jpg",
                               "http://tx.haiqq.com/uploads/allimg/150323/15135032M-1.jpg",
                               "http://tx.haiqq.com/uploads/allimg/150323/15135032M-1.jpg",
                               "1"
        ]
        menuView.titleArray = ["http", "2345", "345", "uploads", "2345", "allimg", "34545", "uploads", "345", "http", "uploads", "uploads", "uploads"]
//                menuView.itemsOfPage = 6
//        menuView.imageViewSize = CGSize(width: 60, height: 60)
//        menuView.pageControl.pageIndicatorTintColor = .white
//        menuView.pageControl.currentPageIndicatorTintColor = .darkGray
        view.addSubview(menuView)
    }
}

//  MARK: - YLCycleViewDelegate
extension ScondViewController: YLCycleViewDelegate {
    func  clickedCycleView(_ cycleView : YLCycleView,
                           selectedIndex index: Int)
    {
        print("点击了第\(index)页")
    }
}

//  MARK: YLSinglerViewDelegate
extension ScondViewController: YLSinglerViewDelegate {
    func singlerView(_ singlerowView: YLSinglerowView,
                     selectedIndex index: Int)
    {
        print("点击了第\(index)个数据")
    }
}

//  MARK: YLMenuViewDelegate
extension ScondViewController: YLMenuViewDelegate {
    func menuView(_ menuView : YLMenuView,
                  selectedPage: Int,
                  indexInPage index: Int,
                  indexInAllData : Int)
    {
        //  为方便数组计算，数据由0起算
    }
}
