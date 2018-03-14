//
//  LandingViewController.swift
//  UnitTrust
//
//  Created by Jeff on 01/03/2018.
//  Copyright © 2018 Jeff. All rights reserved.
//

import UIKit
import SwiftSpreadsheet
import Charts

class LandingViewController: UIViewController {

    let defaultCellIdentifier = "DefaultCellIdentifier"
    let defaultSupplementaryViewIdentifier = "DefaultSupplementaryViewIdentifier"
    let numberFormatter = NumberFormatter()
    let lightGreyColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    let fundModel = FundModel()
    
    let dataArray: [[Double]] = {
        var finalArray = [[Double]]()
        for _ in 0 ..< 30 {
            var subArray = [Double]()
            for _ in 0 ..< 12 {
                subArray.append(Double(arc4random() % 4000))
            }
            finalArray.append(subArray)
        }
        return finalArray
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isUserInteractionEnabled = true
        return view
    }()

    lazy var collectionView: UICollectionView = {
        // Decoration View
        let topLeftDecorationViewNib = UINib(nibName: DecorationViewNames.topLeft, bundle: nil)
        let layout = SpreadsheetLayout(delegate: self, topLeftDecorationViewNib: topLeftDecorationViewNib, topRightDecorationViewNib: nil, bottomLeftDecorationViewNib: nil, bottomRightDecorationViewNib: nil)
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        
        // Supplementary View
        let topSupplementaryViewNib = UINib(nibName: SupplementaryViewNames.top, bundle: nil)
        let leftSupplementaryViewNib = UINib(nibName: SupplementaryViewNames.left, bundle: nil)
        view.register(topSupplementaryViewNib, forSupplementaryViewOfKind: SpreadsheetLayout.ViewKindType.topColumnHeader.rawValue, withReuseIdentifier: self.defaultSupplementaryViewIdentifier)
        view.register(leftSupplementaryViewNib, forSupplementaryViewOfKind: SpreadsheetLayout.ViewKindType.leftRowHeadline.rawValue, withReuseIdentifier: self.defaultSupplementaryViewIdentifier)
        
        view.register(DataCollectionViewCell.self, forCellWithReuseIdentifier: defaultCellIdentifier)
        
        return view
    }()
    
    lazy var fundDetail: FundDetailData = {
        if let result = fundModel.retrieveFundDetailData() {
            return result
        } else {
            return FundDetailData()
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        title = "Funds"
        
        setupCollectionView()
        setupScrollView()
        setupPieChart()
    }
    
    private func setupCollectionView() {
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    private func setupPieChart() {
        var dataEntries = [PieChartDataEntry]()
        let totalAmountPaid = fundDetail.data.map { $0.amountpaid }.reduce(0) { $0 + $1 }
        for fund in fundDetail.data {
            let entry = PieChartDataEntry(value: fund.amountpaid / totalAmountPaid, label: fund.fundname)
            dataEntries.append(entry)
        }

        let chartDataSet = PieChartDataSet(values: dataEntries, label: "")
        chartDataSet.colors = [
            NSUIColor(red: 192/255.0, green: 255/255.0, blue: 140/255.0, alpha: 1.0),
            NSUIColor(red: 255/255.0, green: 247/255.0, blue: 140/255.0, alpha: 1.0),
            NSUIColor(red: 255/255.0, green: 208/255.0, blue: 140/255.0, alpha: 1.0),
            NSUIColor(red: 140/255.0, green: 234/255.0, blue: 255/255.0, alpha: 1.0),
            NSUIColor(red: 255/255.0, green: 140/255.0, blue: 157/255.0, alpha: 1.0),
            NSUIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1.0),
            NSUIColor(red: 241/255.0, green: 196/255.0, blue: 15/255.0, alpha: 1.0),
            NSUIColor(red: 231/255.0, green: 76/255.0, blue: 60/255.0, alpha: 1.0),
            NSUIColor(red: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1.0)
        ]
        chartDataSet.sliceSpace = 2
        chartDataSet.selectionShift = 5
        
        let chartData = PieChartData(dataSet: chartDataSet)
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        let pieChartWeight: CGFloat = 300.0
        let pieChart1 = PieChartView()
        pieChart1.legend.enabled = true
        pieChart1.chartDescription?.text = ""
        pieChart1.drawHoleEnabled = false
        pieChart1.rotationEnabled = false
        pieChart1.drawEntryLabelsEnabled = false
        pieChart1.data = chartData
        scrollView.addSubview(pieChart1)
        pieChart1.translatesAutoresizingMaskIntoConstraints = false
        pieChart1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        pieChart1.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        pieChart1.widthAnchor.constraint(equalToConstant: pieChartWeight).isActive = true
        pieChart1.heightAnchor.constraint(equalToConstant: pieChartWeight).isActive = true
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: pieChartWeight * 2)
    }

}

extension LandingViewController: SpreadsheetLayoutDelegate {
    
    func spreadsheet(layout: SpreadsheetLayout, heightForRowsInSection section: Int) -> CGFloat {
        return 50
    }
    
    func widthsOfSideRowsInSpreadsheet(layout: SpreadsheetLayout) -> (left: CGFloat?, right: CGFloat?) {
        return (120, nil)
    }
    
    func spreadsheet(layout: SpreadsheetLayout, widthForColumnAtIndex index: Int) -> CGFloat {
        return 80
    }
    
    func heightsOfHeaderAndFooterColumnsInSpreadsheet(layout: SpreadsheetLayout) -> (headerHeight: CGFloat?, footerHeight: CGFloat?) {
        return (50, nil)
    }
    
}

extension LandingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fundDetail.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fundDetail.header.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultCellIdentifier, for: indexPath) as! DataCollectionViewCell
        let value = fundDetail.dataList[indexPath.section][indexPath.item]
        if let value = value as? Double {
            cell.infoLabel.text = numberFormatter.string(from: NSNumber(value: value))
        } else {
            cell.infoLabel.text = String(describing: value)
        }
        cell.backgroundColor = indexPath.section % 2 == 1 ? self.lightGreyColor : UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewKind = SpreadsheetLayout.ViewKindType(rawValue: kind) else { fatalError("View Kind not available for string: \(kind)") }
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: viewKind.rawValue, withReuseIdentifier: defaultSupplementaryViewIdentifier, for: indexPath) as! SpreadsheetCollectionReusableView
        switch viewKind {
        case .leftRowHeadline:
            supplementaryView.infoLabel.text = fundDetail.data[indexPath.section].fundname
        case .topColumnHeader:
            supplementaryView.infoLabel.text = fundDetail.header[indexPath.item]
        default:
            break
        }
        supplementaryView.backgroundColor = indexPath.section % 2 == 1 ? self.lightGreyColor : UIColor.white
        return supplementaryView
    }
    
}

extension LandingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(FundDetailViewController(), animated: true)
    }
    
}

