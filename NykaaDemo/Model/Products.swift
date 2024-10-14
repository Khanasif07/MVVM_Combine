//
//  Products.swift
//  NykaaDemo
//
//  Created by Asif Khan on 01/10/2024.
//

import Foundation
struct Products: Codable{
    var products: [Product?] = []
}

struct Product: Codable{
    var name: String?
    var price: CGFloat?
    var rating: CGFloat?
}
/*
{
  "products": [
    {
      "name": "Product 1",
      "price": 500,
      "rating": 3
    },
    {
      "name": "Product 2",
      "price": 40.10,
      "rating": 3.5
    },
    {
      "price": 60.50
    },
    {
      "rating": 4.5
    },
    {
      "price": 90.10,
      "rating": 13.5
    },
    {
      "name": "Product 6",
      "rating": 4.5
    },
    {
      "name": "Product 7",
      "price": 4.9
    }
  ]
}
*/
