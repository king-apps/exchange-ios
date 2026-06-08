import UIKit
import GoogleMobileAds


class AdBannerService {
    
    
    // Var's
    public static let shared = AdBannerService()
    private var cache: [AdPlacement : BannerView] = [:]
    private var loadedWidths: [AdPlacement : CGFloat] = [:]
    
    
    // Load
    @discardableResult
    func load(_ placement: AdPlacement, width: CGFloat, viewController: UIViewController) -> CGFloat {
        let adSize = currentOrientationAnchoredAdaptiveBanner(width: width)
        
        let work = {
            // Se esta em cache, verifica o root e altera se necessario
            if let banner = self.cache[placement] {
                if banner.rootViewController != viewController {
                    banner.rootViewController = viewController
                }
                
                let loadedWidth = self.loadedWidths[placement] ?? 0
                if abs(loadedWidth - width) > 1 {
                    banner.adSize = adSize
                    banner.load(Request())
                    self.loadedWidths[placement] = width
                }
            }
            // Se nao esta em cache, entao cria e adiciona no cache
            else {
                let view = BannerView()
                view.adUnitID = AdPlacementResolver.adUnitID(for: placement)
                view.rootViewController = viewController
                view.adSize = adSize
                view.load(Request())
                self.cache[placement] = view
                self.loadedWidths[placement] = width
            }
        }
        
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.sync(execute: work)
        }
        
        return adSize.size.height
    }    
    
    // Banner view
    func view(for placement: AdPlacement) -> UIView? {
        return cache[placement]
    }

}
