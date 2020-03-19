//
//  SectionPage.swift
//  HCIAssignmentTest
//
//  Created by Ari Gonta on 18/03/20.
//

import Foundation

struct ListSection: Decodable {
    let data: [SectionPage]?
}

struct SectionPage: Decodable {
    let section: String?
    let sectionTitle: String?
    let items: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case section
        case sectionTitle = "section_title"
        case items
    }
}

struct Item: Decodable {
    let articleTitle: String?
    let articleImage: URL?
    let link: URL?
    let productName: String?
    let productImage: URL?
    
    init(articleTitle: String, articleImage: URL, link: URL, productName:String, productImage: URL) {
        self.articleTitle = articleTitle
        self.articleImage = articleImage
        self.link = link
        self.productName = productName
        self.productImage = productImage
    }
    
    enum CodingKeys: String, CodingKey {
        case articleTitle = "article_title"
        case articleImage = "article_image"
        case link = "link"
        case productName = "product_name"
        case productImage = "product_image"
    }
}
