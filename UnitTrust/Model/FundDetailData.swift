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
    var data: [FundDetailInfoData]
    var dataList: [[Any]] {
        get {
            return data.map { [$0.scheme, $0.amountpaid, $0.totalunit, $0.umstid, $0.currency, $0.nav, $0.navDate] }
        }
    }
    
    init() {
        data = []
    }
}

struct FundDetailInfoData: Codable {

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

struct FundData: Codable {
    
    let header = ["Date", "Description", "Price", "Currency", "Units", "Amount Invested", "Sale Charges", "Charges Amount", "Amount Paid", "BalanceUnit"]
    var data: [Data]
    var dataList: [[Any]] {
        get {
            return data.map({ [$0.transactionDate, $0.description, $0.price, $0.currency, $0.units, $0.amountInvested, $0.salesCharges, $0.chargesAmount, $0.amountPaid, $0.balanceUnit, $0.gst] })
        }
    }
    
    init() {
        data = []
    }
    
    struct Data: Codable {
        
        var transactionDate: String
        var description: String
        var price: Double
        var currency: String
        var units: Double
        var amountInvested: Double
        var salesCharges: Double
        var chargesAmount: Double
        var amountPaid: Double
        var balanceUnit: Double
        var gst: Double

    }
    
}
