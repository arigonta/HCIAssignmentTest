//
//  CommonHelper.swift
//  HCIAssignmentTest
//
//  Created by Ari Gonta on 19/03/20.
//

enum sections: Int {
    case articles
    case products
    
    init(index: Int) {
        switch index {
        case 0:
            self = .products
        default :
            self = .articles
        }
    }
}
