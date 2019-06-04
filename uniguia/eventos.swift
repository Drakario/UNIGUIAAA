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
        
        static func getBacon() -> [Evento]{
            guard let url = URL(string: "https://uniguia.mybluemix.net/events") else { return [Evento.init(local: "APAPORA")] }
                let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
                request.httpMethod = "GET"
                 var session = URLSession.shared

            session.dataTaskWithRequest(request as URLRequest, queue: OperationQueue.main){(response, data, error) in }
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    print("Error = \(String(describing: error))")
                    return
                }
                do {
                    print("Response=\(String(describing: response))")
                    
                    let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Response data = \(String(describing: responseString))")
                    
                    
                    var json: NSDictionary!
                    json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    
                    let returnEventos: NSArray = json["returnEventos"] as! NSArray
                    
                    print(returnEventos);
                    
                    var local = [String]()
                    var title = [String]()
                    
                    for i in 0 ..< returnEventos.count{
                        
                        
                        let aObject = returnEventos[i] as! [String : AnyObject]
                       local.append((aObject["fullName"] as! String))
                        title.append((aObject["fullName"] as! String))
                        Evento(local: String(describing: local), title: String(describing: title) )
                        
                        
                    }
                    
                    
                }
                catch {
                    print("ERROR: \(error)")
                }
                
            }
            task.resume()

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
    }
