//  main.swift
//  grade
//
//  Created by StudentAM on 1/29/24.

import Foundation
import CSV
struct Student{
    var name: String
    var grade: [Double]
}
// Arrays to store data
var grades: [Student] = [] // Stores grades of all students for all assignments
var names: [String] = [] // Stores names of all students
var namesLower: [String] = [] // Stores lowercase names for case-insensitive search
var avg: [Double] = [] // Stores average grade for each student
var opt: Int = 0 // Stores user's menu choice

// Reading CSV file
do {
    let stream = InputStream(fileAtPath: "/Users/studentam/Desktop/Apps/grade/grade/grade/grades.csv")
    let csv = try CSVReader(stream: stream!)
    while let row = csv.next() {
        // Adding student name to arrays
        names.append(row[0])
        namesLower.append(row[0].lowercased())
        // Calculating grades and average
        var grade: [Double] = []
        var sum = 0.0
        for i in 1..<row.count {
            grade.append(Double(row[i])!)
            sum += grade[i - 1]
        }
        avg.append(sum/Double(grade.count))
        let student = Student(name: row[0], grade: grade)
        grades.append(student)
    }
} catch {
    print("There was an error trying to read the file!")
}

// Main menu loop
while opt != -1 {
    // Displaying menu options
    print("\nWelcome to the Grade Manager!\nWhat would you like to do? (Enter the number):")
    print("1. Display grade of a single student\n2. Display all grades for a student\n3. Display all grades of ALL students\n4. Find the average grade of the class\n5. Find the average grade of an assignment\n6. Find the lowest grade in the class\n7. Find the highest grade of the class\n8. Filter students by grade range\n9. Change a student's grade\n10. Quit")
    
    // Reading user input
    opt = Int(readLine()!)!
    
    // Switch case based on user's choice
    switch opt {
        case 1:
            displaySingle()
        case 2:
            displayStudent()
        case 3:
            displayAll()
        case 4:
            classAverage()
        case 5:
            assignAverage()
        case 6:
            lowest()
        case 7:
            highest()
        case 8:
            filterByGrade()
        case 9:
            change()
        case 10:
            print("Have a great rest of your day!")
            opt = -1
            break
        default:
            print("Please choose an appropriate option!")
    }
}

// Function to display grade of a single student
func displaySingle() {
    // Prompting user to input the name of the student
    print("Which student would you like to choose?")
    let name = readLine()!
    // Finding the index of the student in the lowercase names array
    let ind = namesLower.firstIndex(of: name.lowercased())
    // Checking if the student exists
    if ind != nil {
        // Printing the grade of the student
        print("\(names[ind!])'s grade in the class is \(avg[ind!])")
    } else {
        // If the student name is not valid, prompting the user to enter a valid name
        print("Please enter a valid name!")
        displaySingle()
    }
}

// Function to display all grades for a student
func displayStudent() {
    // Prompting user to input the name of the student
    print("Which student would you like to choose?")
    let name = readLine()!
    // Finding the index of the student in the lowercase names array
    let ind = namesLower.firstIndex(of: name.lowercased())
    // Checking if the student exists
    if ind != nil {
        // Printing all grades of the student
        print("\(names[ind!])'s grades for this class are:")
        for i in 0..<grades[ind!].grade.count - 1 {
            print("\(grades[ind!].grade[i]), ", terminator: "")
        }
        print(grades[ind!].grade[(grades[ind!].grade.count) - 1])
    } else {
        // If the student name is not valid, prompting the user to enter a valid name
        print("Please enter a valid name!")
        displayStudent()
    }
}

// Function to display all grades of all students
func displayAll() {
    for ind in 0..<names.count {
        // Printing all grades of each student
        print("\(names[ind])'s grades are: ", terminator: "")
        for i in 0..<grades[ind].grade.count - 1 {
            print("\(grades[ind].grade[i]), ", terminator: "")
        }
        print(grades[ind].grade[(grades[ind].grade.count) - 1])
    }
}

// Function to calculate class average
func classAverage() {
    var sum = 0.0
    for num in avg {
        sum += num
    }
    // Calculating the average grade of the class
    let average = sum / Double(avg.count)
    print("The class average is: \(round(average * 100) / 100)")
}

// Function to find average grade of an assignment
func assignAverage() {
    // Prompting user to input the assignment number
    print("Which assignment would you like to get the average of (1-10):")
    let ind = Int(readLine()!)!
    // Checking if the assignment number is valid
    if ind < avg.count && ind > 0 {
        // Calculating the average grade of the assignment
        var sum = 0.0
        for i in 0..<grades.count {
            sum += grades[i].grade[ind - 1]
        }
        let average = sum / Double(grades.count)
        print("The average for assignment #\(ind) is \(round(average * 100) / 100)")
    } else {
        // If the assignment number is not valid, prompting the user to enter a valid assignment
        print("Please enter a valid assignment!")
        assignAverage()
    }
}

// Function to find the student with the lowest grade
func lowest() {
    // Finding the index of the student with the lowest grade
    let ind = avg.firstIndex(of: avg.min()!)
    // Printing the name and grade of the student with the lowest grade
    print("\(names[ind!]) is the student with the lowest grade: \(avg[ind!])")
}

// Function to find the student with the highest grade
func highest() {
    // Finding the index of the student with the highest grade
    let ind = avg.firstIndex(of: avg.max()!)
    // Printing the name and grade of the student with the highest grade
    print("\(names[ind!]) is the student with the highest grade: \(avg[ind!])")
}

// Function to filter students by grade range
func filterByGrade() {
    // Prompting user to input the low range for grade filtering
    print("Enter the low range you would like to use:")
    let min = Double(readLine()!)!
    // Prompting user to input the high range for grade filtering
    print("Enter the high range you would like to use:")
    let max

 = Double(readLine()!)!
    // Filtering students based on grade range and printing their names and grades
    for i in 0..<avg.count {
        if avg[i] > min && avg[i] < max {
            print("\(names[i]): \(avg[i])")
        }
    }
}

// Function to change a student's grade
func change() {
    // Prompting user to input the name of the student
    print("Which student would you like to choose?")
    let name = readLine()!
    // Finding the index of the student in the lowercase names array
    let ind = namesLower.firstIndex(of: name.lowercased())
    // Checking if the student exists
    if ind != nil {
        // Prompting user to input the assignment number
        print("Which assignment would you like to change grade for of (1-10):")
        let ass = Int(readLine()!)!
        // Checking if the assignment number is valid
        if ass < avg.count+1 && ass > 0 {
            // Prompting user to input the new grade
            print("What do you want to change the grade to:")
            let grade = Double(readLine()!)!
            // Updating the grade for the specified assignment
            grades[ind!].grade[ass - 1] = grade
            // Calculating the new average grade for the student
            var sum = 0.0
            for i in 0..<grades[0].grade.count {
                sum += grades[ind!].grade[i]
            }
            let average = sum / 10.0
            avg[ind!] = average
            // Printing the updated grade and final grade for the student
            print("\(names[ind!])'s new grade for assignment \(ass) is \(grade). \(names[ind!])'s new final grade is \(average)")
        } else {
            // If the assignment number is not valid, prompting the user to enter a valid assignment
            print("Please enter a valid assignment!")
            change()
        }
    } else {
        // If the student name is not valid, prompting the user to enter a valid name
        print("Please enter a valid name!")
        change()
    }
}
