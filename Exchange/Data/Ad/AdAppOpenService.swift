import UIKit
import GoogleMobileAds


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
    func finish() {
        appOpenAd = nil
        isPresenting = false
        onFinish?()
        onFinish = nil
    }
}
