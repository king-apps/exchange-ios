import UIKit
import Kingfisher


protocol StickerListCellDelegate: AnyObject {
    func stickerListCellOpenCamera(id: Int)
    func stickerListCellOpenProduct(id: Int)
    func stickerListCellDidTapSticker(id: Int)
    func stickerListCellDidLongPressSticker(id: Int)
}


class StickerListCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var viewCard1: UIView!
    @IBOutlet var imageViewSticker1: UIImageView!
    
    @IBOutlet var viewTitle1: UIView!
    @IBOutlet var labelTitle1: UILabel!
    @IBOutlet var labelDescription1: UILabel!
    
    @IBOutlet var viewName1: UIView!
    @IBOutlet var labelName1: UILabel!
    @IBOutlet var imageViewGradient1: UIView!
    
    @IBOutlet var viewLabelCount1: UIView!
    @IBOutlet var labelCount1: UILabel!
    @IBOutlet var buttonCamera1: UIButtonBase!
    
    
    @IBOutlet var viewCard2: UIView!
    @IBOutlet var imageViewSticker2: UIImageView!
    
    @IBOutlet var viewTitle2: UIView!
    @IBOutlet var labelTitle2: UILabel!
    @IBOutlet var labelDescription2: UILabel!
    
    @IBOutlet var viewName2: UIView!
    @IBOutlet var labelName2: UILabel!
    @IBOutlet var imageViewGradient2: UIView!
    
    @IBOutlet var viewLabelCount2: UIView!
    @IBOutlet var labelCount2: UILabel!
    @IBOutlet var buttonCamera2: UIButtonBase!
    
    
    @IBOutlet var viewCard3: UIView!
    @IBOutlet var imageViewSticker3: UIImageView!
    
    @IBOutlet var viewTitle3: UIView!
    @IBOutlet var labelTitle3: UILabel!
    @IBOutlet var labelDescription3: UILabel!
    
    @IBOutlet var viewName3: UIView!
    @IBOutlet var labelName3: UILabel!
    @IBOutlet var imageViewGradient3: UIView!
    
    @IBOutlet var viewLabelCount3: UIView!
    @IBOutlet var labelCount3: UILabel!
    @IBOutlet var buttonCamera3: UIButtonBase!
    
    
    @IBOutlet var viewCard4: UIView!
    @IBOutlet var imageViewSticker4: UIImageView!
    
    @IBOutlet var viewTitle4: UIView!
    @IBOutlet var labelTitle4: UILabel!
    @IBOutlet var labelDescription4: UILabel!
    
    @IBOutlet var viewName4: UIView!
    @IBOutlet var labelName4: UILabel!
    @IBOutlet var imageViewGradient4: UIView!
    
    @IBOutlet var viewLabelCount4: UIView!
    @IBOutlet var labelCount4: UILabel!
    @IBOutlet var buttonCamera4: UIButtonBase!
    
    
    var delegate: StickerListCellDelegate?
    private var collectedByStickerId: [Int: Int] = [:]
    private var buttonActions: [ObjectIdentifier: ButtonAction] = [:]
    
    private enum ButtonAction {
        case openCamera(stickerId: Int)
        case openProduct(productId: Int)
    }
    
    
    // Awake
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageViewSticker1.layer.cornerRadius = AppTheme.Radius.lg
        imageViewSticker1.backgroundColor = AppTheme.Colors.backgroundDisabled
        imageViewSticker2.layer.cornerRadius = AppTheme.Radius.lg
        imageViewSticker2.backgroundColor = AppTheme.Colors.backgroundDisabled
        imageViewSticker3.layer.cornerRadius = AppTheme.Radius.lg
        imageViewSticker3.backgroundColor = AppTheme.Colors.backgroundDisabled
        imageViewSticker4.layer.cornerRadius = AppTheme.Radius.lg
        imageViewSticker4.backgroundColor = AppTheme.Colors.backgroundDisabled
        
        viewLabelCount1.layer.cornerRadius = viewLabelCount1.bounds.height / 2
        viewLabelCount2.layer.cornerRadius = viewLabelCount2.bounds.height / 2
        viewLabelCount3.layer.cornerRadius = viewLabelCount3.bounds.height / 2
        viewLabelCount4.layer.cornerRadius = viewLabelCount4.bounds.height / 2
        
        setupStickerGestureRecognizers()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        collectedByStickerId.removeAll()
        buttonActions.removeAll()
        resetStickerCardState(viewCard1)
        resetStickerCardState(viewCard2)
        resetStickerCardState(viewCard3)
        resetStickerCardState(viewCard4)
    }
    
    
    // Model
    struct Model {
        var color: UIColor
        var items: [Item]
    }
    
    
    // Item
    struct Item {
        var id: Int
        var idProduct: Int
        var title: String
        var description: String
        var collected: Int
        var imageUrl: String
        var image: UIImage?
    }
    
    
    // Setup
    func setup(model: Model) {
        collectedByStickerId.removeAll()
        
        // Colors
        imageViewGradient1.tintColor = model.color
        imageViewGradient2.tintColor = model.color
        imageViewGradient3.tintColor = model.color
        imageViewGradient4.tintColor = model.color
        
        // 1
        setupItem(
            item(at: 0, in: model.items),
            color: model.color,
            cardView: viewCard1,
            stickerImageView: imageViewSticker1,
            titleView: viewTitle1,
            titleLabel: labelTitle1,
            descriptionLabel: labelDescription1,
            viewCountLabel: viewLabelCount1,
            countLabel: labelCount1,
            cameraButton: buttonCamera1,
            nameView: viewName1,
            nameLabel: labelName1
        )
        
        // 2
        setupItem(
            item(at: 1, in: model.items),
            color: model.color,
            cardView: viewCard2,
            stickerImageView: imageViewSticker2,
            titleView: viewTitle2,
            titleLabel: labelTitle2,
            descriptionLabel: labelDescription2,
            viewCountLabel: viewLabelCount2,
            countLabel: labelCount2,
            cameraButton: buttonCamera2,
            nameView: viewName2,
            nameLabel: labelName2
        )
        
        // 3
        setupItem(
            item(at: 2, in: model.items),
            color: model.color,
            cardView: viewCard3,
            stickerImageView: imageViewSticker3,
            titleView: viewTitle3,
            titleLabel: labelTitle3,
            descriptionLabel: labelDescription3,
            viewCountLabel: viewLabelCount3,
            countLabel: labelCount3,
            cameraButton: buttonCamera3,
            nameView: viewName3,
            nameLabel: labelName3
        )
        
        // 4
        setupItem(
            item(at: 3, in: model.items),
            color: model.color,
            cardView: viewCard4,
            stickerImageView: imageViewSticker4,
            titleView: viewTitle4,
            titleLabel: labelTitle4,
            descriptionLabel: labelDescription4,
            viewCountLabel: viewLabelCount4,
            countLabel: labelCount4,
            cameraButton: buttonCamera4,
            nameView: viewName4,
            nameLabel: labelName4
        )
        
        
    }
    
    
    // Setup item
    private func item(at index: Int, in items: [Item]) -> Item? {
        guard items.indices.contains(index) else { return nil }
        return items[index]
    }
    
    private func setupItem(
        _ item: Item?,
        color: UIColor,
        cardView: UIView,
        stickerImageView: UIImageView,
        titleView: UIView,
        titleLabel: UILabel,
        descriptionLabel: UILabel,
        viewCountLabel: UIView,
        countLabel: UILabel,
        cameraButton: UIButton,
        nameView: UIView,
        nameLabel: UILabel
    ) {
        resetStickerCardState(cardView)
        
        guard let item else {
            cardView.isHidden = true
            cardView.tag = 0
            return
        }
        
        cardView.isHidden = false
        stickerImageView.backgroundColor = stickerBackgroundColor(for: item, color: color)
        stickerImageView.image = nil
        stickerImageView.kf.cancelDownloadTask()
        cardView.tag = item.id
        collectedByStickerId[item.id] = item.collected
        
        if let image = item.image {
            stickerImageView.image = image
            stickerImageView.contentMode = .scaleAspectFill
        }
        else if let imageUrl = URL(string: item.imageUrl), item.imageUrl.isEmpty == false {
            stickerImageView.kf.setImage(with: imageUrl)
            stickerImageView.contentMode = .scaleAspectFill
        }
        else {
            stickerImageView.contentMode = .center
        }
        
        titleLabel.text = item.title
        titleLabel.textColor = stickerTextColor(for: item)
        descriptionLabel.text = item.description
        descriptionLabel.textColor = titleLabel.textColor
        
        viewCountLabel.backgroundColor = item.collected > 1 ? AppTheme.Colors.error500 : .clear
        countLabel.text = item.collected >= 10 ? "\(item.collected)" : "\(item.collected)x"
        countLabel.textColor = stickerCountColor(for: item)
        
        setupActionButton(cameraButton, for: item)
        
        stickerImageView.isUserInteractionEnabled = false
        titleView.isUserInteractionEnabled = false
        titleLabel.isUserInteractionEnabled = false
        descriptionLabel.isUserInteractionEnabled = false
        countLabel.isUserInteractionEnabled = false
        nameView.isUserInteractionEnabled = false
        nameLabel.isUserInteractionEnabled = false
        
        nameView.isHidden = item.imageUrl.isEmpty && item.image == nil
        titleView.isHidden = !nameView.isHidden
        nameLabel.text = "\(item.title) \(item.description)"
    }
    
    private func hasCollectedSticker(_ item: Item) -> Bool {
        item.collected > 0
    }
    
    private func canOpenCamera(for item: Item) -> Bool {
        item.collected > 1
    }
    
    private func canOpenProduct(for item: Item) -> Bool {
        item.idProduct > 0
    }
    
    private func stickerBackgroundColor(for item: Item, color: UIColor) -> UIColor {
        hasCollectedSticker(item) ? color : AppTheme.Colors.backgroundDisabled
    }
    
    private func stickerTextColor(for item: Item) -> UIColor {
        hasCollectedSticker(item) ? .white : AppTheme.Colors.textOnSurfaceSecondary
    }
    
    private func stickerCountColor(for item: Item) -> UIColor {
        item.collected > 1 ? .white : AppTheme.Colors.textOnSurfaceDisabled
    }
    
    private func cameraTintColor(for item: Item) -> UIColor {
        canOpenCamera(for: item) || canOpenProduct(for: item) ? AppTheme.Colors.textOnSurface : AppTheme.Colors.textOnSurfaceDisabled
    }
    
    private func setupActionButton(_ button: UIButton, for item: Item) {
        let icon: AppTheme.Icon
        let action: ButtonAction?
        
        if canOpenProduct(for: item) {
            icon = .check
            action = .openProduct(productId: item.idProduct)
        } else {
            icon = .camera
            action = canOpenCamera(for: item) ? .openCamera(stickerId: item.id) : nil
        }
        
        button.setImage(AppTheme.icon(icon).withRenderingMode(.alwaysTemplate), for: .normal)
        button.isUserInteractionEnabled = action != nil
        button.tintColor = cameraTintColor(for: item)
        button.tag = item.id
        
        if let action {
            buttonActions[ObjectIdentifier(button)] = action
        } else {
            buttonActions.removeValue(forKey: ObjectIdentifier(button))
        }
    }
    
    
    // Open camera
    @IBAction func openCamera(sender: UIButton) {
        emitOpenCameraHaptic()
        
        switch buttonActions[ObjectIdentifier(sender)] {
        case .openProduct(let productId):
            delegate?.stickerListCellOpenProduct(id: productId)
        case .openCamera(let stickerId):
            delegate?.stickerListCellOpenCamera(id: stickerId)
        case nil:
            break
        }
    }
    
    
    // Sticker gestures
    private func setupStickerGestureRecognizers() {
        setupStickerGestureRecognizers(for: viewCard1)
        setupStickerGestureRecognizers(for: viewCard2)
        setupStickerGestureRecognizers(for: viewCard3)
        setupStickerGestureRecognizers(for: viewCard4)
    }
    
    private func setupStickerGestureRecognizers(for view: UIView) {
        view.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSticker(_:)))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressSticker(_:)))
        longPressGesture.minimumPressDuration = 0.45
        tapGesture.delegate = self
        longPressGesture.delegate = self
        
        tapGesture.require(toFail: longPressGesture)
        
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(longPressGesture)
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchedView = touch.view else { return true }
        
        return touchedView.isDescendant(of: buttonCamera1) == false
            && touchedView.isDescendant(of: buttonCamera2) == false
            && touchedView.isDescendant(of: buttonCamera3) == false
            && touchedView.isDescendant(of: buttonCamera4) == false
    }
    
    @objc private func didTapSticker(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        emitAddCollectedHaptic(id: view.tag)
        collectedByStickerId[view.tag] = collected(for: view.tag) + 1
        animateStickerPush(view) {
            self.delegate?.stickerListCellDidTapSticker(id: view.tag)
        }
    }
    
    @objc private func didLongPressSticker(_ gesture: UILongPressGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        switch gesture.state {
        case .began:
            let collected = collected(for: view.tag)
            guard collected > 0 else {
                emitUnavailableRemoveHaptic()
                return
            }
            
            emitRemoveCollectedHaptic(collected: collected)
            collectedByStickerId[view.tag] = max(collected - 1, 0)
            animateStickerPush(view) {
                self.delegate?.stickerListCellDidLongPressSticker(id: view.tag)
            }
        case .ended, .cancelled, .failed:
            animateStickerReleased(view)
        default:
            break
        }
    }
    
    private func collected(for id: Int) -> Int {
        collectedByStickerId[id] ?? 0
    }
    
    private func emitAddCollectedHaptic(id: Int) {
        let collected = collected(for: id)
        
        switch collected {
        case 0:
            AppHaptics.success()
        case 1:
            AppHaptics.confirm()
        default:
            AppHaptics.tap()
        }
    }
    
    private func emitRemoveCollectedHaptic(collected: Int) {
        switch collected {
        case 1:
            AppHaptics.warning()
        case 2:
            AppHaptics.confirm()
        default:
            AppHaptics.tap()
        }
    }
    
    private func emitUnavailableRemoveHaptic() {
        AppHaptics.warning()
    }
    
    private func emitOpenCameraHaptic() {
        AppHaptics.selection()
    }
    
    private func animateStickerPush(_ view: UIView, completion: (() -> Void)? = nil) {
        view.layer.removeAllAnimations()
        
        UIView.animate(withDuration: 0.12, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState, .allowUserInteraction], animations: {
            view.transform = CGAffineTransformMakeScale(0.96, 0.96)
            view.alpha = 0.9
        }) { _ in
            completion?()
            
            UIView.animate(withDuration: 0.22, delay: 0.0, usingSpringWithDamping: 0.58, initialSpringVelocity: 0.7, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
                view.transform = .identity
                view.alpha = 1.0
            })
        }
    }
    
    private func animateStickerReleased(_ view: UIView) {
        UIView.animate(withDuration: 0.12, delay: 0.0, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
            view.transform = .identity
            view.alpha = 1.0
        })
    }
    
    private func resetStickerCardState(_ view: UIView) {
        view.layer.removeAllAnimations()
        view.transform = .identity
        view.alpha = 1.0
    }
    

    
}
