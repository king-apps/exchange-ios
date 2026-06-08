import UIKit
import KingOS


class IntroWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        LocalConfig.shared.load()
        completion()
    }
    

    // Handler language
    @MainActor func language(completion: @escaping(_ language: String) -> ()) {
        
        var language = "en"
        
        if let languageCode = Locale.preferredLanguages.first {
            if languageCode.starts(with: "pt") {
                language = "pt"
            } else if languageCode.starts(with: "en") {
                language = "en"
            } else if languageCode.starts(with: "es") {
                language = "es"
            }
        }

        LocalConfig.shared.setLanguage(language)
        LocalConfig.shared.save()

        
        completion(language)
        
    }
    
    
    // Handler remote config
    func remote(completion: @escaping() -> ()) {
        
        Task {
            let _ = await KingOS.shared.rc.request()
            RemoteConfig.shared.load(kingRC: KingOS.shared.rc)
            if LocalConfig.shared.getRadius() == 999 {
                LocalConfig.shared.setRadius(RemoteConfig.shared.getMatchFilterRadiusMax())
                LocalConfig.shared.save()
            }
            completion()
        }
        
    }
    
    
    // Handler app open
    func appOpen(completion: @escaping() -> ()) {
        AppStoreReviewService.shared.registerAppOpen()
        completion()
    }
    
    
    // Handler auth
    func auth(completion: @escaping() ->()) {
        Auth.shared.load()
        
        let api = UserApi()
        api.profile { user, error in
            user?.save()
            User.shared.load()
            
            let productApi = ProductApi()
            productApi.boostStatus { remainingMinutes, error in
                User.shared.setBoostRemainingMinutes(remainingMinutes)
                completion()
            }
            
        }
        
    }
    
    
    // Redirect
    func redirect(completion: @escaping(_ isAuth: Bool) -> ()) {
        
        let isAuth = Auth.shared.isAuth()
        completion(isAuth)
        
    }
    
    
}
