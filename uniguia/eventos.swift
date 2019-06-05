    //
//  eventos.swift
//  uniguia
//
//  Created by student on 03/06/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation
    class Evento {

        var local: String
        var title: String
        
        
        init(local: String, title: String = "") {
           self.local = local
            self.title = title

        }
        
    }
    class Eventos {
        var local: String
        var title: String
        init(json: [String: AnyObject]) {
            self.local = json["local"] as? String ?? ""
            self.title = json["title"] as? String ?? ""
        }
    }
    
 
    class EventosDAO {
        
        static func getEventos (callback: @escaping ((Eventos) -> Void)) {
            
            let endpoint: String = "https://uniguia.mybluemix.net/events"
            
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
                            
                            let evento = Eventos(json: json[0])
                            
                            callback(evento)

                            
                        }else {
                            
                            print("Erro")
                        }
                    } catch let error as NSError {
                        print("Error = \(error.localizedDescription)")
                    }
                }
                
                
            })
            
            task.resume()
        }
    }
    class EventoDAO {
        
        static func getList() -> [Evento] {
            return [
                Evento(local: "Auditório da Biblioteca  9h", title: "Unifor recebe professor francês Michel Prieur para palestra sobre Direito Ambiental"),
                Evento(local: " Bloco C, sala C01  17h30", title: "Pós-Unifor promove evento sobre Terapia Cognitivo Comportamental e desafios em quadros depressivos"),
                Evento(local: "Teatro Celina Queiroz  19h", title: "Escola Waldorf Micael realiza palestra sobre educação na Unifor")
            ]
        }
        
    }

    
    class Eventos2DAO {
        
        static func getEventos (callback: @escaping ((Evento) -> Void)) {
            
            let endpoint: String = "https://uniguia.mybluemix.net/events"
            
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
                        if (try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]]) != nil {
                            
                            let evento = Evento(local: "", title: "")
                            
                            let nomelocal = evento.local
                            let nometitle = evento.title
                            
                            print("\(nomelocal) realizado em \(nometitle). \(evento.title)")
                            callback(evento)
                            
                        }else {
                            
                            print("Erro")
                        }
                    } catch let error as NSError {
                        print("Error = \(error.localizedDescription)")
                    }
                }
                
                
            })
            
            task.resume()
        }
    }
    
    
