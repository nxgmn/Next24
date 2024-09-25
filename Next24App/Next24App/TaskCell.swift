//
//  TaskCell.swift
//  Next24App
//
//  Created by Casey Chin on 9/24/24.
//

import Foundation
import UIKit

class TaskCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var completeButton: UIButton!
    
    var task: Task!
    
    var text : UITextField!
    
    
    var onCompleteButtonTapped: ((Task) -> Void)?
    
    @IBAction func tapCompleteButton(_ sender: UIButton) {
        
        task.isCompleted = !task.isCompleted
        
        onCompleteButtonTapped?(task)
        
    }
    
    func config(with task:Task, onCompleteButtonTapped: ((Task) -> Void)?) {
        
        self.task = task

        self.onCompleteButtonTapped = onCompleteButtonTapped
        
        update(with: task)
        
        
        
    }
    
    private func update(with task: Task) {

            text.text = task.title

            text.textColor = task.isCompleted ? .secondaryLabel : .label

            completeButton.isSelected = task.isCompleted

            completeButton.tintColor = task.isCompleted ? .systemBlue : .tertiaryLabel
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) { }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return !task.isCompleted

    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text!.count > 100 {
            return true
        }
        return false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text!.isEmpty {
            
            return false
            
        }
        
        task.title = textField.text!
        return true
        
    }
    
}
