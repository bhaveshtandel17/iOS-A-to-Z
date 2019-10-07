

import UIKit

// MARK: - CreateQuestionCellDelegate
public protocol CreateQuestionCellDelegate {
  func createQuestionCell(_ cell: CreateQuestionCell, answerTextDidChange text: String)
  func createQuestionCell(_ cell: CreateQuestionCell, hintTextDidChange text: String)
  func createQuestionCell(_ cell: CreateQuestionCell, promptTextDidChange text: String)
}

// MARK: - CreateQuestionCell
public class CreateQuestionCell: UITableViewCell {

  public var delegate: CreateQuestionCellDelegate?

  @IBOutlet public var answerTextField: UITextField!
  @IBOutlet public var hintTextField: UITextField!
  @IBOutlet public var indexLabel: UILabel!
  @IBOutlet public var promptTextField: UITextField!
}

// MARK: - IBActions
extension CreateQuestionCell {
  @IBAction public func answerTextFieldDidChange(_ textField: UITextField) {
    delegate?.createQuestionCell(self, answerTextDidChange: textField.text!)
  }

  @IBAction public func hintTextFieldDidChange(_ textField: UITextField) {
    delegate?.createQuestionCell(self, hintTextDidChange: textField.text!)
  }

  @IBAction public func promptTextFieldDidChange(_ textField: UITextField) {
    delegate?.createQuestionCell(self, promptTextDidChange: textField.text!)
  }
}

// MARK: - UITextFieldDelegate
extension CreateQuestionCell: UITextFieldDelegate {

  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}
