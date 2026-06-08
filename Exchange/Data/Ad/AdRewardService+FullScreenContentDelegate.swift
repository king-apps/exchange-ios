import GoogleMobileAds


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
