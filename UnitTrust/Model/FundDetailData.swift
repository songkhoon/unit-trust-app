//
//  FundDetailData.swift
//  UnitTrust
//
//  Created by Jeff on 05/03/2018.
//  Copyright © 2018 Jeff. All rights reserved.
//

import Foundation

struct FundDetailData: Codable {
    
    let header = ["Units", "NAV Price", "Marketing Value", "Date"]
    var data: [FundData]
    var dataList: [[Any]] {
        get {
            return data.map { [$0.units, $0.navPrice, $0.marketingValue, $0.date] }
        }
    }
    
    init() {
        data = []
    }
}

struct FundData: Codable {

    var fund: String
    var units: Double
    var navPrice: Double
    var marketingValue: Double
    var date: String

}
