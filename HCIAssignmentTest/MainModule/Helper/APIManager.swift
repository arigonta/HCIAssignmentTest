//
//  APIManager.swift
//  HCIAssignmentTest
//
//  Created by Ari Gonta on 18/03/20.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    func requestDataApi(completion: @escaping (Result<[SectionPage], Error>) -> ()) {
        let request = AF.request(constant.BASE_URL)
        request.responseDecodable(of: ListSection.self) { (response) in
            switch response.result {
            case .success:
                guard let value = response.value?.data else { return }
                completion(.success(value))
            case .failure:
                guard let error = response.error else { return }
                completion(.failure(error))
            }
        }
    }
}
