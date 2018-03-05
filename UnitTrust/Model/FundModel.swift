//
//  FundModel.swift
//  UnitTrust
//
//  Created by Jeff on 05/03/2018.
//  Copyright © 2018 Jeff. All rights reserved.
//

import Foundation

class FundModel {
    
    func retrieveFundDetailData() -> FundDetailData? {
        if let path = Bundle.main.path(forResource: "ut-details", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.mappedIfSafe) {
                let decoder = JSONDecoder()
                return try? decoder.decode(FundDetailData.self, from: data)
            }
        }
        return nil
    }
    
}
