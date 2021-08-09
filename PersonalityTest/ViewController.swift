//
//  ViewController.swift
//  PersonalityTest
//
//  Created by Ewen on 2021/8/6.
//

import UIKit

class ViewController: UIViewController, ResultViewControllerProtocol {

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var choiceOneButton: UIButton!
    @IBOutlet weak var choiceTwoButton: UIButton!
    
    var currentQuestionIndex = 0 //現在題目index
    
    var resultVC: ResultViewController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 畫漸層背景
        createGradientBackground()
        
        // 選項變圓角
        choiceOneButton.layer.cornerRadius = 10
        choiceOneButton.clipsToBounds = true
        choiceTwoButton.layer.cornerRadius = 10
        choiceTwoButton.clipsToBounds = true

        // 顯示第一題
        displayQuestion()
        
        // 初始化 resultVC
        resultVC = storyboard?.instantiateViewController(identifier: "ResultVC") as? ResultViewController
        // 設定轉場效果
        resultVC?.modalPresentationStyle = .overCurrentContext
        
        resultVC?.delegate = self
    }
    
    func createGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 50/255, green: 8/255, blue: 103/255, alpha: 1).cgColor,
            UIColor(red: 46/255, green: 206/255, blue: 207/255, alpha: 1).cgColor,
        ]
        
        // 決定漸層的方向
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // 漸層變化範圍
        gradientLayer.locations = [0, 0.6]
        
        // 將漸層的 layer 加在最底層。如果用 addSublayer 加入會把畫面覆蓋掉。
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func displayQuestion() {
        // 更新選項的 text
        choiceOneButton.setTitle(questions[currentQuestionIndex].choices[0].content, for: .normal)
        
        choiceTwoButton.setTitle(questions[currentQuestionIndex].choices[1].content, for: .normal)
    }
    
    
    func computePersonalityType() -> String {
        let I_Score =
        questions[0].choices[1].score +
        questions[4].choices[0].score +
        questions[8].choices[0].score +
        questions[12].choices[0].score +
        questions[16].choices[0].score +
        questions[20].choices[1].score +
        questions[24].choices[1].score +
        questions[28].choices[1].score
        let E_Score =
        questions[0].choices[0].score +
        questions[4].choices[1].score +
        questions[8].choices[1].score +
        questions[12].choices[1].score +
        questions[16].choices[1].score +
        questions[20].choices[0].score +
        questions[24].choices[0].score +
        questions[28].choices[0].score

        let N_Score =
        questions[1].choices[0].score +
        questions[5].choices[1].score +
        questions[9].choices[0].score +
        questions[13].choices[0].score +
        questions[17].choices[0].score +
        questions[21].choices[0].score +
        questions[25].choices[1].score +
        questions[29].choices[0].score
        let S_Score =
        questions[1].choices[1].score +
        questions[5].choices[0].score +
        questions[9].choices[1].score +
        questions[13].choices[1].score +
        questions[17].choices[1].score +
        questions[21].choices[1].score +
        questions[25].choices[0].score +
        questions[29].choices[1].score
        
        let T_Score =
        questions[2].choices[0].score +
        questions[6].choices[0].score +
        questions[10].choices[0].score +
        questions[14].choices[1].score +
        questions[18].choices[1].score +
        questions[22].choices[1].score +
        questions[26].choices[0].score +
        questions[30].choices[1].score
        let F_Score =
        questions[2].choices[1].score +
        questions[6].choices[1].score +
        questions[10].choices[1].score +
        questions[14].choices[0].score +
        questions[18].choices[0].score +
        questions[22].choices[0].score +
        questions[26].choices[1].score +
        questions[30].choices[0].score
        
        let P_Score =
        questions[3].choices[0].score +
        questions[7].choices[0].score +
        questions[11].choices[0].score +
        questions[15].choices[0].score +
        questions[19].choices[1].score +
        questions[23].choices[1].score +
        questions[27].choices[0].score +
        questions[31].choices[1].score
        let J_Score =
        questions[3].choices[1].score +
        questions[7].choices[1].score +
        questions[11].choices[1].score +
        questions[15].choices[1].score +
        questions[19].choices[0].score +
        questions[23].choices[0].score +
        questions[27].choices[1].score +
        questions[31].choices[0].score
    
        var typeString = ""
        
        let arrTemp1 = ["I", "E"]
        if  I_Score > E_Score {
            typeString += "I"
        } else if I_Score < E_Score {
            typeString += "E"
        } else {
            typeString += arrTemp1.randomElement()!
        }
        
        let arrTemp2 = ["N", "S"]
        if  N_Score > S_Score {
            typeString += "N"
        } else if  N_Score < S_Score {
            typeString += "S"
        } else {
            typeString += arrTemp2.randomElement()!
        }
        
        let arrTemp3 = ["T", "F"]
        if  T_Score > F_Score {
            typeString += "T"
        } else if T_Score < F_Score {
            typeString += "F"
        } else {
            typeString += arrTemp3.randomElement()!
        }
        
        let arrTemp4 = ["P", "J"]
        if P_Score > J_Score {
            typeString += "P"
        } else if P_Score < J_Score {
            typeString += "J"
        } else {
            typeString += arrTemp4.randomElement()!
        }
        
        return typeString
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var personalityTypeText = ""
        var index = 0
        
        // 題目指標+1
        currentQuestionIndex += 1
        
        // 更新進度條
        progressBar.progress = Float(currentQuestionIndex) / Float(questions.count)
        
        
        if currentQuestionIndex == questions.count {
            // 沒下一題了，
            // 計算是哪一個人格 type，回傳字串
            personalityTypeText = computePersonalityType()
            
            // 求出 personalityTypeText 屬於的 struct 在陣列中的 index
            switch personalityTypeText {
            case "INTJ": index = 0
            case "INTP": index = 1
            case "ENTJ": index = 2
            case "ENTP": index = 3
            case "INFJ": index = 4
            case "INFP": index = 5
            case "ENFJ": index = 6
            case "ENFP": index = 7
            case "ISTJ": index = 8
            case "ISFJ": index = 9
            case "ESTJ": index = 10
            case "ESFJ": index = 11
            case "ISTP": index = 12
            case "ISFP": index = 13
            case "ESTP": index = 14
            case "ESFP": index = 15
            default: break
            }
            
            // 把【Personality Struct 物件】和其 index 傳給 resultVC 的屬性們
            resultVC?.personalityInfo = personalities[index]
            resultVC?.personalityIndex = index
    
            // Show the popup
            present(resultVC!, animated: true, completion: nil)
            
        } else if currentQuestionIndex < questions.count {
            // 還有題目
            
            if sender.tag == 0 {
                // 點到上面的按鈕，對應選項的score + 1
                questions[currentQuestionIndex - 1].choices[0].score += 1
            } else {
                // 點到下面的按鈕，對應選項的score + 1
                questions[currentQuestionIndex - 1].choices[1].score += 1
            }
            
            // 顯示下題
            displayQuestion()
        }
    }
    
    // MARK: - ResultViewControllerProtocol Methods
    func dialogDismissed() {
        //在總結對話窗按 "Test Again" 後，要回到第一題
        
        // score歸零
        for i in 0..<questions.count {
            questions[i].choices[0].score = 0
            questions[i].choices[1].score = 0
        }
            
        // 指標回到第1題
        currentQuestionIndex = 0
        
        // 進度條歸零
        progressBar.progress = 0

        // 顯示問題
        displayQuestion()
    }
}
