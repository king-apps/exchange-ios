import Foundation
import KingOS


final class RemoteConfig {
    
    
    // Var's
    static let shared = RemoteConfig()
    
    private var isFeatureAdsEnabled: Bool
    private var chatLoopTime: Int
    
    private var matchFilterRadiusMin: Int
    private var matchFilterRadiusMax: Int
    
    private var superLikeMaxLength: Int
    
    private var urlTerms: String
    private var urlPrivacy: String
    private var urlAppStore: String
    private var urlShare: String
    
    private var productImageMaxWidth: Int
    private var productImageMaxHeight: Int
    
    private var boostProfileMinutes: Int
    
    
    // Construct
    private init() {
        isFeatureAdsEnabled = true
        chatLoopTime = 30
        
        matchFilterRadiusMin = 1
        matchFilterRadiusMax = 999
        
        superLikeMaxLength = 300
        
        urlTerms = ""
        urlPrivacy = ""
        urlAppStore = ""
        urlShare = ""
        
        productImageMaxWidth = 500
        productImageMaxHeight = 500
        
        boostProfileMinutes = 60
    }
    func load(kingRC: KingRC) {
        isFeatureAdsEnabled << kingRC.bool("feature_ads_enabled")
        chatLoopTime << kingRC.int("chat_loop_time")
        
        matchFilterRadiusMin << kingRC.int("match_filter_radius_min")
        matchFilterRadiusMax << kingRC.int("match_filter_radius_max")
        
        superLikeMaxLength << kingRC.int( "super_like_max_length")
        
        urlTerms << kingRC.string("url_terms")
        urlPrivacy << kingRC.string("url_privacy")
        urlAppStore << kingRC.string("url_app_store")
        urlShare << kingRC.string("url_share")
        
        productImageMaxWidth << kingRC.int("product_image_max_width")
        productImageMaxHeight << kingRC.int("product_image_max_height")
        
        boostProfileMinutes << kingRC.int("boost_profile_minutes")
    }
    
    
    // Get's
    func getIsFeatureAdsEnabled() -> Bool {
        return isFeatureAdsEnabled
    }
    func getChatLoopTime() -> Int {
        return chatLoopTime
    }
    func getMatchFilterRadiusMin() -> Int {
        return matchFilterRadiusMin
    }
    func getMatchFilterRadiusMax() -> Int {
        return matchFilterRadiusMax
    }
    func getSuperLikeMaxLength() -> Int {
        return superLikeMaxLength
    }
    func getUrlTerms() -> String {
        return urlTerms
    }
    func getUrlPrivacy() -> String {
        return urlPrivacy
    }
    func getUrlAppStore() -> String {
        return urlAppStore
    }
    func getUrlShare() -> String {
        return urlShare
    }
    func getProductImageMaxWidth() -> Int {
        return productImageMaxWidth
    }
    func getProductImageMaxHeight() -> Int {
        return productImageMaxHeight
    }
    func getBoostProfileMinutes() -> Int {
        return boostProfileMinutes
    }
}
