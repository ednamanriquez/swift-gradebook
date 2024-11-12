// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

struct Student {
    let name: String
    var grades: [String: Int] = [:]
}

struct Assignment {
    let name: String
}

class Gradebook {
    private var students: [Student] = []
    private var assignments: [Assignment] = []
    
    // Function to clear the terminal
    func clearScreen() {
       // print("\u{1B}[2J") // ANSI escape code to clear terminal
    }
    
    // Main menu to navigate choices
    func mainMenu() {
        var shouldExit = false
        while !shouldExit {
            clearScreen()
            print("---- Gradebook Main Menu ----")
            print("1. Add Student(s)")
            print("2. Add Assignment")
            print("3. Update Grades")
            print("4. View All Grades")
            print("5. Exit")
            print("-----------------------------")
            print("Enter your choice: ", terminator: "")
            
            if let choice = readLine(), let option = Int(choice) {
                clearScreen()
                switch option {
                case 1:
                    addStudents()
                case 2:
                    addAssignment()
                case 3:
                    updateGrades()
                case 4:
                    viewAllGrades()
                case 5:
                    shouldExit = true
                default:
                    print("Invalid choice. Please try again.")
                }
            }
        }
    }
    
    // Function to add multiple students
    func addStudents() {
        print("Enter student names separated by commas (e.g., Jack, Jill, Jim): ", terminator: "")
        
        if let input = readLine() {
            let names = input.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            for name in names where !name.isEmpty {
                students.append(Student(name: name))
                print("Added student: \(name)")
            }
        }
        
        print("Press Enter to return to the main menu.")
        _ = readLine()
    }
    
    // Function to add an assignment for all students
    func addAssignment() {
        print("Enter assignment name: ", terminator: "")
        
        if let name = readLine(), !name.isEmpty {
            let assignment = Assignment(name: name)
            assignments.append(assignment)
            for i in 0..<students.count {
                students[i].grades[name] = 0 // Initialize all students with a grade of 0
            }
            print("Added assignment: \(name) to all students.")
        }
        
        print("Press Enter to return to the main menu.")
        _ = readLine()
    }
    
    // Function to update grades for a specific student and assignment
    func updateGrades() {
        print("Enter student name: ", terminator: "")
        
        if let name = readLine(), let studentIndex = students.firstIndex(where: { $0.name == name }) {
            let student = students[studentIndex]
            print("Assignments for \(student.name):")
            
            for (index, assignment) in assignments.enumerated() {
                print("\(index + 1). \(assignment.name)")
            }
            
            print("Enter the assignment number to update: ", terminator: "")
            if let assignmentChoice = readLine(), let assignmentIndex = Int(assignmentChoice), assignmentIndex > 0, assignmentIndex <= assignments.count {
                let assignmentName = assignments[assignmentIndex - 1].name
                print("Enter new grade for \(assignmentName): ", terminator: "")
                
                if let gradeInput = readLine(), let grade = Int(gradeInput) {
                    students[studentIndex].grades[assignmentName] = grade
                    print("Updated \(student.name)'s grade for \(assignmentName) to \(grade).")
                } else {
                    print("Invalid grade input.")
                }
            } else {
                print("Invalid assignment choice.")
            }
        } else {
            print("Student not found.")
        }
        
        print("Press Enter to return to the main menu.")
        _ = readLine()
    }
    
    // Function to view all grades for all students
    func viewAllGrades() {
        print("---- All Students' Grades ----")
        
        for student in students {
            print("Student: \(student.name)")
            for (assignment, grade) in student.grades {
                print("  \(assignment): \(grade)")
            }
            print()
        }
        
        print("Press Enter to return to the main menu.")
        _ = readLine()
    }
}

// Initialize Gradebook and start the main menu
let gradebook = Gradebook()
gradebook.mainMenu()
