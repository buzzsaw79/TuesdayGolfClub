//
//  AddGolfViewController.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 19/12/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit
import CoreData

class AddGolfViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var golferImageView: UIImageView!
    @IBOutlet weak var golferNameTextField: UITextField!
    @IBOutlet weak var golferHandicapTextField: UITextField!
    @IBOutlet weak var golferMembershipNoTextField: UITextField!
    
    //MARK: -
    //MARK: Properties
    
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()
    
    var imagePicker = UIImagePickerController()

    // MARK: - Actions
    @IBAction func cancelBtnPressed(_ sender: UIBarButtonItem) {
       _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func saveGolfer(_ sender: Any) {
        let entity = NSEntityDescription.entity(forEntityName: Constants.Entity.golferEntityString, in: self.context)
        let golfer = Golfer(entity: entity!, insertInto: self.context)
        
        golfer.name = golferNameTextField.text
        
        
        golfer.membershipNumber = golferMembershipNoTextField.text ?? "12345"
        golfer.clubHandicap = NSDecimalNumber(string: golferHandicapTextField?.text)
//        golfer.playingHandicap = golfer.clubHandicap?.rounding(accordingToBehavior: nil)
        //            golfer.playsInA = Tournee.tourneeContainingGolfer(golfer)
        
        golfer.image = UIImageJPEGRepresentation(golferImageView.image!, 1.0) as NSData?
        
        _ = Golfer.saveGolfer(golfer: golfer)
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addPicButton(_ sender: UIButton) {
        //DEBUG
        print("Add PIC PRESSED")
        
        //present(imagePicker!, animated: true, completion: nil)
//        
        imagePicker.allowsEditing = true
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        
        golferImageView.layer.cornerRadius = golferImageView.frame.width/2
        golferImageView.clipsToBounds = true
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: -
    //MARK: ImagePickerController Delegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.golferImageView.image = pickedImage
            //DEBUG
            print("PICKED AN EDITED IMAGE!!!")
        } else if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.golferImageView.image = pickedImage
            let imageJPG = UIImageJPEGRepresentation(pickedImage, 1.0)
            //DEBUG
            print("PICKED AN ORIGINAL IMAGE!!!")
            self.golferImageView.image = UIImage(data: imageJPG!)
        }
        
//        self.imageView.image = [UIImage imageWithData:self.myEvent.picture];
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
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
