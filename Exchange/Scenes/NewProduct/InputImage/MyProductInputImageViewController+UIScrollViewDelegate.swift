//
//  MyProductInputImageViewController+UIScrollViewDelegate.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 3/5/21.
//

import UIKit
import Foundation


extension MyProductInputImageViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        let page = round(scrollView.contentOffset.x/scrollView.bounds.width)
        pageControl.currentPage = Int(page)
        
    }
    
}
