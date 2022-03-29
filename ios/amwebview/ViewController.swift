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
                if let topic = json["topic"] as? String {
                    webView.isHidden = true
                    
                    if !isLoggedIn && topic == "onLogin" {
                        btnLogin.isHidden = true
                        btnCreateAccount.isHidden = false
                        btnReaccept.isHidden = false
                        isLoggedIn = true
                    }
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }

    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnReaccept: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        webView.isHidden = true
        btnCreateAccount.isHidden = true
        btnReaccept.isHidden = true
        btnLogin.isHidden = false
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

        btnCreateAccount.addTarget(self, action: #selector(pressedManageAccount), for: .touchUpInside)

        btnLogin.addTarget(self, action: #selector(pressedLogin), for: .touchUpInside)
        
        btnReaccept.addTarget(self, action: #selector(pressedReacceptTerms), for: .touchUpInside)
        
    }
    
    @objc func pressedManageAccount() {

        let path = "http://192.168.0.129:8080/" + "manageaccount" + "?osType=ios&deviceId=1bebd0-9212-hewh2&country=US"
    
        let myURL = URL(string:path)
        let myRequest = URLRequest(url: myURL!)
    
        webView.load(myRequest);
        
        webView.isHidden = false
    }
    
    @objc func pressedLogin() {

        let path = "http://192.168.0.129:3000/" + "login"
    
        let myURL = URL(string:path)
        let myRequest = URLRequest(url: myURL!)
    
        webView.load(myRequest);
        
        webView.isHidden = false
    }
    
    @objc func pressedReacceptTerms() {

        let path = "http://192.168.0.129:8080/" + "verifyemailchange" + "?token=1234"

    
        let myURL = URL(string:path)
        let myRequest = URLRequest(url: myURL!)
    
        webView.load(myRequest);
        
        webView.isHidden = false
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
