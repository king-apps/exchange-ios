import UIKit


extension StickerListViewController: StickerFilterDelegate {
    
    func stickerFilterDidClose() {
        viewFilterBadge.isHidden = !LocalConfig.shared.filterStickerIsActive()
        fetch()
    }
    
}
