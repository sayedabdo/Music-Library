//
//  ViewController.swift
//  Music Library
//
//  Created by Sayed Abdo on 4/23/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class Login: UIViewController {
    
   
    @IBOutlet weak var emailtextfield: UITextField!

    @IBOutlet weak var passwordTextfield: UITextField!
    var checkifexist = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        //check if the email textfield is empty or not
        if(emailtextfield.text?.isEmpty)!{
            displayAlertMessage(title: "Error", messageToDisplay: "email is empty ًںک،ًںک،ًںک،", titleofaction: "Try Again")
            return
        }
        
        //check if the email textfield is valid or not
        let EmailAddress = emailtextfield.text
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: EmailAddress!)
        if isEmailAddressValid
        {} else {
            displayAlertMessage(title: "Error", messageToDisplay: "E-mail is InValid ًںک،ًںک،ًںک،", titleofaction: "Try Again")
            return
        }
        //check if the password textfield is empty or not
        if(passwordTextfield.text?.isEmpty)!{
            displayAlertMessage(title: "Error", messageToDisplay: "password is empty ًںک،ًںک،ًںک،", titleofaction: "Try Again")
            return
        }
        //check if the password textfield is longer than 8 characters
        if((passwordTextfield.text?.characters.count)! < 1 ){
            displayAlertMessage(title: "Error", messageToDisplay: "password must longer than 8 characters ًںک،ًںک،ًںک،", titleofaction: "Try Again")
            return
        }
        let user_get_url = "http://team-space.000webhostapp.com/index.php/api/user"
        
        Alamofire.request(user_get_url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                
                
                for aDic in arrayOfDic{
                    let e_mail = aDic["email"]!
                    let password = aDic["password"]!
                    if(self.emailtextfield.text!    == e_mail   as! String){
                        if(self.passwordTextfield.text! == password as! String){
                            //self.displayAlertMessage(title: "Done", messageToDisplay: "ًںکچًںکچًںکچًںکچ", titleofaction: "OK")
                            print("HHHHHH")
                            self.checkifexist = 1
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Categories") as! CategoriesVC
                            self.present(nextViewController, animated:true, completion:nil)
                            
                            return
                        }
                    }
                }
                if(self.checkifexist == 0){
                    self.displayAlertMessage(title: "Error", messageToDisplay: "Email or Password Not Right ًںک،ًںک", titleofaction: "Try Again")
                    return
                }
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        

    }
    
    
    
    
    
    
    
    //function used to check is email valid or not
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    //function to display alert
    func displayAlertMessage(title: String,messageToDisplay: String, titleofaction : String)
    {
        let alertController = UIAlertController(title: title, message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: titleofaction, style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
}

