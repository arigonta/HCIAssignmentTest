//
//  MainViewController.swift
//  HCIAssignmentTest
//
//  Created by Ari Gonta on 18/03/20.
//

import UIKit
import Kingfisher
import SafariServices
import SkeletonView

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableViewHCI: UITableView!
    @IBOutlet weak var navBar: UIView!
    
    var tempItemsArticle: [Item] = []
    var tempItemProduct: [Item] = []
    var tempSectionPage: [SectionPage] = []
    var isNotSkeleton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        requestDataAPI()
    }
    
    func setupNavBar() {
        navBar.layer.masksToBounds = false
        navBar.layer.shadowRadius = 2
        navBar.layer.shadowOpacity = 1
        navBar.layer.shadowColor = UIColor.gray.cgColor
        navBar.layer.shadowOffset = CGSize(width: 0 , height:1)
    }
    
    func alertLostConnection() {
        let alert = UIAlertController(title: "Error Connection", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "retry", style: .default, handler: { action in
            self.requestDataAPI()
        }))
        self.present(alert, animated: true)
    }
    
    func requestDataAPI () {
        APIManager.shared.requestDataApi { (result) in
            switch result {
            case .success(let section):
                self.tempSectionPage = section
                //filter item for section 'articles'
                let itemsArticle = section.filter { $0.section == "articles" }
                itemsArticle.forEach { (item) in
                    self.tempItemsArticle = item.items ?? []
                }
                
                //filter item for section 'products'
                let itemsProduct = section.filter { $0.section == "products" }
                itemsProduct.forEach { (item) in
                    self.tempItemProduct = item.items ?? []
                }
                
                self.tableViewHCI.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.isNotSkeleton = true
                    self.tableViewHCI.hideSkeleton()
                    self.tableViewHCI.reloadData()
                }
                
            case .failure(let err):
                print(err)
                self.alertLostConnection()
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tempSectionPage.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let productSectionType = sections.init(index: section)
        switch productSectionType {
        case .products:
            return 1
        default:
            if isNotSkeleton {
                return tempItemsArticle.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productSectionType = sections.init(index: indexPath.section)
        switch productSectionType {
        case .products :
            if let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)as? ProductTableViewCell {
                if isNotSkeleton {
                    productCell.contentViewProduct?.hideSkeleton()
                    productCell.itemsProduct = tempItemProduct
                    productCell.delegate = self
                    productCell.selectionStyle = .none
                    productCell.isHiddenSkeletonView = isNotSkeleton
                } else {
                    //MARK: Setup skeleton view
                    productCell.contentViewProduct?.isSkeletonable = !isNotSkeleton
                    productCell.contentViewProduct?.showAnimatedGradientSkeleton()
                }
                return productCell
            } else {
                return UITableViewCell.init()
            }
        default:
            if let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath)as? ArticleTableViewCell {
                articleCell.labelArticle?.text = tempItemsArticle[indexPath.row].articleTitle
                articleCell.imageArticle?.kf.setImage(with: tempItemsArticle[indexPath.row].articleImage)
                articleCell.selectionStyle = .none
                return articleCell
            } else {
                return UITableViewCell.init()
            }
        }
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productSectionType = sections.init(index: indexPath.section)
        switch productSectionType {
        case .products :
            break
        default:
            if let url = tempItemsArticle[indexPath.row].link {
                let svc = SFSafariViewController(url: url)
                present(svc, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let productSectionType = sections.init(index: indexPath.section)
        switch productSectionType {
        case .products :
            return 190
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let productSectionType = sections.init(index: section)
        switch productSectionType {
        case .products :
            return nil
        default:
            let headerViewArticles = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0))
            
            let labelSectionArticles = UILabel()
            labelSectionArticles.frame = CGRect.init(x: 20, y: -10, width: headerViewArticles.frame.width-10, height: 20)
            labelSectionArticles.text = tempSectionPage[0].sectionTitle
            labelSectionArticles.textColor = UIColor.black
            headerViewArticles.addSubview(labelSectionArticles)
            
            return isNotSkeleton ? headerViewArticles : UIView.init()
        }
    }
}

extension MainViewController: productTableViewCellToMainViewController {
    func presentSVC(_ itemsProduct: URL) {
        let svc = SFSafariViewController(url: itemsProduct)
        present(svc, animated: true, completion: nil)
    }
}
