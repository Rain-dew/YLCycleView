// QQ:  896525689  QQ群:511860085
// gitHub:https://github.com/Rain-dew
// Email:zhangyuluios@163.com
//                 _
// /\   /\        | |
// \ \_/ / _   _  | |     _   _
//  \_ _/ | | | | | |    | | | |
//   / \  | |_| | | |__/\| |_| |
//   \_/   \__,_| |_|__,/ \__,_|
//  YLCycleCell.swift
//  YLCycleView
//
//  Created by shuogao on 2016/11/1.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class YLCycleCell: UICollectionViewCell {

    //声明属性
    var dataSource : [[String]]!
    var iconImageView : UIImageView!
    var titleLabel : UILabel?
    var bottomView : UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        setupUI()
    }
}
extension YLCycleCell {

    fileprivate func setupUI() {

        iconImageView = UIImageView(frame: self.bounds)
        bottomView  = UIView(frame: CGRect(x: 0, y: iconImageView.bounds.height - 30, width: iconImageView.bounds.width, height: 30))
        titleLabel = UILabel(frame: CGRect(x: 10, y: iconImageView.bounds.height - 25, width: iconImageView.bounds.width / 2, height: 20))

        //设置属性
        bottomView.backgroundColor = .black
        bottomView.alpha = 0.3
        titleLabel?.textAlignment = .left
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 14)

        contentView.addSubview(iconImageView)
        contentView.addSubview(bottomView)
        contentView.addSubview(titleLabel!)

    }

}
