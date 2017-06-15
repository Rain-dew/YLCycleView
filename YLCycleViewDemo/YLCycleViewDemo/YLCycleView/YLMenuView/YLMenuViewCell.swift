//
//  YLMenuViewCell.swift
//
//
//  Created by Raindew on 2016/11/8.
//  Copyright © 2016年 Raindew. All rights reserved.
//

import UIKit
//代理
protocol YLMenuViewCellDelegate : class {
    func menuViewCell(_ menuViewCell : YLMenuViewCell, selectedIndex index : Int)
}

private let kItemCell = "kItemCell"

class YLMenuViewCell: UICollectionViewCell {
//MARK: -- 数组
    weak var delegate : YLMenuViewCellDelegate?

    @IBOutlet var collectionView: UICollectionView!
    var imageArray : [String]? = nil {

        didSet {
            collectionView.reloadData()
        }
    }
    var titleArray : [String]? = nil {
        didSet {
            collectionView.reloadData()
        }
    }
    var itemsOfPage : Int = 8 {//每页几个item
        didSet {
            collectionView.reloadData()
        }
    }
    var imageViewSize : CGSize = CGSize(width: 48, height: 48) {

        didSet {
            collectionView.reloadData()

        }

    }

    override func awakeFromNib() {
        super.awakeFromNib()

        //注册
        collectionView.register(UINib.init(nibName: "YLMenuViewSubCell", bundle: nil), forCellWithReuseIdentifier: kItemCell)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / CGFloat(itemsOfPage / 2)
        let itemH = collectionView.bounds.height / 2
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemW, height: itemH)

    }

}


//MARK: -- UICollectionViewDataSource
extension YLMenuViewCell : UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kItemCell, for: indexPath) as! YLMenuViewSubCell
        cell.titleLabel.text = self.titleArray![indexPath.item]

        var header : String?
        if imageArray![indexPath.item].characters.count >= 4 {
            header = (imageArray![indexPath.item] as NSString).substring(to: 4)
        }
        if header == "http" {
            let url = URL(string: self.imageArray![indexPath.item])
            cell.iconImageView.kf.setImage(with: url)
        }else {
            cell.iconImageView.image = UIImage(named: self.imageArray![indexPath.item])
        }
        cell.imageViewSize = self.imageViewSize
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.delegate?.menuViewCell(self, selectedIndex: indexPath.item)
    }
   
}
