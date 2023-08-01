//
//  PaywallViewController.swift
//  SpotifyPaywall
//
//  Created by 최지연/클라이언트 on 2023/08/01.
//

import UIKit

class PaywallViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let bannerInfos: [BannerInfo] = BannerInfo.list
    let colors: [UIColor] = [.systemPurple, .systemOrange, .systemPink, .systemRed]
    
    enum Section {
        case main
    }
    var datasource: UICollectionViewDiffableDataSource<Section, BannerInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource = UICollectionViewDiffableDataSource<Section, BannerInfo>.init(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell else {
                return nil
            }
            cell.configure(item)
            cell.backgroundColor = self.colors[indexPath.item]
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, BannerInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(bannerInfos, toSection: .main)
        datasource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
        collectionView.alwaysBounceVertical = false
        
        self.pageControl.numberOfPages = bannerInfos.count
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(200)) // absolute 고정높이 200
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) // horizontal 스크롤 방향 가로
        
        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.orthogonalScrollingBehavior = .groupPaging
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 20 // 그룹간 마진 설정

        section.visibleItemsInvalidationHandler = { (items, offset, env) in
            let index = Int((offset.x / env.container.contentSize.width).rounded(.up))
            print("--> \(index)")
            self.pageControl.currentPage = index
        }
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
