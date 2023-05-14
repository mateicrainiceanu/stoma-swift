//
//  SignUpVC.swift
//  Stoma
//
//  Created by Matei Crăiniceanu on 11.05.2023.
//

import UIKit
import SwiftyJSON

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let networkManager = NetworkManager()
    let userManager = UserManager()
    var newUserName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        spinner.isHidden = false
        
        let urlString = apiproxy + "/register"
        
        let json: [String: Any] = [
            "name": nameTextField.text!,
            "email": emailTextField.text!,
            "password": passwordTextField.text!
        ]
        
        networkManager.makePostRequest(urlString: urlString, parameters: json) { result in
            
            switch result {
            case .success(let data):
                    do {
                        let json = try JSON(data: data)

                        if let name = json["name"].string, let email = json["email"].string, let token = json["token"].string {
                            self.newUserName = name
                            self.userManager.setUser(User(name:name, email: email, token: token))
                        }
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "goToDash", sender: nil)
                        }
                        
                    } catch let error {
                        print("Error: \(error.localizedDescription)")
                        self.alertUser(title: "Error", body: error.localizedDescription)
                    }
            case .failure(let error):
                print(error.localizedDescription)
                self.alertUser(title: "Error", body: error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDash" {
            if let destinationVC = segue.destination as? DashVC {
                destinationVC.userName = newUserName
                destinationVC.modalPresentationStyle = .overFullScreen
            }
        }
        
    }
    
    func alertUser(title: String, body: String) {
        // Create new Alert
        let dialogMessage = UIAlertController(title: title, message: body, preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
         
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)

         // Present Alert to
        DispatchQueue.main.async { [self] in
            spinner.isHidden = true
            present(dialogMessage, animated: true, completion: nil)
        }
    }
    
}

extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.endEditing(false)
    }
    

}
