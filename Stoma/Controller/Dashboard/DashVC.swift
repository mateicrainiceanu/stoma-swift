//
//  DashVC.swift
//  Stoma
//
//  Created by Matei Crăiniceanu on 14.05.2023.
//

import UIKit

class DashVC: UIViewController {
    
    var userName: String = ""
    let userManager = UserManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(userManager.getCurrentUser() as Any)
        print(userName)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
