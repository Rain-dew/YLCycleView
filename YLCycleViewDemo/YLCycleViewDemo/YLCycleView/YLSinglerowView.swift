//
//  YLSinglerowView.swift
//  YLCycleViewDemo
//
//  Created by Raindew on 2016/11/3.
//  Copyright © 2016年 Raindew. All rights reserved.
//

import UIKit
fileprivate let kSingCellId = "kSingCellId"
//代理
protocol YLSinglerViewDelegate : class {
    func singlerView(_ singlerowView : YLSinglerowView, selectedIndex index: Int)
}
class YLSinglerowView: UIView {
    //枚举
    enum ScrollStyle {//滚动方式
        case right //向右滚动
        case left  //向左滚动
        case up    //向上滚动
        case down  //向下滚动
    }
//MARK: --属性
    fileprivate var style : ScrollStyle?
    fileprivate var singlerTimer : Timer?
    fileprivate var time : Double?
    fileprivate var index : CGFloat?
//MARK: -- 公开的属性===============================================
    //背景颜色
    var backColor : UIColor? {
        didSet {
            collectionView.backgroundColor = backColor
        }
    }
    var contentTextColor : UIColor = .white
    var contentFont : UIFont = .systemFont(ofSize: 13)
    var tagFont : UIFont = .systemFont(ofSize: 11)
    var tagTextColor : UIColor = .red
    var tagBackgroundColor : UIColor = UIColor(red: 230/255, green: 130/255, blue: 110/255, alpha: 1)
    var tagBackgroundColors : [UIColor]? = [] //如果你设置这个属性，务必保证数组个数和你的数据数组个数相同，否则你将收到程序的crash
    var tagTextColors : [UIColor]? = []       //如果你设置这个属性，务必保证数组个数和你的数据数组个数相同，否则你将收到程序的crash

//================================================================

    weak var delegate : YLSinglerViewDelegate?
//MARK: -- 懒加载

    fileprivate var contentSource : [String]? = [String]()
    fileprivate var tagSource : [String]? = [String]()


    fileprivate lazy var collectionView : UICollectionView = {[weak self] in

        //创建collectionView
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self!.bounds, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1)
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.register(YLSinglerowCell.self, forCellWithReuseIdentifier: kSingCellId)
        return collectionView
        }()

    init(frame: CGRect, scrollStyle : ScrollStyle = .left, roundTime : Double = 4.5, contentSource : [String], tagSource : [String] = []) {
        /** frame scrollStyle contentSource 参数是必须传入的。
         *  其他可不传入，直接删除代码即可
         *  另外tagSource如不传入，则默认不再创建tagLabel这个控件
         */
        super.init(frame: frame)
        self.style = scrollStyle
        self.time = roundTime
        self.contentSource = contentSource
        self.tagSource = tagSource
        setupUI()
    }
    deinit {
        removeSinglerViewTimer()
        print("SinglerView销毁了")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        //设置layout(获取的尺寸准确，所以在这里设置)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        if style == ScrollStyle.right || style == ScrollStyle.left {
            layout.scrollDirection = .horizontal
        }else {
            layout.scrollDirection = .vertical
        }
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        //设置该空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
    }


}
//MARK: -- 设置UI
extension YLSinglerowView {

    fileprivate func setupUI() {

        addSubview(collectionView)
        //滚动到该位置（让用户最开始就可以向左滚动）
        index = CGFloat((contentSource?.count)!) * 5000

        if style == ScrollStyle.right || style == ScrollStyle.left {
            collectionView.setContentOffset(CGPoint(x: collectionView.bounds.width * index!, y: 0), animated: false)

        }else {
            collectionView.setContentOffset(CGPoint(x: 0, y: collectionView.bounds.height * index!), animated: false)
        }
        removeSinglerViewTimer()
        addSinglerViewTimer()
    }
}

//MARK: -- UICollectionViewcontentSource
extension YLSinglerowView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (contentSource?.count ?? 0) * 10000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSingCellId, for: indexPath) as! YLSinglerowCell
        cell.contentLabel?.textColor = contentTextColor
        cell.contentLabel?.text = contentSource![indexPath.row % contentSource!.count]
        cell.contentLabel?.font = contentFont
        if tagSource!.count > 0 {

            cell.tagLabel?.font = tagFont
            cell.tagLabel?.text = tagSource![indexPath.row % tagSource!.count]
            if tagBackgroundColors!.count > 0 {
                cell.tagLabel?.backgroundColor = tagBackgroundColors![indexPath.row % tagBackgroundColors!.count]
            }else {
                cell.tagLabel?.backgroundColor = tagBackgroundColor
            }
            if tagTextColors!.count > 0 {
                cell.tagLabel?.textColor = tagTextColors![indexPath.row % tagTextColors!.count]
            }else {
                cell.tagLabel?.textColor = tagTextColor
            }
        }else {
            cell.tagLabel?.removeFromSuperview()
            cell.contentLabel?.frame = CGRect(x: 5, y: 0, width: self.bounds.width, height: self.bounds.height)
        }

        return cell
    }
}

extension YLSinglerowView : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.singlerView(self, selectedIndex: indexPath.row % contentSource!.count)
    }

}
//MARK: -- 时间控制器
extension YLSinglerowView {

    fileprivate func addSinglerViewTimer() {
        weak var weakSelf = self//解决循环引用

        if #available(iOS 10.0, *) {
            singlerTimer = Timer(timeInterval: time!, repeats: true, block: {(timer) in
                weakSelf!.scrollToNextPage()
            })
        } else {
            singlerTimer = Timer.scheduledTimer(timeInterval: time!, target: self, selector: #selector(self.scrollToNextPage), userInfo: nil, repeats: true)
        }
        RunLoop.main.add(singlerTimer!, forMode: .commonModes)
    }

    fileprivate func removeSinglerViewTimer() {
        singlerTimer?.invalidate()//移除
        singlerTimer = nil
    }

    @objc fileprivate func scrollToNextPage() {

        var position : UICollectionViewScrollPosition

        if style == ScrollStyle.right || style == ScrollStyle.left {
            position = style == .left ? UICollectionViewScrollPosition.left : UICollectionViewScrollPosition.right
        }else {
            position = style == .up ? UICollectionViewScrollPosition.top : UICollectionViewScrollPosition.bottom
        }
        if style == ScrollStyle.left || style == ScrollStyle.up {
            index! += 1
        }else {
            index! -= 1
        }
        let indexPath = IndexPath(item: Int(index!), section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: position, animated: true)

    }
}

//MARK: ====================Cell类=========================

class YLSinglerowCell: UICollectionViewCell {

    lazy var contentLabel : UILabel? = {[weak self] in

        let label = UILabel(frame: CGRect(x: 45, y: 0, width: self!.bounds.width - 43, height: self!.bounds.height))

        return label
    }()
    lazy var tagLabel : UILabel? = {[weak self] in
        let label = UILabel(frame: CGRect(x: 3, y: (self!.bounds.height - 16) / 2, width: 40, height: 16))
        label.layer.cornerRadius = 7
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        setupContentUI()
    }

    func setupContentUI() {
        contentView.addSubview(contentLabel!)
        contentView.addSubview(tagLabel!)
    }

}

