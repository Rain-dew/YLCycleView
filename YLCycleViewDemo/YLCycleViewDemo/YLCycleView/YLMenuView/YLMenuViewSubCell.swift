//
//  CollectionGameCell.swift
//  斗鱼
//
//  Created by Raindew on 2016/11/7.
//  Copyright © 2016年 Raindew. All rights reserved.
//

import UIKit

class YLMenuViewSubCell: UICollectionViewCell {
    @IBOutlet var imageViewH: NSLayoutConstraint!
    @IBOutlet var imageViewW: NSLayoutConstraint!
    var imageViewSize : CGSize = CGSize(width: 48, height: 48) {

        didSet {
            self.imageViewW.constant = imageViewSize.width
            self.imageViewH.constant = imageViewSize.height
            if imageViewSize.width == imageViewSize.height {
                
                iconImageView.layer.cornerRadius = imageViewSize.width / 2
                iconImageView.layer.masksToBounds = true

            }else {
                //不是正方形。什么都不做
                iconImageView.layer.cornerRadius = 0
                iconImageView.layer.masksToBounds = false
            }
        }

    }
    //空间属性
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
            iconImageView.layer.cornerRadius = imageViewSize.width / 2
            iconImageView.layer.masksToBounds = true
    }

}
