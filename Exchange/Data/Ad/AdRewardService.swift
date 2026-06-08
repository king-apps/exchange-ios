import Foundation
import UIKit
import GoogleMobileAds


class AdRewardService: NSObject {
    
    
    // Var's
    public static let shared = AdRewardService()
    var adIsReward: Bool = false
    var onFinish: ((_ available: Bool, _ reward: Bool) -> ())?
    
    
    private override init() {
        super.init()
    }
    
    
    // Load
    func load(_ placement: AdPlacement, from: UIViewController, completion: @escaping(_ available: Bool, _ isRewarded: Bool) -> Void) {
        
        self.onFinish = completion
        self.adIsReward = false
        
        let adUnitID = AdPlacementResolver.adUnitID(for: placement)
        let request = Request()
        
        RewardedAd.load(with: adUnitID, request: request, completionHandler: { (ad, error) in
            
            if let _ = error {
                Task { @MainActor in
                    self.finish(available: false, isRewarded: false)
                }
                return
            }
            
            guard let ad else {
                Task { @MainActor in
                    self.finish(available: false, isRewarded: false)
                }
                return
            }
           
            ad.fullScreenContentDelegate = self
            
            Task { @MainActor in
                ad.present(from: from) {
                    self.adIsReward = true
                }
            }
            
        })
        
    }
    
    
    // Finish
    @MainActor
    func finish(available: Bool, isRewarded: Bool) {
        self.onFinish?(available, isRewarded)
        self.onFinish = nil
        self.adIsReward = false
    }
    

}
