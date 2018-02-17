//
//  UserAppData.swift
//  Next Home
//
//  Created by Tyler Collins on 2/9/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit

class UserAppData {
    
    struct userItems {
        static var userProjects = [Project]()
        static var userRooms = [Room]()
        static var userMaterials = [Material]()
    }
    
    struct userProjects {
        
        var userProjectsList = [Project]()
        
        mutating func addProject(_ newProject: Project) {
            self.userProjectsList.insert(newProject, at: 0)
        }
        
        mutating func removeProject(_ removedProject: Project) {
            if let projectIndex = self.userProjectsList.index(of: removedProject) {
                self.userProjectsList.remove(at: projectIndex)
            }
        }
        
    }
    
    struct userRooms {
        
        var userRoomsList = [Room]()
        
        mutating func addRoom(_ newRoom: Room) {
            userRoomsList.insert(newRoom, at: 0)
        }
        
        mutating func removeRoom(_ removedRoom: Room) {
            if let roomIndex = self.userRoomsList.index(of: removedRoom) {
                self.userRoomsList.remove(at: roomIndex)
            }
        }
        
    }
    
    struct userMaterials {
        
        var userMaterialsList = [Material]()
        
        mutating func addMaterial(_ newMaterial: Material) {
            self.userMaterialsList.insert(newMaterial, at: 0)
        }
        
        mutating func removeMaterial(_ removedMaterial: Material) {
            if let materialIndex = self.userMaterialsList.index(of: removedMaterial) {
                self.userMaterialsList.remove(at: materialIndex)
            }
        }
        
    }
    
}
