import Foundation


struct AdPlacementResolver {
    
    static func adUnitID(for placement: AdPlacement) -> String {
        switch placement {
            
            // General
            case .appOpen: return AppEnvironment.adAppOpen
            case .reward: return AppEnvironment.adReward
            case .loadingBanner: return AppEnvironment.adBanner
            case .instructionListBanner: return AppEnvironment.adBanner
            
            // Home
            case .homeFooterBanner: return AppEnvironment.adBanner
            
            // Questions
            case .questionListBanner: return AppEnvironment.adBanner
            case .savedQuestion: return AppEnvironment.adBanner
            // Study
            case .study: return AppEnvironment.adBanner
            case .themeListBanner: return AppEnvironment.adBanner
            case .categoryListBanner: return AppEnvironment.adBanner
            case .subcategoryListBanner: return AppEnvironment.adBanner
            case .studyMenu: return AppEnvironment.adBanner
            case .supportMaterialFileBanner: return AppEnvironment.adBanner
            case .supportMaterialVideoBanner: return AppEnvironment.adBanner
            
            // Statistic
            case .statisticListBanner: return AppEnvironment.adBanner
            
            // Notification
            case .notificationListBanner: return AppEnvironment.adBanner
            
            // Challenge
            case .challengeListBanner: return AppEnvironment.adBanner
            case .challengeLeaderboardBanner: return AppEnvironment.adBanner
            
            // Filter
            case .filterListBanner: return AppEnvironment.adBanner
            
            // Profile
            case .profileListBanner: return AppEnvironment.adBanner
        }
        
    }
    
}
