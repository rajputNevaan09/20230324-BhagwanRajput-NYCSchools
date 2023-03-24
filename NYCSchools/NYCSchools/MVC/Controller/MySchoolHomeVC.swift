//
//  MySchoolHomeVC.swift
//  NYCSchools
//
//  Created by Bhagwan Rajput on 24/03/23.
//

import UIKit

class MySchoolHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets and connections
    @IBOutlet var btnSideMenu: UIButton!
    @IBOutlet var VwMain: UIView!
    @IBOutlet var tblSchoolList: UITableView!
    
    //Properties declearation
    var schoolArrayOfDictionaries = [[String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tblSchoolList.separatorColor = UIColor.clear
        self.getAllSchoolList()
        
        
    }
    
    
    //Table View Delegate and Datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolArrayOfDictionaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellSchool: SchoolListCell = tblSchoolList.dequeueReusableCell(withIdentifier: "schoolListCell") as! SchoolListCell
        let dict = schoolArrayOfDictionaries[indexPath.row] as NSDictionary
        if let schoolName = dict.value(forKey: "school_name") as? String {
            cellSchool.lblSchoolName.text! = schoolName
        }
        if let schoolDiscription = dict.value(forKey: "academicopportunities1") as? String {
            cellSchool.lblSchoolDescription.text! = schoolDiscription
        }
        
        if let schoolEmail = dict.value(forKey: "school_email") as? String {
            cellSchool.lblEmail.text! = schoolEmail
        }
        if let schoolLocation = dict.value(forKey: "location") as? String {
            cellSchool.lblLocation.text! = schoolLocation
        }
        if let schoolwebsite = dict.value(forKey: "website") as? String {
            cellSchool.lblWebsite.text! = schoolwebsite
        }
        
        return cellSchool
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    //API Call to fetch all school list from URL
    func getAllSchoolList(){
        self.view.isUserInteractionEnabled = false
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        
        present(alert, animated: true, completion: nil)
        let url = URL(string: URLData.schoolListURL)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                // Do something with the array
                self.schoolArrayOfDictionaries = jsonArray
                
                DispatchQueue.main.async {
                    self.tblSchoolList.reloadData()
                    self.dismiss(animated: true, completion: nil)
                    self.view.isUserInteractionEnabled = true
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User clicked on \(indexPath.row)")
        let dict = schoolArrayOfDictionaries[indexPath.row] as NSDictionary
        goToPetDetailController(dict: dict)
    }
    
    // MARK: - Navigation to School detail view controller
    func goToPetDetailController(dict:NSDictionary) {
        print("Navigate to next screen")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let schoolDetailVC = storyboard.instantiateViewController(withIdentifier: "schoolDetailVC") as? SchoolDetailVC
        schoolDetailVC?.selectedSchoolDict = dict as? [String:Any] ?? [:]
        self.navigationController?.pushViewController(schoolDetailVC!, animated: true)
    }
    
    //SideMenu clicked
    @IBAction func btnSideMenuAction(_ sender: Any) {
        showAlert()
    }
    
    //Show Alert 
    func showAlert () {
        let alert = UIAlertController(title: "NYC School Alert", message: "Coming Soon", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
}
