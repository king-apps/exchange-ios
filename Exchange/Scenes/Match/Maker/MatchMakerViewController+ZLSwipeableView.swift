//
//  MatchMakerViewController+ZLviewSwipeable.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 3/16/21.
//
import UIKit
import Foundation
import ZLSwipeableViewSwift


extension MatchMakerViewController {
    
    func setupViewSwipeable() {
        
        viewSwipeable.didStart = {view, location in
        }
        viewSwipeable.swiping = {view, location, translation in
            if let card = view as? CardView {
                card.imageViewLike.alpha = translation.x > 0 ? translation.x/100 : 0.0
                card.effectViewLike.alpha = card.imageViewLike.alpha
                card.imageViewNope.alpha = translation.x < 0 ? -translation.x/100 : 0.0
                card.effectViewNope.alpha = card.imageViewNope.alpha
                //card.imageViewSuperLike.alpha = translation.y < -(card.bounds.height * 0.3) ? -(translation.y + (card.bounds.height * 0.3))/100 : 0/0
                //card.effectViewSuperLike.alpha = card.imageViewSuperLike.alpha
            }
        }
        viewSwipeable.didEnd = {view, location in
            
        }
        viewSwipeable.didSwipe = {view, direction, vector in
            if let card = view as? CardView {
                
                if self.myProducts <= 0 && (direction == .Left || direction == .Right){
                    self.viewSwipeable.rewind()
                    self.resetEffectCard(card: card)
                    AppHaptics.warning()
                    self.handlerNeedAddProduct()
                }
                else {
                    let productId = card.tag
                    
                    if direction == .Right {
                        self.intention(productId: productId, option: .Like)
                    }
                    if direction == .Left {
                        self.intention(productId: productId, option: .Nope)
                    }
                }
            }
        }
        viewSwipeable.didCancel = {view in
            
            if let card = view as? CardView {
                if card.imageViewLike.alpha >= 1 {
                    self.didLike()
                }
                if card.imageViewNope.alpha >= 1 {
                    self.didNope()
                }
                /*
                if card.imageViewSuperLike.alpha >= 1 {
                    self.didSuperLike()
                }
                */
                self.resetEffectCard(card: card)
            }
        }
        viewSwipeable.didTap = {view, location in
            if let card = view as? CardView {
                let productId = card.tag
                self.detail(productId: productId)
            }
        }
        viewSwipeable.didDisappear = { view in
            if let card = view as? CardView {
                card.imageViewLike.alpha = 0
                card.effectViewLike.alpha = 0
                card.imageViewNope.alpha = 0
                card.effectViewNope.alpha = 0
            }
        }
        
    }
    func resetEffectCard(card: CardView) {
        card.imageViewLike.alpha = 0
        card.imageViewNope.alpha = 0
        card.imageViewSuperLike.alpha = 0
        card.effectViewLike.alpha = 0
        card.effectViewNope.alpha = 0
        card.effectViewSuperLike.alpha = 0
    }
    func toRadian(_ degree: CGFloat) -> CGFloat {
        return degree * CGFloat(Double.pi/180)
    }
    func rotateAndTranslateView(_ view: UIView, forDegree degree: CGFloat, translation: CGPoint, duration: TimeInterval, offsetFromCenter offset: CGPoint, swipeableView: ZLSwipeableView) {
        UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
            view.center = swipeableView.convert(swipeableView.center, from: swipeableView.superview)
            var transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            transform = transform.rotated(by: self.toRadian(degree))
            transform = transform.translatedBy(x: -offset.x, y: -offset.y)
            transform = transform.translatedBy(x: translation.x, y: translation.y)
            view.transform = transform
            }, completion: nil)
    }
    
    
}
