//
//  ApplicationViewController.swift
//  Applicationifier
//
//  Created by Jason Casillas on 4/16/16.
//  Copyright © 2016 TWNH. All rights reserved.
//

import UIKit
import Alamofire

class ApplicationViewController: UIViewController {
    @IBOutlet weak var applicationScrollView: UIScrollView!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var urlsTextView: UITextView!

    var teamSelectionTableViewController:TeamSelectionTableViewController!

    @IBOutlet weak var submitButton: UIButton!

    let urlToSendTheApplicationTo = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "embedTeamSelectionTableViewControllerSegue") {
            teamSelectionTableViewController = segue.destinationViewController as! TeamSelectionTableViewController
        }
    }


    // MARK: - Gesture Recognizers
    @IBAction func tappedSubmitButton(sender: AnyObject) {
        if applicationIsValid() {
            submitApplication()
        }
    }


    // MARK: - Validations
    func applicationIsValid() -> Bool {
        return viewHasTextContent(nameTextField, alertTitleString: "They'd like to know your name") &&
               viewHasTextContent(emailTextField, alertTitleString: "They need your email address too") &&
               viewHasTextContent(aboutTextView, alertTitleString: "Write about why you're great to work with") &&
               viewHasTextContent(urlsTextView, alertTitleString: "Show them what you've built in URL form") &&
               teamsHaveBeenSelected()
    }

    func viewHasTextContent(textInput:AnyObject, alertTitleString:String!) -> Bool {
        if (textInput is UITextField || textInput is UITextView) && !textInput.text!.isEmpty {
            return true
        } else {
            displayValidationAlertWithTitle(alertTitleString, alertMessageString: nil)

            return false
        }
    }

    func teamsHaveBeenSelected() -> Bool {
        let selectedTeamsArray = teamSelectionTableViewController.selectedTeamsArray()
        if selectedTeamsArray.count > 0 {
            return true
        } else {
            displayValidationAlertWithTitle("Missing Teams", alertMessageString: "Please select the team(s) you want to be a part of.")

            return false
        }
    }

    func displayValidationAlertWithTitle(alertTitleString:String!, alertMessageString:String?) {
        let validationAlertController = UIAlertController(title: alertTitleString, message: alertMessageString, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
        validationAlertController.addAction(cancelAction)

        if let popoverController = validationAlertController.popoverPresentationController {
            popoverController.sourceView = applicationScrollView
            popoverController.sourceRect = CGRectMake(submitButton.frame.origin.x, submitButton.frame.origin.y,
                                                      submitButton.bounds.size.width, submitButton.bounds.size.height)
        }

        presentViewController(validationAlertController, animated:true, completion:nil)
    }


    // MARK: - Data conversion
    func urlsArray() -> [String] {
        return urlsTextView.text!.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()).filter{!$0.isEmpty}
    }


    // MARK: - External Calls
    func submitApplication() {
        let applicationParameters:[String:AnyObject] = ["name": nameTextField.text!,
                                                        "email": emailTextField.text!,
                                                        "about": aboutTextView.text!,
                                                        "urls": urlsArray(),
                                                        "teams": teamSelectionTableViewController.selectedTeamsArray()]

        Alamofire.request(.POST, urlToSendTheApplicationTo, parameters: applicationParameters, encoding: .JSON)
    }
}

