import Foundation


struct AdPlacementResolver {
    
    static func adUnitID(for placement: AdPlacement) -> String {
        switch placement {
            
            // General
            case .appOpen: return AppEnvironment.adAppOpen
            case .reward: return AppEnvironment.adReward
            
            // Match
            case .matchMakerBanner: return AppEnvironment.adBanner
            
            // Stickers
            case .stickerListBanner: return AppEnvironment.adBanner
            
            // Chat
            case .chatListBanner: return AppEnvironment.adBanner
            
            // Profile
            case .profileListBanner: return AppEnvironment.adBanner
        }
        
    }
    
}
