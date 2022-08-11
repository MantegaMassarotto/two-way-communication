import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKScriptMessageHandler {
    
    var route: String = "login"
    var isLoggedIn: Bool = false

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? String else {
            return
        }
        
        let data = Data(dict.utf8)

        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // try to read out a string array
                if let data = json["data"] as? String {
                    webView.isHidden = true
                    btnLogin.isHidden = true
                    btnLogout.isHidden = false
                    
                    textToken.text = data;
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var textToken: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        webView.isHidden = true
        btnLogin.isHidden = false
        btnLogout.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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


        btnLogin.addTarget(self, action: #selector(pressedLogin), for: .touchUpInside)
        btnLogout.addTarget(self, action: #selector(pressedLogout), for: .touchUpInside)
    }
    
    @objc func pressedLogin() {

        let url = "http://192.168.0.129:3000/" + "login" + "?osType=ios"
    
        let myURL = URL(string:url)
        let myRequest = URLRequest(url: myURL!)
    
        webView.load(myRequest);
        
        webView.isHidden = false
    }
    
    @objc func pressedLogout() {
        textToken.isHidden = true
        btnLogin.isHidden = false
        btnLogout.isHidden = true
    }
    
    private lazy var webView: WKWebView = {
        // Use a single process pool for all web views
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.processPool = YourModelObject.sharedInstance.processPool

        webView = WKWebView(frame: .zero,
                        configuration: webConfiguration)

        webView.translatesAutoresizingMaskIntoConstraints = false

        return webView
    }()
}
