import GoogleMobileAds


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
