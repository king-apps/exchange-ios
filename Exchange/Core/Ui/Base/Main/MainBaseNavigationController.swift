import UIKit
import Foundation

class MainBaseNavigationController: UINavigationController {
   
    
    // Var's
    override var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return visibleViewController?.preferredStatusBarStyle ?? .lightContent
    }
    override var prefersStatusBarHidden: Bool {
        return visibleViewController?.prefersStatusBarHidden ?? false
    }
    
    
    // Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarAppearance()
    }
  
    
    // Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    
    // Setup navigation
    private func setupNavigationBarAppearance() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppTheme.Colors.brandPrimary500
        appearance.shadowColor = .clear
        
        appearance.titleTextAttributes = [
            .foregroundColor: AppTheme.Colors.textOnBrandPrimary,
            .font: UIFont.systemFont(ofSize: AppTheme.FontSize.body, weight: .semibold)
        ]
        
        // Título grande (se usar large titles em alguma tela)
        appearance.largeTitleTextAttributes = [
            .foregroundColor: AppTheme.Colors.textOnBrandPrimary,
            .font: UIFont.systemFont(ofSize: AppTheme.FontSize.headingXl, weight: .bold)
        ]
        
        // Aplica a MESMA aparência pra todos os estados
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        
        // Cor dos botões (back, etc.)
        navigationBar.tintColor = AppTheme.Colors.iconOnBrandPrimary
        
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.backButtonTitle = ""
      
    }
    

}
