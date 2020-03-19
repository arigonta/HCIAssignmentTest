//
//  ListSectionTest.swift
//  HCIAssignmentTestTests
//
//  Created by Ari Gonta on 20/03/20.
//

import Foundation
import XCTest

@testable import HCIAssignmentTest

class ListSectionTest: XCTestCase {

    var listSection: [ListSection] = []
    var sectionPage: [SectionPage] = []
    var items: [Item] = []
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        listSection.removeAll()
        sectionPage.removeAll()
        items.removeAll()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            //Download Perfomance
            if let url = URL(string: "https://www.homecredit.co.id/6-fakta-seru-home-credit-indonesia-hci") {
                _ = Item(articleTitle: "news", articleImage: url, link: url, productName: "hp", productImage: url)
            }
        }
    }

    func testValidateItemModel() {
        if let url = URL(string: "https://www.homecredit.co.id/6-fakta-seru-home-credit-indonesia-hci") {
            let item = Item(articleTitle: "news", articleImage: url, link: url, productName: "hp", productImage: url)
            XCTAssertEqual(item.articleImage, url, "Error Validate")
            XCTAssertEqual(item.link, url, "Error Validate")
            XCTAssertEqual(item.productImage, url, "Error Validate")
            XCTAssertEqual(item.articleTitle, "news", "Error Validate")
            XCTAssertEqual(item.productName, "hp", "Error Validate")
        }
    }
    
    func testEmptyModel() {
        XCTAssertEqual(listSection.count, 0, "Failed Count")
        XCTAssertEqual(sectionPage.count, 0, "Failed Count")
        XCTAssertEqual(items.count, 0, "Failed Count")
    }

}
