//
//  FundDetailData.swift
//  UnitTrust
//
//  Created by Jeff on 05/03/2018.
//  Copyright © 2018 Jeff. All rights reserved.
//

import Foundation

struct FundDetailData: Codable {
    
    let header = ["Plan", "Market Value", "Unit", "id", "Currency", "Nav", "Nav Date"]
    var data: [FundData]
    var dataList: [[Any]] {
        get {
            return data.map { [$0.scheme, $0.amountpaid, $0.totalunit, $0.umstid, $0.currency, $0.nav, $0.navDate] }
        }
    }
    
    init() {
        data = []
    }
}

struct FundData: Codable {

    var masteraccount: String
    var fundname: String
    var scheme: String
    var amountpaid: Double
    var totalunit: Double
    var umstid: String
    var account: String?
    var currency: String
    var nav: Double
    var navDate: String

}
