//
//  PassGenerator.swift
//  PassGenerator - Treehouse Project 4
//
//  Created by Adam Chiaravalle on 11/22/16.
//  Copyright © 2016 Adam Chiaravalle. All rights reserved.
//

import Foundation

// MARK: PassGenerator: Creates passes. Right now it is populated with lots of test guests in order to showcase the functionality of each one.

class PassGenerator {
    func generateAndRunTests() {
        // Classic Guest
        let classicGuest = ClassicGuest()
        swipe(guest: classicGuest)
        
        // VIP Guest
        let vipGuest = VIPGuest()
        swipe(guest: vipGuest)
        
        // Free Child Guest
        let today = Date()
        do {
            if let birthdate = try Date(dateStringyyyyMMdd: "2011/11/23") {
                print("Guest is less than 5 years old: \(today.isLessThan5YearsOld(birthdate: birthdate))")
                
                do {
                    print("Birthdate of \(birthdate) entered to apply for a free child guest pass. Error displayed below if guest is too old.")
                    
                    if let freeChildGuest = try FreeChildGuest(birthdate: birthdate) {
                        swipe(guest: freeChildGuest)
                    }
                } catch {
                    print(error)
                }
                
                print("\n")
            }
        }
        catch {
            print(error)
        }
        
        
        // Define personal info for employees
        let info = PersonalInfo(firstName: "Adam", lastName: "Chiaravalle", streetAddress: "200 Acme Lane", city: "Nashville", state: "TN", zipCode: 37127)
        
        // Food Services Employee
        let foodServicesEmployee = FoodServicesEmployee(info: info)
        swipe(guest: foodServicesEmployee)
        
        // Ride Services Employee
        let rideServicesEmployee = RideServicesEmployee(info: info)
        swipe(guest: rideServicesEmployee)
        
        // Maintenance Employee
        let maintenanceEmployee = MaintenanceEmployee(info: info)
        swipe(guest: maintenanceEmployee)
        
        // Manager Employee
        let managerEmployee = ManagerEmployee(info: info)
        swipe(guest: managerEmployee)
    }
    
    func swipe(guest: EntrantType) {
        print("Type of Guest: \(guest.type)")
        
        if let info = guest.personalInfo {
            print("Name: \(info.firstName) \(info.lastName)")
            print("Address \(info.streetAddress),\n\(info.city), \(info.state) \(info.zipCode)")
        }
        
        let areaAccess = guest.areaAccess()
        let discountAccess = guest.discountAccess()
        let rideAccess = guest.rideAccess()
        
        // For now, we are simply printing out each access capability. This will be changed to function with the UI in the next project.
        
        print("Area Access: ")
        print("\t Amusement Areas: \(areaAccess.amusementAreas)")
        print("\t Kitchen Areas: \(areaAccess.kitchenAreas)")
        print("\t Ride Control Areas: \(areaAccess.rideControlAreas)")
        print("\t Maintenance Areas: \(areaAccess.maintenanceAreas)")
        print("\t Office Areas: \(areaAccess.officeAreas)")
        
        print("Discount Access: ")
        print("\t Food Discount: \(discountAccess.foodPercentage)")
        print("\t Merchandise Discount: \(discountAccess.merchPercentage)")
        
        print("Ride Access: ")
        print("\t Can Ride Rides: \(rideAccess.canRide)")
        print("\t Can Skip Ride Lines: \(rideAccess.canSkip) \n\n")
    }
}
