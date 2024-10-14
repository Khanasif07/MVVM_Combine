//
//  ProductTableViewCell.swift
//  NykaaDemo
//
//  Created by Asif Khan on 01/10/2024.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    var product: Product?{
        didSet{
            if let productName =  product?.name{
                productNameLbl.text = productName
                productNameLbl.isHidden = false
            }else{
                productNameLbl.isHidden = true
            }
            
            if let price =  product?.price{
                priceLbl.text = "Price \(price)"
                priceLbl.isHidden = false
            }else{
                priceLbl.isHidden = true
            }
            
            if let rating =  product?.rating{
                ratingLbl.text = "Rating \(rating)"
                ratingLbl.isHidden = false
            }else{
                ratingLbl.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
