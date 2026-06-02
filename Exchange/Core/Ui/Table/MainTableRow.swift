import UIKit

enum MainTableRow {
    
    // Loading
    case loading(LoadingCell.Model)
    case empty(EmptyCell.Model)
    
    case inputText(InputTextCell.Model)
    case inputTextView(InputTextViewCell.Model)
    case inputToken(InputTokenCell.Model)
    case inputSelect(InputSelectCell.Model)
    case inputSlider(InputSliderCell.Model)

    case textHeadingLg(TextHeadingLgCell.Model)
    case textHeadingMd(TextHeadingMdCell.Model)
    case textBody(TextBodyCell.Model)
    case textBodySmall(TextBodySmallCell.Model)
    case textCaption(TextCaptionCell.Model)
    case textCaptionSemibold(TextCaptionSemiboldCell.Model)

    case spacing(SpacingCell.Model)
    case `default`(DefaultCell.Model)
    case `switch`(SwitchCell.Model)
    case tag(TagCell.Model)

    case adBanner(AdBannerCell.Model)
    
    // Premium
    case ctaCreativeUrl(CtaCreativeUrlCell.Model)
    case ctaLottieFileCell(CtaLottieFileCell.Model)
    
    // Product
    case product(ProductCell.Model)
    case productProgress(ProductProgressCell.Model)
    
    case productCategory(ProductCategoryCell.Model)
    case myProduct(MyProductCell.Model)
    
    // Chat
    case chatList(ChatListCell.Model)
    case chatMessageApp(ChatMessageAppCell.Model)
    case chatMessageMe(ChatMessageMeCell.Model)
    case chatMessageHe(ChatMessageHeCell.Model)
    
    // Profile
    case profileUser(ProfileUserCell.Model)
    
    // Stickers
    case stickerList(StickerListCell.Model)
    case stickerCategoryList(StickerCategoryListCell.Model)
    
    
}
