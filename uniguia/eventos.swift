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

    
    
    class Eventos2DAO {
        
        static func getEventos () -> [Eventos]{
            
            let session = URLSession.shared
            let url = URL(string: "https://uniguia.mybluemix.net/events")!
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil || data == nil {
                    print("Client error!")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }
                
                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    let responseString = String(data: data!, encoding: String.Encoding.utf8)
                                        
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }        
            }
            
            task.resume()
            
        return[
            
            ]
    }
    
    }
