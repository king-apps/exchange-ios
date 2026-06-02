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


extension AdRewardService: FullScreenContentDelegate {
    
    nonisolated
    func adDidDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        Task { @MainActor in
            // Gives the reward callback a brief moment to arrive before finalizing the flow.
            try? await Task.sleep(nanoseconds: 200_000_000)
            self.finish(available: true, isRewarded: self.adIsReward)
        }
    }
    
    nonisolated
    func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        Task { @MainActor in
            self.finish(available: false, isRewarded: false)
        }
    }
    
}


class AdAppOpenService: NSObject {

    public static let shared = AdAppOpenService()

    private var appOpenAd: AppOpenAd?
    private var onFinish: (() -> Void)?
    private var isPresenting = false
    private var canAttemptInCurrentForeground = true

    private override init() {
        super.init()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
    }

    @objc
    private func handleDidEnterBackground() {
        canAttemptInCurrentForeground = true
    }

    func presentIfNeeded(from viewController: UIViewController, completion: @escaping () -> Void) {
        guard AppAdPolicy.shouldShowAds() else {
            completion()
            return
        }

        guard AppEnvironment.adAppOpen.isEmpty == false else {
            completion()
            return
        }

        guard canAttemptInCurrentForeground, isPresenting == false else {
            completion()
            return
        }

        canAttemptInCurrentForeground = false
        onFinish = completion

        AppOpenAd.load(
            with: AdPlacementResolver.adUnitID(for: .appOpen),
            request: Request()
        ) { ad, error in
            guard error == nil, let ad else {
                Task { @MainActor in
                    self.finish()
                }
                return
            }

            self.appOpenAd = ad
            ad.fullScreenContentDelegate = self

            Task { @MainActor in
                do {
                    try ad.canPresent(from: viewController)
                    self.isPresenting = true
                    ad.present(from: viewController)
                } catch {
                    self.finish()
                }
            }
        }
    }

    @MainActor
    private func finish() {
        appOpenAd = nil
        isPresenting = false
        onFinish?()
        onFinish = nil
    }
}


extension AdAppOpenService: FullScreenContentDelegate {

    nonisolated
    func adDidDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        Task { @MainActor in
            self.finish()
        }
    }

    nonisolated
    func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        Task { @MainActor in
            self.finish()
        }
    }
}
