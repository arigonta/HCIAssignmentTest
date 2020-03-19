//
//  ArticleTableViewCell.swift
//  HCIAssignmentTest
//
//  Created by Ari Gonta on 19/03/20.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentViewArticle: UIView?
    @IBOutlet weak var imageArticle: UIImageView?
    @IBOutlet weak var labelArticle: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //MARK: To Style
        //setup image
        imageArticle?.clipsToBounds = true
        imageArticle?.layer.cornerRadius = 4
        if #available(iOS 11.0, *) {
            imageArticle?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        //setup content view
        contentViewArticle?.layer.cornerRadius = 4
        contentViewArticle?.layer.shadowRadius = 1
        contentViewArticle?.layer.shadowOpacity = 0.8
        contentViewArticle?.layer.shadowColor = UIColor.gray.cgColor
        contentViewArticle?.layer.shadowOffset = CGSize(width: 0 , height:1)
    }
}
