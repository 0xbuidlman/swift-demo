//
//  File.swift
//  TicTacIOiOS
//
//  Created by Александр Мазалецкий on 20.09.16.


import UIKit

import Foundation


class ViewController: UIViewController {
    
    var socket: SocketIOClient?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr:String = "https://api.radiofx.co" as String!
        
        
        let jwt:String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Ijc5MTE1MTE4Mjk0IiwiY3MiOiI1NWQwODJhNTg4YzAwMDAwIiwiaWF0IjoxNDc0MjgxNzcyLCJhdWQiOiJhcGkiLCJpc3MiOiJtcy11c2VycyJ9.x9rsH6zozKzYT_j9NggOzu5hRWpilsCdbWz-iJmnd7c"
        
        //print("---string---")
        
        socket = SocketIOClient(socketURL: URL(string: urlStr)!, config: [.log(true), .path("/chat/socket.io/"), .connectParams(["token":jwt]), .secure(true), .forceWebsockets(true)])
        
        
      
        
        
        socket?.on("connect") {data, ack in
            print("--connecting---")
            self.socket?.emitWithAck("chat.rooms.join", ["id":"6b9280a7-8af0-4d74-be89-d01fdcd39afc"])(0) {data in
                print(data)
                //print(ack)
            }
            
            self.socket?.on("messages.send.6b9280a7-8af0-4d74-be89-d01fdcd39afc") {data, ack in
                print("room connected")
                print(data)
                print(ack)
            }
        }
        
        
        
        
        
        
        socket?.connect()
        
    }
}
