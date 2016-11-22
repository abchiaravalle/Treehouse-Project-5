//
//  Entrants.swift
//  PassGenerator - Treehouse Project 4
//
//  Created by Adam Chiaravalle on 11/22/16.
//  Copyright © 2016 Adam Chiaravalle. All rights reserved.
//

import Foundation

// MARK: Error types

enum GuestErrors: Error {
    case GuestTooOld
}

enum DateErrors: Error {
    case EmptyDateString
    case DateCalculatonError
    case InvalidDateFromString
}

// MARK: Define types of guests as enums

enum TypeOfEntrant {
    case ClassicGuest
    case VIPGuest
    case FreeChildGuest
    case FoodServicesHourlyEmployee
    case RideServicesHourlyEmployee
    case MaintenanceHourlyEmployee
    case ManagerSalariedEmployee
}

// MARK: Protocols

protocol EntrantType {
    var type: TypeOfEntrant { get }
    var personalInfo: PersonalInfo? { get }
    
    func areaAccess() -> AreaAcessMatrix
    func discountAccess() -> DiscountAccessMatrix
    func rideAccess() -> RideAccessMatrix
}

protocol GuestType : EntrantType { }

protocol EmployeeType: EntrantType {
    init(info: PersonalInfo)
}

protocol HourlyEmployee: EmployeeType { }

protocol SalariedEmployee: EmployeeType { }

protocol DailyGuestType: GuestType { }

// MARK: Define specific custom types to be used within entrant data types. These contain boolean values to specify whether an entrant has access to a certan privilege.

struct AreaAcessMatrix {
    var amusementAreas: Bool
    var kitchenAreas: Bool
    var rideControlAreas: Bool
    var maintenanceAreas: Bool
    var officeAreas: Bool
}

struct DiscountAccessMatrix {
    var foodPercentage: Double
    var merchPercentage: Double
}

struct RideAccessMatrix {
    var canRide: Bool
    var canSkip: Bool
}

// Type to hold personal info only when required
struct PersonalInfo {
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: Int
}

// MARK: structs for types of entrants. Each entrant's access is defined by returning the 3 types of matrices, listed above

struct ClassicGuest: DailyGuestType {
    var type: TypeOfEntrant = .ClassicGuest
    var personalInfo: PersonalInfo?
    
    func areaAccess() -> AreaAcessMatrix {
        return AreaAcessMatrix(amusementAreas: true, kitchenAreas: false, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
    }
    
    func discountAccess() -> DiscountAccessMatrix {
        return DiscountAccessMatrix(foodPercentage: 0, merchPercentage: 0)
    }
    
    func rideAccess() -> RideAccessMatrix {
        return RideAccessMatrix(canRide: true, canSkip: false)
    }
}

struct VIPGuest: DailyGuestType {
    var type: TypeOfEntrant = .VIPGuest
    var personalInfo: PersonalInfo?
    
    func areaAccess() -> AreaAcessMatrix {
        return AreaAcessMatrix(amusementAreas: true, kitchenAreas: false, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
    }
    
    func discountAccess() -> DiscountAccessMatrix {
        return DiscountAccessMatrix(foodPercentage: 0.10, merchPercentage: 0.20)
    }
    
    func rideAccess() -> RideAccessMatrix {
        return RideAccessMatrix(canRide: true, canSkip: true)
    }
}

struct FreeChildGuest: DailyGuestType {
    var type: TypeOfEntrant = .FreeChildGuest
    var personalInfo: PersonalInfo?
    var birthdate: Date
    var currentDate: Date = Date()

    // Failable init to check the age of an attempted free child guest. Throws GuestTooOld is older than 5
    init?(birthdate: Date) throws {
        do {
            let lessThan5 = currentDate.isLessThan5YearsOld(birthdate: birthdate)
            
            if !lessThan5 {
                throw GuestErrors.GuestTooOld
            }
        } catch let error {
            print(error)
            return nil
        }
        
        self.birthdate = birthdate
    }
    
    func areaAccess() -> AreaAcessMatrix {
        return AreaAcessMatrix(amusementAreas: true, kitchenAreas: false, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
    }
    
    func discountAccess() -> DiscountAccessMatrix {
        return DiscountAccessMatrix(foodPercentage: 0, merchPercentage: 0)
    }
    
    func rideAccess() -> RideAccessMatrix {
        return RideAccessMatrix(canRide: true, canSkip: false)
    }
}

struct FoodServicesEmployee: HourlyEmployee {
    var type: TypeOfEntrant = .FoodServicesHourlyEmployee
    var personalInfo: PersonalInfo?
    
    init(info: PersonalInfo) {
        self.personalInfo = info
    }
    
    func areaAccess() -> AreaAcessMatrix {
        return AreaAcessMatrix(amusementAreas: true, kitchenAreas: true, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
    }
    
    func discountAccess() -> DiscountAccessMatrix {
        return DiscountAccessMatrix(foodPercentage: 0.15, merchPercentage: 0.25)
    }
    
    func rideAccess() -> RideAccessMatrix {
        return RideAccessMatrix(canRide: true, canSkip: false)
    }
}

struct RideServicesEmployee: HourlyEmployee {
    var type: TypeOfEntrant = .RideServicesHourlyEmployee
    var personalInfo: PersonalInfo?
    
    init(info: PersonalInfo) {
        self.personalInfo = info
    }
    
    func areaAccess() -> AreaAcessMatrix {
        return AreaAcessMatrix(amusementAreas: true, kitchenAreas: false, rideControlAreas: true, maintenanceAreas: false, officeAreas: false)
    }
    
    func discountAccess() -> DiscountAccessMatrix {
        return DiscountAccessMatrix(foodPercentage: 0.15, merchPercentage: 0.25)
    }
    
    func rideAccess() -> RideAccessMatrix {
        return RideAccessMatrix(canRide: true, canSkip: false)
    }
}

struct MaintenanceEmployee: HourlyEmployee {
    var type: TypeOfEntrant = .MaintenanceHourlyEmployee
    var personalInfo: PersonalInfo?
    
    init(info: PersonalInfo) {
        self.personalInfo = info
    }
    
    func areaAccess() -> AreaAcessMatrix {
        return AreaAcessMatrix(amusementAreas: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: true, officeAreas: false)
    }
    
    func discountAccess() -> DiscountAccessMatrix {
        return DiscountAccessMatrix(foodPercentage: 0.15, merchPercentage: 0.25)
    }
    
    func rideAccess() -> RideAccessMatrix {
        return RideAccessMatrix(canRide: true, canSkip: false)
    }
}

struct ManagerEmployee: SalariedEmployee {
    var type: TypeOfEntrant = .ManagerSalariedEmployee
    var personalInfo: PersonalInfo?
    
    init(info: PersonalInfo) {
        self.personalInfo = info
    }
    
    func areaAccess() -> AreaAcessMatrix {
        return AreaAcessMatrix(amusementAreas: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: true, officeAreas: true)
    }
    
    func discountAccess() -> DiscountAccessMatrix {
        return DiscountAccessMatrix(foodPercentage: 0.25, merchPercentage: 0.25)
    }
    
    func rideAccess() -> RideAccessMatrix {
        return RideAccessMatrix(canRide: true, canSkip: false)
    }
}

// MARK: Date extension for checking age for free guest passes

extension Date {
    // Check whether an entrant is under the age of 5
    func isLessThan5YearsOld(birthdate: Date) -> Bool {
        let yearsOld: Int = Calendar.current.dateComponents([.year], from: birthdate, to: self).year as Int!
        
        if yearsOld < 5 {
            return true
        } else {
            return false
        }
    }
    
    // Initializer to allow date init from a simple string
    init?(dateStringyyyyMMdd: String?) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        guard let ds = dateStringyyyyMMdd else {
            throw DateErrors.EmptyDateString
        }
        
        guard let bDay = dateFormatter.date(from: ds) else {
            throw DateErrors.InvalidDateFromString
        }
        
        self = bDay
    }
}
