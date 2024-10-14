//
//  ProductViewModel.swift
//  NykaaDemo
//
//  Created by Asif Khan on 01/10/2024.
//

import Foundation
class ProductViewModel{
    var productsUrl =  "https://gist.githubusercontent.com/sanjeevkumargautam-nykaa/a2ab56f3a0973bd415a41b10906a0683/raw/15136211cf4e810abaa19dc0ec77641cd518cc26/products.json"
    var products: Products?
    @Published private(set) var isProductDataGotFromServer: Bool = false
    @Published private(set) var errorFromServer: String = ""
    //
    private let userService: (any ProductAPIServiceProviderProtocol)?
    init(userService: any ProductAPIServiceProviderProtocol) {
        self.userService = userService
    }
    
    /*
    func getProductListing(urlStr: String){
        NetworkManager.shared.getDataFromServer(urlStr: urlStr) { (result: Result<Products,Error>) in
            switch result {
            case .success(let products):
                print("\(products).")
                self.products = products
                self.isProductDataGotFromServer = true
            case .failure(let error):
                print(error.localizedDescription)
                self.errorFromServer = error.localizedDescription
            }
        }
    }
    */
    
    func getProductListing(urlStr: String) async{
        do {
            let products:[Product] = try await self.userService?.fetchUsers(urlStr) as! [Product]
            self.products = Products(products: products)
            self.isProductDataGotFromServer = true
        }catch (let err){
            self.errorFromServer = err.localizedDescription
        }
    }
    
    
}
