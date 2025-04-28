//
//  ViewController.swift
//  nearabl.swift.exercise
//
//  Created by Jin Chen on 12/17/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please fill in both fields.")
            return
        }
        let validEmails = ["intern@nearabl.com", "hello@nearabl.com"]
        let validPassword = "2025"
        
        if validEmails.contains(email) && password == validPassword {
            performSegue(withIdentifier: "goToWelcome", sender: self)
        } else {
            showAlert(message: "Invalid credentials.")
        }
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWelcome" {
            let destinationVC = segue.destination as! WelcomeViewController
            destinationVC.userEmail = emailTextField.text
        }
    }
}

