

import UIKit

// MARK: - CreateQuestionCellDelegate
public protocol CreateQuestionGroupTitleCellDelegate {
  func createQuestionGroupTitleCell(_ cell: CreateQuestionGroupTitleCell,
                                    titleTextDidChange text: String)
}

// MARK: - CreateQuestionGroupTitleCell
public class CreateQuestionGroupTitleCell: UITableViewCell {

  public var delegate: CreateQuestionGroupTitleCellDelegate?

  @IBOutlet public var titleTextField: UITextField!
}

// MARK: - IBActions
extension CreateQuestionGroupTitleCell {

  @IBAction public func titleTextFieldDidChange(_ textField: UITextField) {
    delegate?.createQuestionGroupTitleCell(self, titleTextDidChange: textField.text!)
  }
}

// MARK: - UITextFieldDelegate
extension CreateQuestionGroupTitleCell: UITextFieldDelegate {

  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}
