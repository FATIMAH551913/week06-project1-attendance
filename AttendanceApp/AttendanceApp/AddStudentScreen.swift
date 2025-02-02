//
//  AddStudentScreen.swift
//  AttendanceApp
//
//  Created by fatimah on 30/03/1443 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class AddStudentScreen: UIViewController {
    
    let nameOfStudentTextField = UITextField()
    let addButton = UIButton(type: .system)
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNameOfStudentTF()
        setupAddStudentButton()}
    
    private func setupNameOfStudentTF() {
        nameOfStudentTextField.backgroundColor = .systemGray4
        nameOfStudentTextField.layer.cornerRadius = 3
        nameOfStudentTextField.clipsToBounds = true
        nameOfStudentTextField.placeholder = " Name of Student's"
        nameOfStudentTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        nameOfStudentTextField.leftViewMode = .always
        nameOfStudentTextField.autocorrectionType = .no
        nameOfStudentTextField.autocapitalizationType = .words
        nameOfStudentTextField.tintColor = .black
        nameOfStudentTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameOfStudentTextField)
        nameOfStudentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameOfStudentTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameOfStudentTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        nameOfStudentTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true}
    
    private func setupAddStudentButton() {
        
        addButton.layer.cornerRadius    = 10
        addButton.layer.borderColor     = UIColor.systemIndigo.cgColor
        addButton.layer.borderWidth     = 0.40
        addButton.backgroundColor       = .white
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: nameOfStudentTextField.bottomAnchor, constant: 45).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true}
    
    @objc private func addButtonTapped() {
        
        guard let tfText = nameOfStudentTextField.text else {return}
        guard let user = Auth.auth().currentUser else {print("error sign in user"); return}
        if !tfText.isEmpty {
            
            db.collection("Teacher").document().setData([
                "studentName" : tfText,
                "teacherID": user.uid]
                                                        , merge: true) { error in
                if let error = error {
                    print("Error saving data for teacher: \(error.localizedDescription)")
                    return
                }else{
                    print("successfully added student to Teacher Collection")}}
            self.dismiss(animated: true, completion: nil)}}}

