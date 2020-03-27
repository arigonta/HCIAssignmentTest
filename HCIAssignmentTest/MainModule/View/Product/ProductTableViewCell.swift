//
//  ProductTableViewCell.swift
//  HCIAssignmentTest
//
//  Created by Ari Gonta on 19/03/20.
//

import UIKit

protocol productTableViewCellToMainViewController {
    func presentSVC(_ itemsProduct: URL)
}

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionViewProduct: UICollectionView?
    var itemsProduct: [Item] = []
    @IBOutlet weak var contentViewProduct: UIView?
    var delegate: productTableViewCellToMainViewController?
    var isHiddenSkeletonView: Bool = false {
        didSet {
            collectionViewProduct?.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewProduct?.dataSource = self
        collectionViewProduct?.delegate = self
        
        //MARK: To Style
        setupContentView()
        collectionViewProduct?.layer.cornerRadius = 4
    }
    
    fileprivate func setupContentView() {
        contentViewProduct?.layer.shadowColor = UIColor.gray.cgColor
        contentViewProduct?.layer.shadowOpacity = 0.8
        contentViewProduct?.layer.shadowOffset = .zero
        contentViewProduct?.layer.shadowRadius = 2
    }
}

extension ProductTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath)as? ProductCollectionViewCell {
            cell.titleLabel.text = itemsProduct[indexPath.row].productName
            if let url = itemsProduct[indexPath.row].productImage {
                cell.image.kf.setImage(with: url)
            }
            return cell
        } else {
            return UICollectionViewCell.init()
        }
    }
}

extension ProductTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = itemsProduct[indexPath.row].link {
            delegate?.presentSVC(url)
        }
    }
}

extension ProductTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: 70)
    }
}
