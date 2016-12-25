//
//  AddGolfViewController.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 19/12/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit
import CoreData

class AddGolfViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var golferImageView: UIImageView!
    @IBOutlet weak var golferNameTextField: UITextField!
    @IBOutlet weak var golferHandicapTextField: UITextField!
    @IBOutlet weak var golferMembershipNoTextField: UITextField!
    
    
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()

    // MARK: - Actions
    @IBAction func cancelBtnPressed(_ sender: UIBarButtonItem) {
       _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func saveGolfer(_ sender: Any) {
        print("saveGolfer!")
        
        let entity = NSEntityDescription.entity(forEntityName: Constants.Entity.golferEntityString, in: self.context)
        let golfer = Golfer(entity: entity!, insertInto: self.context)
        
        golfer.name = golferNameTextField.text
        
        
        golfer.membershipNumber = "123456"
        golfer.clubHandicap = NSDecimalNumber(string: golferHandicapTextField?.text)
        golfer.playingHandicap = golfer.clubHandicap?.rounding(accordingToBehavior: nil)
        //            golfer.playsInA = Tournee.tourneeContainingGolfer(golfer)
        
        
        
        if let fullName = golfer.name?.components(separatedBy: " ") {
            
            golfer.firstName = fullName.first!
            golfer.surname = fullName.last!
            
        }
        
        
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Error saving golfer \(error.localizedDescription)")
        }
        
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
