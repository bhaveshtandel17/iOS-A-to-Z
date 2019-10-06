//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by Bhavesh Tandel on 03/10/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class SelectQuestionGroupViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - Properties
    private let questionGroupCaretaker = QuestionGroupCaretaker()
    private var questionGroups: [QuestionGroup] {
        return questionGroupCaretaker.questionGroups
    }
    private var selectedQuestionGroup: QuestionGroup! {
        get { return questionGroupCaretaker.selectedQuestionGroup }
        set { questionGroupCaretaker.selectedQuestionGroup = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for questionGroups in questionGroupCaretaker.questionGroups {
            print("\(questionGroups.title) :\(questionGroups.score.correctCount) \(questionGroups.score.incorrectCount)")
        }
    }
}

// MARK: - UITableViewDataSource
extension SelectQuestionGroupViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int)
        -> Int {
            return questionGroups.count
    }
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
            let questionGroup = questionGroups[indexPath.row]
            cell.titleLabel.text = questionGroup.title
            questionGroup.score.runningPercentage.addObserver(cell, options: [.initial, .new]) {
                [weak cell] (percentage, _) in
                DispatchQueue.main.async {
                    cell?.percentageLabel.text = String(format: "%.0f %%", round(100 * percentage))
                }
            }
            return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectQuestionGroupViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                          willSelectRowAt indexPath: IndexPath)
        -> IndexPath? {
            selectedQuestionGroup = questionGroups[indexPath.row]
            return indexPath
    }
    
    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public override func prepare(for segue: UIStoryboardSegue,
                                 sender: Any?) {
        if let viewController = segue.destination as? QuestionViewController {
            let appSettings = AppSettings.shared
            viewController.questionStrategy = appSettings.questionStrategy(for: questionGroupCaretaker)
            viewController.delegate = self
        } else if let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? CreateQuestionGroupViewController {
            viewController.delegate = self
        }
    }
}

// MARK: - QuestionViewControllerDelegate
extension SelectQuestionGroupViewController:
QuestionViewControllerDelegate {
    func questionViewController(_ viewController: QuestionViewController, didCancel questionStrategy: QuestionStrategy) {
        navigationController?.popToViewController(self,
                                                  animated: true)
    }
    
    func questionViewController(_ viewController: QuestionViewController, didComplete questionStrategy: QuestionStrategy) {
        navigationController?.popToViewController(self,
                                                  animated: true)
    }
}

// MARK: - CreateQuestionGroupViewControllerDelegate
extension SelectQuestionGroupViewController: CreateQuestionGroupViewControllerDelegate {
    public func createQuestionGroupViewControllerDidCancel(_ viewController: CreateQuestionGroupViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    public func createQuestionGroupViewController(_ viewController: CreateQuestionGroupViewController, created questionGroup: QuestionGroup) {
        questionGroupCaretaker.questionGroups.append(questionGroup)
        try? questionGroupCaretaker.save()
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}
