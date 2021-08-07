//
//  ResultViewController.swift
//  PersonalityTest
//
//  Created by Ewen on 2021/8/6.
//

import UIKit

protocol ResultViewControllerProtocol {
    func dialogDismissed()
}

class ResultViewController: UIViewController {
    
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultNameLabel: UILabel!
    @IBOutlet weak var resultTypeLabel: UILabel!
    @IBOutlet weak var resultDescriptionLabel: UILabel!

    let colors: [UIColor] = [
        UIColor.init(red: 231/255, green: 216/255, blue: 224/255, alpha: 1),
        UIColor.init(red: 219/255, green: 237/255, blue: 229/255, alpha: 1),
        UIColor.init(red: 205/255, green: 229/255, blue: 230/255, alpha: 1),
        UIColor.init(red: 247/255, green: 232/255, blue: 203/255, alpha: 1),
    ]
    
    // ResultViewController 的屬性
    var personalityInfo: Personality!
    var personalityIndex = 0

    //宣告 ResultViewController 的 delegate（將是 view controller）
    var delegate: ResultViewControllerProtocol?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dialogView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 元件被載入後，用「帶有前一頁資料的屬性」更新元件
        resultImageView.image = UIImage(imageLiteralResourceName: "\(personalityIndex) \(personalityInfo.type)")
        resultNameLabel.text = personalityInfo.name
        resultTypeLabel.text = personalityInfo.type
        resultDescriptionLabel.text = personalityInfo.description
        
        
        switch personalityInfo.category {
        case .Analysts:
            dialogView.backgroundColor = colors[0]
        case .Diplomats:
            dialogView.backgroundColor = colors[1]
        case .Sentinels:
            dialogView.backgroundColor = colors[2]
        case .Explorers:
            dialogView.backgroundColor = colors[3]
        }
    }
    
    @IBAction func restartAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
        delegate?.dialogDismissed()
    }
    
}
