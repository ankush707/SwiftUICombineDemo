//
//  APIRequest.swift
//  demo
//
//  Created by Ankush on 13/02/23.
//

import Foundation
import SwiftUI

typealias BooksCompletionHandler = ((HomeModel) -> ())

class APIRequestViewModel: ObservableObject {
    
    @Published var homeObj : HomeModel?
    @Published var isLoading: Bool = false
    
    init() {
        self.loadData()
    }
    
    func loadData() {
        guard let url = URL(string: "https://datausa.io/api/data?drilldowns=Nation&measures=Population") else {
                    print("Invalid url...")
                    return
                }
        let urlRequest = URLRequest(url: url)
        isLoading = true
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let dataObj = data else {
                        print("Invalid data...")
                        return
                    }
            if let homeObj = try? JSONDecoder().decode(HomeModel.self, from: dataObj) {
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.homeObj = homeObj
                }
            }
        }.resume()
    }
}
