//
//  ViewController.swift
//  19. Project 2
//
//  Created by Валентин Картошкин on 26.04.2025.
//

import UIKit

class Project2ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var scoresLabel: UILabel!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion()
        
        scoresLabel.text = "0 Баллов"
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        titleLabel.text = countries[correctAnswer].uppercased()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        print("вопрос № \(questionNumber)")
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Верно"
            score += 1
        } else {
            title = "Неверно"
            score -= 1
            
            // Создаем первый алерт (об ошибке)
            let errorAlert = UIAlertController(title: "Упс...", message: "ошибочка 😨", preferredStyle: .alert)
            
            // Добавляем действие, которое выполнится после закрытия этого алерта
            errorAlert.addAction(UIAlertAction(title: "пофиг", style: .default) { [weak self] _ in
                guard let self = self else { return }
                
                // Проверяем, не закончилась ли игра
                if self.questionNumber == 10 {
                    // Создаем второй алерт (об окончании игры)
                    let finalAlert = UIAlertController(title: title,
                                                      message: "Ваш счет \(self.score)",
                                                      preferredStyle: .alert)
                    finalAlert.addAction(UIAlertAction(title: "Игра окончена", style: .default, handler: self.askQuestion))
                    
                    self.present(finalAlert, animated: true)
                    self.questionNumber = 1
                    self.score = 0
                } else {
                    self.questionNumber += 1
                    self.askQuestion()
                }
                
                self.scoresLabel.text = "Баллов: \(self.score)"
            })
            
            present(errorAlert, animated: true)
            return // Важно: выходим из метода здесь
        }
        
        // Этот код выполняется только для правильных ответов
        if questionNumber == 10 {
            let ac = UIAlertController(title: title, message: "Ваш счет \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Игра окончена", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
            questionNumber = 1
            score = 0
        } else {
            questionNumber += 1
            askQuestion()
        }
        
        scoresLabel.text = "Баллов: \(score)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController появился на экране")
    }
    
}

