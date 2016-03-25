//
//  ViewController.swift
//  MusketeerPlayground
//
//  Created by Oliver Morland on 19/03/2016.
//  Copyright © 2016 Ginger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UIPickerViewDelegate {
    
    
    //Variables
    var SubmitView = UIView()
    let PickerLabel = UILabel()
    let PickerImageView = UIImageView()
    var CircleButton : UIButton = UIButton()
    var SubmitButton : UIButton = UIButton()
    var PickerView = UIPickerView()
    var SelectedItem = String()
    var LostNames = ["Oliver", "Sam", "Nikhil", "Jacob"]
    var LostItemsArray = ["Bag", "Blazer", "Book", "Boots", "Calculator", "Card", "Computer", "Charger", "Ear Phones","Folder", "Glasses", "Gloves", "Hat","Jacket","Keys", "Memory Stick", "Pen", "Pencil Case", "Phone", "Scarf", "Shoe", "Shorts", "Sport Shirt", "Tie", "Trainers", "Trousers","Umbrella","Wallet", "Watch", "Water Bottle"]
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CreateSubmitView()
        
        //Swipe Gestures
        let RightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("GlideIn"))
        RightSwipe.direction = .Right
        view.addGestureRecognizer(RightSwipe)
        let LeftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("GlideBack"))
        LeftSwipe.direction = .Left
        view.addGestureRecognizer(LeftSwipe)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //----------------------SUBMIT VIEW FUNCTIONS-------------------------//
    
    //Create Submit View Setup
    func CreateSubmitView(){
        //The View
        let Height : CGFloat = 390
        let Width : CGFloat = 250
        SubmitView.frame.size = CGSize(width: Width, height: Height)
        SubmitView.center = CGPoint(x: -125, y: view.center.y)
        SubmitView.layer.backgroundColor = UIColor.whiteColor().CGColor
        SubmitView.alpha = 0.8
        SubmitView.layer.cornerRadius = 10
        view.addSubview(SubmitView)
        
        //Title
        PickerLabel.frame = CGRectMake(0, 5, Width, 30)
        PickerLabel.text = "What Have you lost?"
        PickerLabel.textColor = UIColor.blackColor()
        PickerLabel.textAlignment = NSTextAlignment.Center
        SubmitView.addSubview(PickerLabel)
        
        //ImageView
        PickerImageView.frame = CGRectMake((SubmitView.frame.width/2) - 45, 40, 90, 90)
        PickerImageView.image = UIImage(named: "LostSomething")
        SubmitView.addSubview(PickerImageView)
        
        //Picker View
        PickerView.frame = CGRectMake(0, 140, Width, 150)
        PickerView.delegate = self
        SubmitView.addSubview(PickerView)
        
        //Submit Button
        SubmitButton.frame = CGRectMake((SubmitView.frame.width/2)-(75), 300, 150, 60)
        SubmitButton.layer.backgroundColor = UIColor.blackColor().CGColor
        SubmitButton.setTitle("Submit", forState: .Normal)
        SubmitButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        SubmitButton.titleLabel?.font = UIFont(name: "Avenir Book", size: 30)
        SubmitButton.layer.cornerRadius = 10
        SubmitView.addSubview(SubmitButton)
        
        //Circle Button
        CircleButton.frame = CGRectMake(0, (view.frame.height/2)-30, 60, 60)
        CircleButton.setTitle("Hello", forState: .Normal)
        CircleButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        CircleButton.setImage(UIImage(named: "Circle"), forState: .Normal)
        CircleButton.addTarget(self, action: "CircleTapped:", forControlEvents: .TouchUpInside)
        view.addSubview(CircleButton)
    }
    
    //Circle Button tapped
    func CircleTapped(sender: UIButton!){
        if CircleButton.center.x == 30{
            GlideIn()
        }
        else{
            GlideBack()
        }
    }
    
    //Glide in
    func GlideIn(){
        UIView.animateWithDuration(0.5) { () -> Void in
            self.CircleButton.transform = CGAffineTransformMakeRotation(360)
            self.SubmitView.center.x = self.view.center.x
            self.CircleButton.center.x = self.SubmitView.center.x + (self.SubmitView.frame.width/2 + 30)
        }
    }
    
    //Glide Back
    func GlideBack(){
        UIView.animateWithDuration(0.5) { () -> Void in
            self.CircleButton.transform = CGAffineTransformMakeRotation(0)
            self.SubmitView.center = CGPoint(x: -125, y: self.view.center.y)
            self.CircleButton.frame = CGRectMake(0, (self.view.frame.height/2)-30, 60, 60)
        }
    }
    
    //Glide Through
    func GlideThrough(){
        UIView.animateWithDuration(0.5) { () -> Void in
            self.SubmitView.center = CGPoint(x: self.view.frame.width + 125, y: self.view.center.y)
        }
        
    }

    //Picker View Functions
    func numberOfComponentsInPickerView(pickerView: UIPickerView!)->Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int{
        return LostItemsArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return LostItemsArray[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectedItem = LostItemsArray[row]
        PickerLabel.text = SelectedItem
        PickerImageView.image = UIImage(named: "\(SelectedItem)")
    }
    //End Picker View Functions
    
    //------------------END SUBMIT VIEW FUNCTIONS-----------------//

    
    //------------------TABLE VIEW FUNTIONS-----------------------//
    
    //Number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return LostNames.count
    }
    
    //Configure cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell
        cell.NameLabel.text = LostNames[indexPath.row]
        
        return cell
    }

    //---------------END TABLE VIEW FUNCTIONS----------------------//

}

