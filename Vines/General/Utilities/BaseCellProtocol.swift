//
//  BaseCellProtocol.swift
//  Vines
//
//  Created by Calista Bertha on 20/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

protocol BaseCellProtocol {
    
}

extension BaseCellProtocol {
    static var identifier: String {
        return String(describing: self).lowercased()
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

protocol CollectionViewCellProtocol: BaseCellProtocol {
    static func configure<T>(context: UIViewController, collectionView: UICollectionView, indexPath: IndexPath, object: T) -> UICollectionViewCell
}

protocol TableViewCellProtocol: BaseCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell
}

protocol TableViewSectionCellProtocol: BaseCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, object: T) -> UITableViewCell
}

