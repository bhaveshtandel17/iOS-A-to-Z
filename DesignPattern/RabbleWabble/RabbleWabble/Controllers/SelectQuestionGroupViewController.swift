//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by Bhavesh Tandel on 29/05/20.
//  Copyright © 2020 Bhavesh Tandel. All rights reserved.
//

import UIKit

class SelectQuestionGroupViewController: UIViewController {

    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    private let questionGroupCaretaker = QuestionGroupCaretaker()
    private var questionGroups: [QuestionGroup] {
        return questionGroupCaretaker.questionGroups
    }
    private var selectedQuestionGroup: QuestionGroup! {
        get {
            return questionGroupCaretaker.selectedQuestionGroup
        }
        set {
            questionGroupCaretaker.selectedQuestionGroup = newValue
        }
    }
    private let appSettings = AppSettings.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionGroups.forEach {
            print("\($0.title): " +
                "correctCount \($0.score.correctCount), " +
                "incorrectCount \($0.score.incorrectCount)"
            )
        }
    }
}

// MARK: - UITableViewDataSource
extension SelectQuestionGroupViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
            return questionGroups.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
        let questionGroup = questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        cell.percentageSubscriber = questionGroup.score.$runningPercentage // 1
            .receive(on: DispatchQueue.main) // 2
            .map() { // 3
                return String(format: "%.0f %%", round(100 * $0))
        }.assign(to: \.text, on: cell.percentageLabel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectQuestionGroupViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? QuestionViewController {
            viewController.delegate = self
            viewController.questionStrategy = appSettings.questionStrategy(for: questionGroupCaretaker)
            //viewController.questionStrategy = RandomQuestionStrategy(questionGroup: selectedQuestionGroup)
            //QuestionViewController questionStrategy can be interchangeable b/w RandomQuestionStrategy and SequentialQuestionStrategy
            //viewController.questionStrategy = SequentialQuestionStrategy(questionGroup: selectedQuestionGroup)
        } else if let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? CreateQuestionGroupViewController {
            viewController.delegate = self
        }
    }
}

extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func questionViewController(_ viewController: QuestionViewController, didComplete questionStrategy: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
}

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
