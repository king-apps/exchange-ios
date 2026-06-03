import UIKit


enum AppAdPolicy {
    
    static func shouldShowAds() -> Bool {
        let isAdsEnabled = RemoteConfig.shared.getIsFeatureAdsEnabled()
        let isPremiumUser = InAppPurchase.shared.isPremium()
        let shouldShowAd = isAdsEnabled && !isPremiumUser
        return shouldShowAd
    }
    
}

enum AppHaptics {
    
    enum ImpactStyle {
        case light
        case medium
        case heavy
        case soft
        case rigid
    }
    
    static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    static func success() {
        notification(.success)
    }
    
    static func warning() {
        notification(.warning)
    }
    
    static func error() {
        notification(.error)
    }
    
    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
    static func impact(_ style: ImpactStyle, intensity: CGFloat? = nil) {
        let generator: UIImpactFeedbackGenerator
        
        switch style {
        case .light:
            generator = UIImpactFeedbackGenerator(style: .light)
        case .medium:
            generator = UIImpactFeedbackGenerator(style: .medium)
        case .heavy:
            generator = UIImpactFeedbackGenerator(style: .heavy)
        case .soft:
            generator = UIImpactFeedbackGenerator(style: .soft)
        case .rigid:
            generator = UIImpactFeedbackGenerator(style: .rigid)
        }
        
        generator.prepare()
        
        if let intensity {
            generator.impactOccurred(intensity: intensity)
        }
        else {
            generator.impactOccurred()
        }
    }
    
    static func tap() {
        impact(.light)
    }
    
    static func confirm() {
        impact(.medium)
    }
    
    static func emphasize() {
        impact(.soft)
    }
}


extension MainBaseViewController {
    
    
    func notificationFeedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        AppHaptics.notification(type)
    }
    
    func selectionFeedback() {
        AppHaptics.selection()
    }
    
    // Handler validate list
    func rowsIsEmpty() -> Bool {

        return rows.contains { row in
            if case .inputText(let model) = row {
                return model.value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
            return false
        }
    }
    func rowsIsValid() -> Bool {

        var isValid = true
        var rowsToReload: [IndexPath] = []

        for i in rows.indices {

            switch rows[i] {

            case .inputText(var model):
                if let error = model.getError() {
                    model.error = error
                    rows[i] = .inputText(model)
                    isValid = false
                    rowsToReload.append(IndexPath(row: i, section: 0))
                } else {
                    // opcional: limpar erro se antes existia
                    if !model.error.isEmpty {
                        model.error = ""
                        rows[i] = .inputText(model)
                        rowsToReload.append(IndexPath(row: i, section: 0))
                    }
                }

            default:
                break
            }
        }

        if !rowsToReload.isEmpty {
            tableView?.reloadRows(at: rowsToReload, with: .none)
        }

        return isValid
    }


    // Table view insets
    func applyTableViewInsetsLg() {
        tableView?.contentInset = UIEdgeInsets(
            top: AppTheme.Spacing.lg.rawValue,
            left: 0,
            bottom: AppTheme.Spacing.lg.rawValue,
            right: 0
        )
    }
    
    
    // Handler alert
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Alert.Action.Close".localized, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func displayAlert(_ title: String?, message: String) {
        displayAlert(title: title ?? "Alert.Title.Warning".localized, message: message)
    }

    func reloadMatchMakerIfNeeded() {
        NotificationCenter.default.post(name: .reloadMatchMaker, object: nil)
    }
    func reloadChatListIfNeeded() {
        NotificationCenter.default.post(name: .reloadChatList, object: nil)
    }
    func reloadProfileIfNeeded() {
        NotificationCenter.default.post(name: .reloadProfile, object: nil)
    }
    func reloadProductListIfNeeded() {
        NotificationCenter.default.post(name: .reloadProductList, object: nil)
    }
    func reloadFilterListIfNeeded() {
        NotificationCenter.default.post(name: .reloadFilterList, object: nil)
    }
    func reloadAllIfNeeded() {
        reloadMatchMakerIfNeeded()
        reloadChatListIfNeeded()
        reloadProfileIfNeeded()
        reloadProfileIfNeeded()
        reloadFilterListIfNeeded()
    }

    func setChatBadgeValue(value: Int) {
        if let root = self.parent as? RootViewController {
            root.setChatBadgeValue(value: value)
        }
        else {
            if let root = self.parent?.parent as? RootViewController {
                root.setChatBadgeValue(value: value)
            }
        }
    }
    func addChatBadgeValue() {
        if let root = self.parent as? RootViewController {
            root.addChatBadgeValue()
        }
        else {
            if let root = self.parent?.parent as? RootViewController {
                root.addChatBadgeValue()
            }
        }
    }

    func setTabBarSelectedIndex(index: Int) {
        tabBarController?.selectedIndex = index
    }

    
    
    
    func unSelectDefaultRows(ignoreIndexPath: IndexPath) {
        
        for i in 0 ..< rows.count {
            
            switch rows[i] {
            case .default(var model):
                if model.style != .normal {
                    model.style = .normal
                    rows[i] = .default(model)
                    if i != ignoreIndexPath.row {
                        DispatchQueue.main.async {
                            self.tableView?.reloadRows(at: [IndexPath(row: i, section: ignoreIndexPath.section)], with: .fade)
                        }
                    }
                }
                break
            default:
                break
            }
            
        }
    
    }
    
    
    // Ad
    func hasAd() -> Bool {
        if AppAdPolicy.shouldShowAds() {
            return true
        } else {
            self.removeAd()
            return false
        }
    }
    func adARewardShowAlertIfNeeded(available: Bool, isRewarded: Bool, completion: @escaping(_ isRewarded: Bool) -> ())  {
        
        if isRewarded {
            completion(true)
        }
        else {
            
            let message = available == true ? "Ad.Reward.Unviewed" : "Ad.Reward.Unavailable"
            let alert = UIAlertController(
                title: "Alert.Title.Warning".localized,
                message: message.localized,
                preferredStyle: .alert
            )
            let action = UIAlertAction(title: "Alert.Action.Close".localized, style: .default) { _ in
                completion(false)
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
    }
    private func removeAd() {
        self.adBannerView?.superview?.removeFromSuperview()
    }

    
}
