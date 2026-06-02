import UIKit

extension MainBaseViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let row = rows[indexPath.row]
        let cell: UITableViewCell
        
        switch row {
        case .loading(let model):
            let c = tableView.dequeue(LoadingCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case .empty(let model):
            let c = tableView.dequeue(EmptyCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case .inputText(let model):
            let c = tableView.dequeue(InputTextCell.self, for: indexPath)
            c.setup(model: model, tag: indexPath.row)
            cell = c
        case .inputTextView(let model):
            let c = tableView.dequeue(InputTextViewCell.self, for: indexPath)
            c.setup(model: model, tag: indexPath.row)
            cell = c
        case .inputSelect(let model):
            let c = tableView.dequeue(InputSelectCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case .inputSlider(let model):
            let c = tableView.dequeue(InputSliderCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case .inputToken(let model):
            let c = tableView.dequeue(InputTokenCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case .textHeadingLg(let model):
            let c = tableView.dequeue(TextHeadingLgCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case .textHeadingMd(let model):
            let c = tableView.dequeue(TextHeadingMdCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case .textBody(let model):
            let c = tableView.dequeue(TextBodyCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case .textBodySmall(let model):
            let c = tableView.dequeue(TextBodySmallCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case .textCaption(let model):
            let c = tableView.dequeue(TextCaptionCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case .textCaptionSemibold(let model):
            let c = tableView.dequeue(TextCaptionSemiboldCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case .tag(let model):
            let c = tableView.dequeue(TagCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
            
        case .spacing(let model):
            let c = tableView.dequeue(SpacingCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case .default(let model):
            let c = tableView.dequeue(DefaultCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case .switch(let model):
            let c = tableView.dequeue(SwitchCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case .adBanner(let model):
            let c = tableView.dequeue(AdBannerCell.self, for: indexPath)
            c.setup(model: model, viewController: self)
            cell = c
            
        case.ctaCreativeUrl(let model):
            let c = tableView.dequeue(CtaCreativeUrlCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case.ctaLottieFileCell(let model):
            let c = tableView.dequeue(CtaLottieFileCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case.product(let model):
            let c = tableView.dequeue(ProductCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case.productProgress(let model):
            let c = tableView.dequeue(ProductProgressCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case.productCategory(let model):
            let c = tableView.dequeue(ProductCategoryCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case.myProduct(let model):
            let c = tableView.dequeue(MyProductCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        case.chatList(let model):
            let c = tableView.dequeue(ChatListCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case.chatMessageApp(let model):
            let c = tableView.dequeue(ChatMessageAppCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case.chatMessageMe(let model):
            let c = tableView.dequeue(ChatMessageMeCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case.chatMessageHe(let model):
            let c = tableView.dequeue(ChatMessageHeCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        // Profile
        case.profileUser(let model):
            let c = tableView.dequeue(ProfileUserCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        // Stikcers
        case.stickerList(let model):
            let c = tableView.dequeue(StickerListCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
        case.stickerCategoryList(let model):
            let c = tableView.dequeue(StickerCategoryListCell.self, for: indexPath)
            c.setup(model: model)
            cell = c
            
        }
        configureCell(cell, for: row, at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? UITableViewCellBase)?.didHighlight()
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? UITableViewCellBase)?.didUnhighlight()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        let row = rows[indexPath.row]
        switch row {
        case .loading(let model):
            return model.height ?? (tableView.bounds.height - tableView.safeAreaInsets.bottom - tableView.safeAreaInsets.top)
        case .empty(let model):
            return model.height ?? (tableView.bounds.height - tableView.safeAreaInsets.bottom - tableView.safeAreaInsets.top)
        default:
            return UITableView.automaticDimension
        }
    
    }

    func tableView(reloadAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
            self.tableView?.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if shouldDelaySelectionEvents() {
            DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
                self.didSelect(row: self.rows[indexPath.row], at: indexPath)
            }
        }
        else {
            self.didSelect(row: self.rows[indexPath.row], at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard indexPath.row < rows.count else { return }
        if shouldDelaySelectionEvents() {
            DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
                self.didDeselect(row: self.rows[indexPath.row], at: indexPath)
            }
        }
        else {
            self.didDeselect(row: self.rows[indexPath.row], at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return canEdit(row: rows[indexPath.row], at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return editingStyle(row: rows[indexPath.row], at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return trailingSwipeActions(for: rows[indexPath.row], at: indexPath)
    }
    
}
