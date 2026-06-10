import UIKit

extension MatchMakerViewController: MatchFilterDelegate {
    
    
    func matchFilterDidClose() {
        
        viewFilterBadge.isHidden = !LocalConfig.shared.filterIsActive()
        if LocalConfig.shared.getHasChanged() {
            LocalConfig.shared.setHasChanged(false)
            reloadIfNeeded()
        }
        
    }
    
    
}

