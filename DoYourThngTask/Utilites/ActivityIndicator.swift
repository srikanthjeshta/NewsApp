//
//  ActivityIndicator.swift

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {
    
    //MARK: -  Activity Indicator Show / Hide

    func showActivityIndicator() {
                
        DispatchQueue.main.async {
            
            SVProgressHUD.setDefaultMaskType(.black)
            //SVProgressHUD.setForegroundColor(.darkBlue)
            SVProgressHUD.show(withStatus: "Please Wait")
        }
    }
    
    func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            
            SVProgressHUD.dismiss()
        }
    }
    
    
    //MARK: -  Keyboard Show / Hide

    func showKeyBoard() {
        
        view .endEditing(false)
    }
    
    func hideKeyBoard() {
        
        view .endEditing(true)
    }
    
    
    //MARK: -  Empty Back Button Title

    open override func awakeFromNib() {
            
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}
