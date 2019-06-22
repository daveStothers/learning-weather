//
//  ViewController.swift
//  techTest
//

import UIKit

class ViewController: UIViewController
{
    //Generate global variables the UI relies on
    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityIdentifier = "mainView" //used by tests
    }
}
