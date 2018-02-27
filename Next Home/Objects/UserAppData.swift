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
    
    var projects: [Project]!
    var rooms: [Room]!
    var materials: [Material]!
    
    let defaults = UserDefaults.standard
    
    var projectFilePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url?.appendingPathComponent("Projects").path)!
    }
    
    var roomFilePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url?.appendingPathComponent("Rooms").path)!
    }
    
    var materialFilePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url?.appendingPathComponent("Materials").path)!
    }
    
    func saveData(_ dataToSave: Any) {
        switch dataToSave {
        case is Project:
            NSKeyedArchiver.archiveRootObject(projects, toFile: projectFilePath)
        case is Room:
            NSKeyedArchiver.archiveRootObject(rooms, toFile: roomFilePath)
        case is Material:
            NSKeyedArchiver.archiveRootObject(materials, toFile: materialFilePath)
        default:
            print("Error saving files")
        }
    }
    
    func loadInData() {
        if let projectData = NSKeyedUnarchiver.unarchiveObject(withFile: projectFilePath) as? [Project] { projects = projectData }
        
        loadRoomsToArray()
        loadMaterialsToArray()
        
        print("Projects: " + String(projects.count))
        print("Rooms: " + String(rooms.count))
        print("Materials: " + String(materials.count))
    }
    
    func loadRoomsToArray() {
        
        for pro in projects {
            rooms = rooms + pro.rooms
        }
        
        //Add Sort Algorithm
        
    }
    
    func loadMaterialsToArray() {
        
        for room in rooms {
            materials = materials + room.roomMaterials
        }
        
        //Add Sort Algorithm
        
    }
    
    init() {
        projects = [Project]()
        rooms = [Room]()
        materials = [Material]()
        loadInData()
    }
    
    func getList(_ sender: String) -> [Any] {
        switch sender {
        case "project":
            return projects
        case "room":
            return rooms
        case "material":
            return materials
        default:
            return [Any]()
        }
    }
    
    func addToList(_ item: Any) {
        switch item {
        case is Project:
            print("Adding Project")
            projects.insert(item as! Project, at: 0)
            saveData(item)
        case is Room:
            rooms.insert(item as! Room, at: 0)
            saveData(item)
        case is Material:
            materials.insert(item as! Material, at: 0)
            saveData(item)
        default:
            print("Error adding item")
        }
        
    }
    
    
    func removeFromList(_ item: Any) {
        switch item {
        case is Project:
            if let projectIndex = projects.index(of: item as! Project) {
                projects.remove(at: projectIndex)
                saveData(item)
            }
        case is Room:
            if let roomIndex = rooms.index(of: item as! Room) {
                rooms.remove(at: roomIndex)
                saveData(item)
            }
        case is Material:
            if let materialIndex = materials.index(of: item as! Material) {
                materials.remove(at: materialIndex)
                saveData(item)
            }
        default:
            print("Error removing item")
        }
    }
    
}
