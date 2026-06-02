import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Intro", bundle: nil)
        let rootVC = storyboard.instantiateInitialViewController()

        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }

    func setRootViewController(_ viewController: UIViewController) {
        guard let window = self.window else { return }

        UIView.transition(with: window,
                          duration: 0,
                          options: .transitionCrossDissolve,
                          animations: {
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }, completion: nil)
    }
    
    
}
