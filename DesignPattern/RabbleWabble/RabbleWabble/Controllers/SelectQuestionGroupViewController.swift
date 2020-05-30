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
    
    public let questionGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup: QuestionGroup!
    private let appSettings = AppSettings.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        guard let viewController = segue.destination as? QuestionViewController else { return }
        viewController.delegate = self
        viewController.questionStrategy = appSettings.questionStrategy(for: selectedQuestionGroup)
        //viewController.questionStrategy = RandomQuestionStrategy(questionGroup: selectedQuestionGroup)
        //QuestionViewController questionStrategy can be interchangeable b/w RandomQuestionStrategy and SequentialQuestionStrategy
        //viewController.questionStrategy = SequentialQuestionStrategy(questionGroup: selectedQuestionGroup)
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

