//
//  SignUpVC.swift
//  Stoma
//
//  Created by Matei Crăiniceanu on 11.05.2023.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        spinner.isHidden = false
        print(nameTextField.text!, " | ", emailTextField.text!, " | ", passwordTextField.text!)
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
