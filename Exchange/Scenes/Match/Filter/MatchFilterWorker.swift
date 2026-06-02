import UIKit


class MatchFilterWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler fetch
    func fetch(completion: @escaping(_ localConfig: LocalConfig, _ remoteConfig: RemoteConfig) -> ()) {
        let localConfig = LocalConfig.shared
        let remoteConfig = RemoteConfig.shared
        completion(localConfig, remoteConfig)
    }
    
    
    // Handler save
    func save(radius: Float, completion: @escaping() -> ()) {
        let radius = Int(radius)
        
        if LocalConfig.shared.getRadius() != radius {
            LocalConfig.shared.setRadius(radius)
            LocalConfig.shared.setHasChanged(true)
            LocalConfig.shared.save()
        }
        
        completion()
    }
    
    
}
