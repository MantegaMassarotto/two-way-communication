import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKScriptMessageHandler, WKNavigationDelegate {
    
    var route: String = "login"

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard let dict = message.body as? String else {
            return
        }
                
//        let path = "http://192.168.0.129:8080/" + "manageaccount" + "?osType=ios&deviceId=1bebd0-9212-hewh2&country=US"
//
//        let myURL = URL(string:path)
//        let myRequest = URLRequest(url: myURL!)
//
//        webView.load(myRequest);
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let mainManagerViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! ViewController
//        mainManagerViewController.modalPresentationStyle = .fullScreen
//        mainManagerViewController.modalTransitionStyle = .crossDissolve
//
//        if message.name == "sendMessage" {
//            mainManagerViewController.isLoggedIn = true
//        }
//
//        self.present(mainManagerViewController, animated: true, completion: nil)
            
        print(dict)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        processPool = WKProcessPool()
        
//        if (globalWebView == nil) {
//            globalWebView = WKWebView()
//            globalWebView?.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(webView)

            NSLayoutConstraint.activate([
                webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                webView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
                webView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
            ])
            
            let contentController = webView.configuration.userContentController
            contentController.add(self, name: "sendMessage")
            contentController.add(self, name: "onBack")
//        }
                
        let path = "http://192.168.0.129:8080/" + route + "?osType=ios&deviceId=1bebd0-9212-hewh2&country=US"
        
        let myURL = URL(string:path)
        let myRequest = URLRequest(url: myURL!)
        
        webView.load(myRequest);
        
    }
    
    private lazy var webView: WKWebView = {
        // Use a single process pool for all web views
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.processPool = YourModelObject.sharedInstance.processPool

        webView = WKWebView(frame: .zero,
                        configuration: webConfiguration)

        webView.translatesAutoresizingMaskIntoConstraints = false

        webView.navigationDelegate = self




        return webView
    }()
}


//extension WKWebViewConfiguration {
//    static var shared : WKWebViewConfiguration {
//        if _sharedConfiguration == nil {
//            _sharedConfiguration = WKWebViewConfiguration()
//            _sharedConfiguration.websiteDataStore = WKWebsiteDataStore.default()
//            _sharedConfiguration.userContentController = WKUserContentController()
//            _sharedConfiguration.preferences.javaScriptEnabled = true
//            _sharedConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = false
//        }
//        return _sharedConfiguration
//    }
//    private static var _sharedConfiguration : WKWebViewConfiguration!
//}


//extension WKWebView {
//    static var shared : WKWebView {
//        if _webView == nil {
//            _webView = WKWebView()
//        }
//        return _webView
//    }
//    private static var _webView : WKWebView!
//}
