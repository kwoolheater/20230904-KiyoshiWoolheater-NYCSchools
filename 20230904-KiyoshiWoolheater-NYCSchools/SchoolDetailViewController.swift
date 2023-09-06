//
//  SchoolDetailViewController.swift
//  20230904-KiyoshiWoolheater-NYCSchools
//
//  Created by Woolheater, Kiyoshi on 9/5/23.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    
    var school: DirectoryModel?
    
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var numOfSatTakers: UILabel! 
    @IBOutlet weak var satCriticalReadingAvgScore: UILabel!
    @IBOutlet weak var satMathAvgScore: UILabel!
    @IBOutlet weak var satWritingAvgScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "School Details"
        
        if let name = school?.schoolName {
            schoolName.isHidden = false
            schoolName.text = name.normalizeCapitalization()
        } else {
            schoolName.isHidden = true
        }
        updateLabel(numOfSatTakers, withInt: school?.numOfSatTestTakers, andString: "Number of SAT Takers:", using: { Int($0) })
        updateLabel(satCriticalReadingAvgScore, withInt: school?.satCriticalReadingAvgScore, andString: "Average Reading Score:", using: { Int($0) })
        updateLabel(satMathAvgScore, withInt: school?.satMathAvgScore, andString: "Average Math Score:", using: { Int($0) })
        updateLabel(satWritingAvgScore, withInt: school?.satWritingAvgScore, andString: "Average Writing Score:", using: { Int($0) })
    }
    
    func updateLabel(_ label: UILabel, withInt value: String?, andString text: String, using conversionFunction: (String) -> Int?) {
        if let stringValue = value, let intValue = conversionFunction(stringValue) {
            label.isHidden = false
            label.text = "\(text) \(intValue)"
        } else {
            label.isHidden = true
        }
    }
}

extension String {
    func normalizeCapitalization() -> String {
        let words = self.components(separatedBy: " ")
        var result = ""
        
        for word in words {
            if !word.isEmpty {
                let firstLetter = word[word.startIndex]
                let restOfWord = word[word.index(after: word.startIndex)...]
                result += "\(firstLetter.uppercased())\(restOfWord.lowercased()) "
            }
        }
        
        // Remove the trailing space if it exists
        if result.last == " " {
            result.removeLast()
        }
        
        return result
    }
}
