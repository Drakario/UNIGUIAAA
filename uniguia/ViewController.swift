//
//  ViewController.swift
//  uniguia
//
//  Created by student on 28/05/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imagem: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagem.image = UIImage(named: "unifor")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

