//
//  CollectionViewTools.swift
//  
//
//  Created by Basem El-Gendy on 3/4/18.
//  Copyright © 2018 Basem El-Gendy. All rights reserved.
//

import Foundation
import UIKit

final class BGCollectionViewTools {
    

        
        class func formatingCollectionView(_ collectionView:UICollectionView ,topPadding:CGFloat,rightPadding:CGFloat,leftPadding:CGFloat,bottomPadding:CGFloat,width:CGFloat, height:CGFloat,minimumInteritemSpacing:CGFloat,minimumLineSpacing:CGFloat){
            let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flow.sectionInset = UIEdgeInsets(top: topPadding,left: leftPadding,bottom: bottomPadding,right: rightPadding )
            flow.itemSize = CGSize(width: (width) , height: (height) )
            flow.minimumInteritemSpacing = minimumInteritemSpacing
            flow.minimumLineSpacing = minimumLineSpacing
            
        }
    
}
final class BGUICollectionViewPagingFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        let offset = isVertical ? collectionView.contentOffset.y : collectionView.contentOffset.x
        let velocity = isVertical ? velocity.y : velocity.x
        let flickVelocityThreshold: CGFloat = 0.2
        let currentPage = offset / pageSize
        
        if abs(velocity) > flickVelocityThreshold {
            let nextPage = velocity > 0.0 ? ceil(currentPage) : floor(currentPage)
            let nextPosition = nextPage * pageSize
            return isVertical ? CGPoint(x: proposedContentOffset.x, y: nextPosition) : CGPoint(x: nextPosition, y: proposedContentOffset.y)
        } else {
            let nextPosition = round(currentPage) * pageSize
            return isVertical ? CGPoint(x: proposedContentOffset.x, y: nextPosition) : CGPoint(x: nextPosition, y: proposedContentOffset.y)
        }
    }
    
    private var isVertical: Bool {
        return scrollDirection == .vertical
    }
    
    private var pageSize: CGFloat {
        if isVertical {
            return itemSize.height + minimumInteritemSpacing
        } else {
            return itemSize.width + minimumLineSpacing
        }
    }
}

