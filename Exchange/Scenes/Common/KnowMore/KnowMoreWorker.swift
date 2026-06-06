//
//  KnowMoreWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import StoreKit
import KingOS


class KnowMoreWorker {
   
    
    // Handler load
    func load(option: KnowMoreOption?, completion: @escaping(
        _ icon: AppTheme.Icon,
        _ iconColor: UIColor,
        _ title: String,
        _ subtitle: String,
        _ description: String,
        _ buttonTitle: String,
        _ buttonIsEnabled: Bool
    ) -> ()) {
        
        var icon: AppTheme.Icon = .none
        var iconColor: UIColor = .brandPrimary500
        var title = ""
        var subtitle = ""
        var description = ""
        var buttonTitle = ""
        var buttonIsEnabled = true
        
        if let option = option {
            switch option {
            case .superLike:
                icon = .starFill
                iconColor = .matchSuperLike
                title = "KnowMore.SuperLike.Title".localized
                subtitle = "KnowMore.SuperLike.Subtitle".localized
                description = "KnowMore.SuperLike.Description".localized
                buttonTitle = "KnowMore.SuperLike.ButtonTitle".localized
                buttonIsEnabled = true
                break
            case .superLikeSuccess:
                icon = .checkCircle
                iconColor = .success500
                title = "KnowMore.SuperLike.Success.Title".localized
                subtitle = "KnowMore.SuperLike.Success.Subtitle".localized
                description = "KnowMore.SuperLike.Success.Description".localized
                buttonTitle = "KnowMore.SuperLike.Success.ButtonTitle".localized
                buttonIsEnabled = true
                break
            case .boostProfile:
                icon = .rocket
                iconColor = .matchBoost
                title = "KnowMore.BoostProfile.Title".localized
                subtitle = "KnowMore.BoostProfile.Subtitle".localized
                description = "KnowMore.BoostProfile.Description".localized
                buttonTitle = "KnowMore.BoostProfile.ButtonTitle".localized
                buttonIsEnabled = false
                break
            case .boostProfileIsActive:
                icon = .checkCircle
                iconColor = .success500
                title = "KnowMore.BoostProfile.IsActive.Title".localized
                subtitle = "KnowMore.BoostProfile.IsActive.Subtitle".localized
                description = "KnowMore.BoostProfile.IsActive.Description".localized
                buttonTitle = "KnowMore.BoostProfile.IsActive.ButtonTitle".localized
                buttonIsEnabled = true
                break
            case .deleteAccount:
                icon = .alertCircle
                iconColor = .error500
                title = "KnowMore.DeleteAccount.Title".localized
                subtitle = "KnowMore.DeleteAccount.Subtitle".localized
                description = "KnowMore.DeleteAccount.Description".localized
                buttonTitle = "KnowMore.DeleteAccount.ButtonTitle".localized
                buttonIsEnabled = true
                break
            case .denunciate:
                icon = .alertCircle
                iconColor = .warning500
                title = "KnowMore.Denunciate.Title".localized
                subtitle = "KnowMore.Denunciate.Subtitle".localized
                description = "KnowMore.Denunciate.Description".localized
                buttonTitle = "KnowMore.Denunciate.ButtonTitle".localized
                buttonIsEnabled = true
                break
            case .denunciateSuccess:
                icon = .checkCircle
                iconColor = .success500
                title = "KnowMore.Denunciate.Success.Title".localized
                subtitle = "KnowMore.Denunciate.Success.Subtitle".localized
                description = "KnowMore.Denunciate.Success.Description".localized
                buttonTitle = "KnowMore.Denunciate.Success.ButtonTitle".localized
                buttonIsEnabled = true
                break
            case .stickerImage:
                icon = .camera
                iconColor = .brandPrimary500
                title = "KnowMore.Stickers.Image.Title".localized
                subtitle = "KnowMore.Stickers.Image.Subtitle".localized
                description = "KnowMore.Stickers.Image.Description".localized
                buttonTitle = "KnowMore.Stickers.Image.ButtonTitle".localized
                buttonIsEnabled = true
                break
            case .stickerInfo:
                icon = .helpCircle
                iconColor = .brandPrimary500
                title = "KnowMore.Stickers.Info.Title".localized
                subtitle = "KnowMore.Stickers.Info.Subtitle".localized
                description = "KnowMore.Stickers.Info.Description".localized
                buttonTitle = "KnowMore.Stickers.Info.ButtonTitle".localized
                buttonIsEnabled = true
                break
            case .stickerLocked:
                icon = .lock
                iconColor = .warning500
                title = "KnowMore.Stickers.Locked.Title".localized
                subtitle = "KnowMore.Stickers.Locked.Subtitle".localized
                description = "KnowMore.Stickers.Locked.Description".localized
                buttonTitle = "KnowMore.Stickers.Locked.ButtonTitle".localized
                buttonIsEnabled = true
                break
            case .matchMakerAddProduct:
                icon = .plus
                iconColor = .brandPrimary500
                title = "KnowMore.MatchMaker.AddProduct.Title".localized
                subtitle = "KnowMore.MatchMaker.AddProduct.Subtitle".localized
                description = "KnowMore.MatchMaker.AddProduct.Description".localized
                buttonTitle = "KnowMore.MatchMaker.AddProduct.Button".localized
                buttonIsEnabled = true
                break
            case .matchMakerNeedLocation:
                icon = .mapPin
                iconColor = .brandPrimary500
                title = "KnowMore.MatchMaker.NeedLocation.Title".localized
                subtitle = "KnowMore.MatchMaker.NeedLocation.Subtitle".localized
                description = "KnowMore.MatchMaker.NeedLocation.Description".localized
                buttonTitle = "KnowMore.MatchMaker.NeedLocation.Button".localized
                buttonIsEnabled = true
                break
            }
        
        }
        
        completion(
            icon,
            iconColor,
            title,
            subtitle,
            description,
            buttonTitle,
            buttonIsEnabled
        )
        
    }
    
    
    // Handler fetch
    func fetch(option: KnowMoreOption?, completion: @escaping(_ buttonTitle: String?, _ storeProduct: SKProduct?) -> ()) {
        
        if let option = option {
            switch option {
            case .boostProfile:
                let productIdentifier = AppEnvironment.storeProductIdentifier(for: .boostProfile)
                InAppPurchase.shared.request(productIdentifiers: [productIdentifier]) { products, _ in
                    let product = products?.first(where: { $0.productIdentifier == productIdentifier })
                    let price = product?.localizedPrice
                    let title = "KnowMore.BoostProfile.ButtonTitle".localized.replacingOccurrences(of: "{$0}", with: price ?? "")
                    completion(title, product)
                }
                break
            default:
                completion(nil, nil)
                break
            }
        }
        
    }
    
    
    // Handler purchase
    func purchase(product: SKProduct?, completion: @escaping(_ error: String?) -> ()) {
        
        guard let product else {
            completion("Alert.Generic.Error".localized)
            return
        }
        
        InAppPurchase.shared.purchaseConsumable(product: product) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    KingOS.shared.iap.conversion(product: product)
                    completion(nil)
                case .failure(let error):
                    completion(error.localizedDescription)
                }
            }
        }
        
    }
    
    
}
