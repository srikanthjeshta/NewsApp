//
//  UIAlertContoller+Extensions.swift


import UIKit

extension UIAlertController {
    
    // Show Alert
    
    class func showAlert(vc:UIViewController,title:String,message:String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //alertController.view.tintColor = .lightBlue
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        vc.present(alertController, animated: true)
    }
    
    class func showAlertWithOkAction(_ vc:UIViewController,title:String,message:String,buttonTitle:String,buttonAction:@escaping ()-> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //alert.view.tintColor = .lightBlue
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: {(alert: UIAlertAction!) in
            buttonAction()
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func showToast(vc:UIViewController,title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.layer.cornerRadius = 15
        
        vc.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0) {
            
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    class func displayToast(vc:UIViewController,title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.layer.cornerRadius = 15
        
        vc.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0) {
            
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

