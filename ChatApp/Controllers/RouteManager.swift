
import UIKit

class RouteManager: NSObject {
    
    static var shared = RouteManager()
    
    private override init() {}
    
    var delegate:AppDelegate?{
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    var window:UIWindow?? {
        return UIApplication.shared.delegate?.window
    }
   
    func showHome(){
        let initial:InitialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "initial") as! InitialViewController
        window??.rootViewController = initial
    }
    
    func showLogin(){
        clear(window: window)
        let navvc:InitialLoginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! InitialLoginViewController
        window??.rootViewController = navvc
        
    }
    
    func clear(window: UIWindow??) {
        window??.subviews.forEach { $0.removeFromSuperview() }
    }
    
}
