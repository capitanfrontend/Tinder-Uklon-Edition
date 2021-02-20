//
//  PopViewController.swift
//  Tinder-Uklon-Edition
//
//  Created by test on 20.02.2021.
//

import UIKit

class PopViewController: UIViewController {

    @IBOutlet weak var standartBtn: UIButton!
    @IBOutlet weak var tinderBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var findTaxi: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    
    
    @IBAction func standatrAction(_ sender: Any) {
        findTaxi?()
    }
    
    
    @IBAction func tinderAction(_ sender: Any) {
        
    }
    

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
