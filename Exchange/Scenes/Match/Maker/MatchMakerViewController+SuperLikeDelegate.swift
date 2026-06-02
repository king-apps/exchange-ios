import UIKit
import ZLSwipeableViewSwift


extension MatchMakerViewController: SuperLikeDelegate {
    func superLikeSendSuccess() {
        router?.routeToSuperLikeSuccess()
    }
    func superLikeDidClose() {
        AppHaptics.error()
        if let cardView = viewSwipeable.topView() as? CardView {
            cardView.animationReset()
        }
    }
}
