//
//  SingleNoteViewController.swift
//  Notes
//
//  Created by Jon Basa on 4/24/20.
//  Copyright © 2020 Jon Basa. All rights reserved.
//

import UIKit

class SingleNoteViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteTextField: UITextField!
    
    var existingNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        nameTextField.delegate = self
        noteTextField.delegate = self
        
        nameTextField.text = existingNote?.name
        noteTextField.text = existingNote?.note
        
        if let date = existingNote?.date {
            datePicker.date = date
        }

    }

    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        noteTextField.resignFirstResponder()
    }
    
    @IBAction func saveNote(_ sender: Any) {
        let name = nameTextField.text
        let noteText = noteTextField.text
        let date = datePicker.date
        
        var note: Note?
    
        if let existingNote = existingNote {
            existingNote.name = name
            existingNote.date = date
            existingNote.note = noteText
            
            note = existingNote
        } else {
            note = Note(name: name, date: date, note: noteText)
        }
        
        if let note = note {
            do {
                let managedContext = note.managedObjectContext
                
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Context count not be saved")
            }
        }
    }
}

extension SingleNoteViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}
