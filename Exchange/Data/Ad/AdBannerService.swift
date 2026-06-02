import UIKit
import GoogleMobileAds


class AdBannerService {
    
    
    // Var's
    public static let shared = AdBannerService()
    private var cache: [AdPlacement : BannerView] = [:]
    
    
    // Load
    func load(_ placement: AdPlacement, viewController: UIViewController) {
        
        let work = {
            // Se esta em cache, verifica o root e altera se necessario
            if let banner = self.cache[placement] {
                if banner.rootViewController != viewController {
                    banner.rootViewController = viewController
                }
            }
            // Se nao esta em cache, entao cria e adiciona no cache
            else {
                let view = BannerView()
                view.adUnitID = AdPlacementResolver.adUnitID(for: placement)
                view.rootViewController = viewController
                view.adSize = self.adSize(for: placement)
                view.load(Request())
                self.cache[placement] = view
            }
        }
        
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.sync(execute: work)
        }
        
    }
    
    
    // Banner view
    func view(for placement: AdPlacement) -> UIView? {
        return cache[placement]
    }
    
    
    // Size banner
    private func adSize(for placement: AdPlacement) -> AdSize {
        if placement == .loadingBanner {
            return AdSizeLargeBanner
        }
        return AdSizeBanner
    }
    

}
