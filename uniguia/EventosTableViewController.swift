//
//  EventosTableViewController.swift
//  uniguia
//
//  Created by student on 03/06/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class EventosTableViewController: UITableViewController {
    var eventos = [Evento]()
    var evento = [Evento]()
   

    @IBAction func botao(_ sender: Any) {

    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       evento = EventoDAO.getList()
        eventos = EventoDAO.getList()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventos.count    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventoIdentifier", for: indexPath)
       
        if let eventoCell = cell as? EventosTableViewCell {
           
            print("bundinha")
            let evento = eventos[indexPath.row]
            
            eventoCell.nomeLabel.text = evento.local
            eventoCell.horarioLabel.text = evento.title
          
            return eventoCell
        }
        
        return cell
    }

    }
