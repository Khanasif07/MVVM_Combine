//
//  ViewController.swift
//  NykaaDemo
//
//  Created by Asif Khan on 01/10/2024.
//

import UIKit
import Combine
class ViewController: UIViewController {
    
    //MARK: - IBUtlets
    @IBOutlet weak var mainTableView: UITableView!
    
    //MARK: - Properties
    private var viewModel =  ProductViewModel(userService: MockProductAPIServiceManager())
    private var cancellable:Set<AnyCancellable> = []
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hitApi()
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Product"
        self.bindViewModel()
        self.registerTableView()
    }
    
    private func hitApi(){
        Task{
            await self.viewModel.getProductListing(urlStr: self.viewModel.productsUrl)
        }
    }
    
    private func bindViewModel(){
        self.viewModel.$isProductDataGotFromServer.sink { [weak self] value in
            guard let self = self else { return}
            if value {
                // populate table view
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            }
        }.store(in: &cancellable)
        
        self.viewModel.$errorFromServer.sink { [weak self] value in
            guard let self = self else { return}
            if !value.isEmpty {
                // populate table view
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            }
        }.store(in: &cancellable)
    }
    
    private func registerCell(){
        self.mainTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    private func registerTableView(){
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.registerCell()
    }
}

// MARK: - Table View delegate
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.products?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell{
            cell.product = self.viewModel.products?.products[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
