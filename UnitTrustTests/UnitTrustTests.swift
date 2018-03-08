//
//  UnitTrustTests.swift
//  UnitTrustTests
//
//  Created by Jeff on 01/03/2018.
//  Copyright © 2018 Jeff. All rights reserved.
//

import XCTest

@testable import UnitTrust

class UnitTrustTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("test")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRetrieveData() {
        if let path = Bundle.main.path(forResource: "ut-details", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, Any> {
                    print("jsonResult: \(jsonResult)")
                }
                let decoder = JSONDecoder()
                if let fund = try? decoder.decode(FundDetailData.self, from: data) {
                    print(fund.data.count)
                }
            } catch {
                print("error")
            }
        } else {
            print("no found")
        }
    }
    
    func testRetrieveFundDetail() {
        let fundModel = FundModel()
        if let fundDetail = fundModel.retrieveFundDetailData() {
            print("fund detail: \(fundDetail.data)")
            print(fundDetail.dataList)
        } else {
            print("nil")
        }
    }
    
    func testMinerHistory() {
        let fileName = "History.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)!
        print("temporary path: \(path)")
        var csvText = "Date,Hashrate\n"
        
        let exp = expectation(description: "miner history")
        let address = "0xa0e16e4f1684ec1f4ba68acf732d1b759aee1727"
        let urlPath = "https://api.nanopool.org/v1/eth/history/\(address)"
        var request = URLRequest(url: URL(string: urlPath)!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
                print("request: \(request.url?.absoluteString ?? "")")
                return
            }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                if let jsonData = jsonData as? Dictionary<String, Any> {
                    if let hashrateData = jsonData["data"] as? [Dictionary<String, Any>] {
                        print("date: \(hashrateData.first?["date"] ?? "")")
                        for data in hashrateData {
                            if let interval = data["date"] as? Double, let hashrate = data["hashrate"] as? Int {
                                csvText.append("\(Date(timeIntervalSince1970: interval)),\(hashrate)\n")
                            }
                        }
                    }
                }
                
            } catch {
                
            }

            if let _ = String(data: data!, encoding: .utf8) {
                
            }
            
            do {
                try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("error write file")
            }

            exp.fulfill()
        }
        task.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
