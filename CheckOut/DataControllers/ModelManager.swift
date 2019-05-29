//
//  ModelManager.swift
//  CheckOut
//
//  Created by SCIS on 5/4/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
/*
    ModelManager is responsible of get, save, and share the data obtained from an api
 */
class ModelManager{
    
    static let shared = ModelManager()
    let baseUrl = "https://us-central1-ucu-ios-api.cloudfunctions.net"
    var itemsById: [Int: Item] = [:]
    var banners: [Banner] = []
    var items: [Item] = []
    var token: String?
    let fakeToken = "9E53496E-157C-4BB2-A49C-FBA77C5675D6"
    
    private init(){
        AuthenticationManager.shared.authenticate { (authResponse) in
            self.token = authResponse.token
        }
    }
    
   func fetchAllItems(completion: @escaping ([Item]?, Error?) -> Void) {
        let url = URL(string: baseUrl + "/products")!

        Alamofire.request(url,method: .get)
            .validate().responseArray{ (response: DataResponse<[Item]>) in
                switch response.result {
                case .success:
                    self.items = response.result.value ?? []
                    self.addItemsById(items: self.items)
                    completion(response.value, nil)
                    
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }

    func fetchAllBanners(completion: @escaping ([Banner]?, Error?) -> Void) {
        let url = URL(string: baseUrl + "/promoted")!
        
        Alamofire.request(url,method: .get)
            .validate().responseArray{ (response: DataResponse<[Banner]>) in
                switch response.result {
                case .success:
                    self.banners = response.result.value ?? []
                    completion(response.value, nil)
                
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }

    func fetchAllPurchases(completion: @escaping ([Purchase]?, Error?) -> Void) {
        let url = URL(string: baseUrl + "/purchases")!
        if self.token == nil {
            let errorTemp = NSError(domain:"", code: -1, userInfo:nil)
            completion(nil, errorTemp);
            return
        }
        let headers: HTTPHeaders = ["Authorization": "Bearer " + self.fakeToken]
        
        Alamofire.request(url,method: .get, headers: headers)
            .validate().responseArray{(response: DataResponse<[Purchase]>) in
                switch response.result {
                case .success:
                    completion(response.value, nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
    func postPurchase(completion: @escaping (String?, Error?) -> Void) {
        let url = URL(string: baseUrl + "/checkout")!
        if self.token == nil {
            let errorTemp = NSError(domain:"", code: -1, userInfo:nil)
            completion(nil, errorTemp);
            return
        }
        var params = Parameters()
        params.updateValue(CartManager.shared.toPurchaseLinePost().toJSON(), forKey: "cart")
        let headers: HTTPHeaders = ["Authorization": "Bearer " + self.fakeToken]
        
        Alamofire.request(url, method: .post, parameters: params,encoding: JSONEncoding.default, headers: headers).responseString {
            response in
            switch response.result {
            case .success:
                completion(response.value,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
        
    }

    
    
    
    


    private func addItemsById(items: [Item]){
        for item in items{
            if(itemsById[item.id!] == nil)
            {
                itemsById[item.id!] = item
            }
        }
    }
}
