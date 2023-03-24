//
//  SchoolDetailVC.swift
//  NYCSchools
//
//  Created by Bhagwan Rajput on 24/03/23.
//

import UIKit

class SchoolDetailVC: UIViewController {
    
    //Outlets and connections
    @IBOutlet var btnWebsite: UIButton!
    @IBOutlet var lblSchoolDescription: UILabel!
    @IBOutlet var lblReadingScore: UILabel!
    @IBOutlet var lblWritingScore: UILabel!
    @IBOutlet var lblMathScore: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblSchoolName: UILabel!
    @IBOutlet var headerVw: UIView!
    
    //Properties/var declearation
    var dbn: String = ""
    var selectedSchoolDict = [String: Any]()
    var schoolDetailArrOfDictionaries = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initUI()
        
        
    }
    
    //On Initial loading
    func initUI() {
        print("Selected dictionary is :: \(selectedSchoolDict)")
        if let schoolName = selectedSchoolDict["school_name"] as? String {
            // Use the value here
            lblSchoolName.text! = schoolName
        }
        if let schoolDetail = selectedSchoolDict["overview_paragraph"] as? String {
            // Use the value here
            lblSchoolDescription.text! = schoolDetail
        }
        if let schoolWebsiste = selectedSchoolDict["website"] as? String {
            // Use the value here
            btnWebsite.setTitle(schoolWebsiste, for: .normal)
        }
        if let dbnValue = selectedSchoolDict["dbn"] as? String {
            // Use the value here
            dbn = dbnValue
        }
        getAllSchoolDetails()
    }
    
    
    // MARK: - Navigate to previous back screen
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Open specific website
    @IBAction func btnOpenSiteAction(_ sender: Any) {
        let urlBase = (btnWebsite.titleLabel?.text! ?? "")
        
        guard let url = URL(string: "https://\(urlBase)") else {
            // Handle the case where the URL is invalid
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    //To get all school detail by calling this API
    func getAllSchoolDetails(){
        let url = URL(string: URLData.schoolDetailsURL)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                // Do something with the array
                self.schoolDetailArrOfDictionaries = jsonArray
                DispatchQueue.main.async {
                    if let index = self.schoolDetailArrOfDictionaries.firstIndex(where: { $0["dbn"] as? String == self.dbn }) {
                        print("Found at index: \(index)")
                        let dict = self.schoolDetailArrOfDictionaries[index]
                        if let mathScore = dict["sat_math_avg_score"] as? String {
                            self.lblMathScore.text! = mathScore
                        }
                        if let readingScore = dict["sat_critical_reading_avg_score"] as? String{
                            self.lblReadingScore.text! = readingScore
                        }
                        if let writingScore = dict["sat_writing_avg_score"] as? String{
                            self.lblWritingScore.text! = writingScore
                        }
                    } else {
                        print("Not found")
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
        
    }
}
