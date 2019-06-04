    //
//  eventos.swift
//  uniguia
//
//  Created by student on 03/06/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation
    class Evento {

        let local: String
        let title: String
        
        
        init(local: String, title: String = "") {
            self.local = local
            self.title = title
    
        }
        
    }
    
 
    class EventoDAO {
        
        static func getList() -> [Evento] {
            return [
                Evento(local: "Reuniao", title: "12:12"),
                Evento(local: "Palestra nati", title: "12:12"),
                Evento(local: "Palestra CCT", title: "12:12"),
                Evento(local: "Palestra CCS", title: "12:12"),
                Evento(local: "APAPORRA", title: "12:12")
            ]
        }
        
    }
    
    class baconDAO{
        static func getBacon(){
            guard let url = URL(string: "https://uniguia.mybluemix.net/events") else { return }
            
            let urlRequest = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print("Error = \(String(describing: error))")
                    return
                }
                
                let responseString = String(data: data!, encoding: String.Encoding.utf8)
                print("responseString = \(String(describing: responseString))")
                
                DispatchQueue.main.async() {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                            
                            let eventos = Evento(local: String(describing: json))
                            
                            let nomeEvento = eventos.title
                            
                            print("\(nomeEvento)  \(eventos.title).")
                            
                            
                        }else {
                            
                            print("fudeuuuu")
                        }
                    } catch let error as NSError {
                        print("Error = \(error.localizedDescription)")
                    }
                }
                
                
            })
            
            task.resume()
            
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    print(data)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        
                    } catch {
                        print(error)
                    }
                    
                }
                }.resume()
        }
    }
    
    class EventosDAO {
        
        static func getEventos (callback: @escaping ((Evento) -> Void)) {
            
            let endpoint: String = "https://uniguia.mybluemix.net/eventos"
            
            guard let url = URL(string: endpoint) else {
                print("Erroooo: Cannot create URL")
                return
            }
            
            let urlRequest = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print("Error = \(String(describing: error))")
                    return
                }
                
                let responseString = String(data: data!, encoding: String.Encoding.utf8)
                print("responseString = \(String(describing: responseString))")
                
                DispatchQueue.main.async() {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                            
                            let evento = Evento(local: json[0]["local"] as! String)
                            
                            let nomelocal = evento.local
                            let nometitle = evento.title
                            
                            print("\(nomelocal) realizado em \(nometitle).")
                            
                            callback(evento)
                            
                        }else {
                            
                            print("Erro no link")
                        }
                    } catch let error as NSError {
                        print("Error = \(error.localizedDescription)")
                    }
                }
                
                
            })
            
            task.resume()
        }
    }
