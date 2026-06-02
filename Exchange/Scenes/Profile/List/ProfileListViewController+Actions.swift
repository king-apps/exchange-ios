import UIKit
import StoreKit


extension ProfileListViewController {
    
    
    // Rate
    func ratingApp() {
        let url = RemoteConfig.shared.getUrlAppStore()
        if let appStoreUrl = appStoreReviewURL(from: url) {
            UIApplication.shared.open(appStoreUrl)
            return
        }
        
        guard let windowScene = view.window?.windowScene ?? UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        SKStoreReviewController.requestReview(in: windowScene)
    }
    func appStoreReviewURL(from value: String) -> URL? {
        guard let url = value.normalizedURL() else {
            return nil
        }

        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return url
        }

        var queryItems = components.queryItems ?? []
        if queryItems.contains(where: { $0.name == "action" }) == false {
            queryItems.append(URLQueryItem(name: "action", value: "write-review"))
        }
        components.queryItems = queryItems

        return components.url ?? url
    }
    
    
    // Share
    func shareApp() {
        guard let url = RemoteConfig.shared.getUrlShare().normalizedURL() else {
            return
        }
        
        let items: [Any] = [url]
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = view
            popover.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        present(activityVC, animated: true)
    }
 
    
}
