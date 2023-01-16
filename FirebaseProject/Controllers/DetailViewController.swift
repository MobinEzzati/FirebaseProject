//
//  DetailController.swift
//  FirebaseProject
//
//  Created by mobin on 1/15/23.
//

import Foundation
import UIKit

class DetailViewController:UICollectionViewController{
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>

    var dataSource: DataSource!

    var userDetail: UserModel!
    var data = [String]()
       
    override func viewDidLoad() {
        super.viewDidLoad()
      
        data.append(userDetail.fullName)
        data.append(userDetail.phoneNumber)
        data.append(userDetail.password)
        data.append(userDetail.email)

        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = self.data[indexPath.row]
            cell.contentConfiguration = contentConfiguration
            }
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            }
        var snapshot = Snapshot()
          snapshot.appendSections([0])
        snapshot.appendItems(data)
          dataSource.apply(snapshot)
          
          collectionView.dataSource = dataSource
        
        
    }
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
        
    }
}
