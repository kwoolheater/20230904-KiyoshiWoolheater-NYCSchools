//
//  DirectoryModel.swift
//  20230904-KiyoshiWoolheater-NYCSchools
//
//  Created by Woolheater, Kiyoshi on 9/4/23.
//

import Foundation

struct DirectoryModel: Codable {
    var dbn: String
    var schoolName: String
    var numOfSatTestTakers: String
    var satCriticalReadingAvgScore: String
    var satMathAvgScore: String
    var satWritingAvgScore: String
}
