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
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Проверка, существует ли navigationController
        if navigationController == nil {
            print("navigationController не существует")
        } else {
            print("navigationController существует")
        }
        navigationController?.setNavigationBarHidden(false, animated: true)

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion()
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
        print("Кнопка нажата")
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Верно"
            score += 1
        } else {
            title = "Неверно"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Ваш счет \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Продолжить", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController появился на экране")
    }
    
}

