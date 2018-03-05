//
//  LandingViewController.swift
//  UnitTrust
//
//  Created by Jeff on 01/03/2018.
//  Copyright © 2018 Jeff. All rights reserved.
//

import UIKit
import SwiftSpreadsheet

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

    lazy var collectionView: UICollectionView = {
        // Decoration View
        let topLeftDecorationViewNib = UINib(nibName: DecorationViewNames.topLeft, bundle: nil)
        let layout = SpreadsheetLayout(delegate: self, topLeftDecorationViewNib: topLeftDecorationViewNib, topRightDecorationViewNib: nil, bottomLeftDecorationViewNib: nil, bottomRightDecorationViewNib: nil)
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
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
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.bounces = false
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
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
        return (70, nil)
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
        cell.backgroundColor = indexPath.item % 2 == 1 ? self.lightGreyColor : UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewKind = SpreadsheetLayout.ViewKindType(rawValue: kind) else { fatalError("View Kind not available for string: \(kind)") }
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: viewKind.rawValue, withReuseIdentifier: defaultSupplementaryViewIdentifier, for: indexPath) as! SpreadsheetCollectionReusableView
        switch viewKind {
        case .leftRowHeadline:
            supplementaryView.infoLabel.text = fundDetail.data[indexPath.section].fund
        case .topColumnHeader:
            supplementaryView.infoLabel.text = fundDetail.header[indexPath.item]
            supplementaryView.backgroundColor = indexPath.item % 2 == 1 ? self.lightGreyColor : UIColor.white
        default:
            break
        }
        return supplementaryView
    }
    
}
