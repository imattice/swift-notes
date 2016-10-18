import Foundation

//INIT WITH DEFAULT VALUES
struct RocketConfiguration {
    let name: String = "Athena 9 Heavy"
    let numberOfFirstStageCores: Int = 3
    let numberOfSecondStageCores: Int = 1
    let numberOfStageReuseLandingLegs: Int? = nil
}

let athena9Heavy = RocketConfiguration()




//INIT USING MEMBERWISE INITIALIZER
//    - initalizer is mirrored so that the parameters in any call must reflect the order that they are declared
//    - if a default value is declared in the struct, the initializer does not require that parameter in the call
//    - if you define another initalizer, you lose the memberwise initializer
//      - However, moving the initialzier to an extension of the struct will maintain the memberwise initializer

struct RocketStageConfiguration {
    let propellantMass: Double
    let liquidOxygenMass: Double
    let nominalBurnTime: Int
}
extension RocketStageConfiguration {
    init(propellantMass: Double, liquidOxygenMass: Double) {
        self.propellantMass = propellantMass
        self.liquidOxygenMass = liquidOxygenMass
        self.nominalBurnTime = 180
    }
}

let stageOneConfiguration = RocketStageConfiguration(propellantMass: 119.1, liquidOxygenMass: 276.0, nominalBurnTime: 500)
let stageTwoConfiguration = RocketStageConfiguration(propellantMass: 199.1, liquidOxygenMass: 436.7)




//INIT USING CUSTOM INITIALIZER
//    - You can calculate new values from other values used to construct an object

struct Weather {
    let temperatureCelsius: Double
    let windSpeedKilometersPerHour: Double

    init(temperatureFahrenheit: Double, windSpeedMilesPerHour: Double) {
        self.temperatureCelsius = (temperatureFahrenheit - 32) / 1.8
        self.windSpeedKilometersPerHour = windSpeedMilesPerHour * 1.609344
    }
}

let currentWeather = Weather(temperatureFahrenheit: 87, windSpeedMilesPerHour: 2)
    currentWeather.temperatureCelsius
    currentWeather.windSpeedKilometersPerHour




//INITIALIZER DELEGATION
//    - used if you need to make another initializer with a minor change.  By calling self.init, you can save yourself from repeating a lot of the code, almost like subclassing
//    - cannot initialize properties, needs to be declared in basic initializer

struct GuidanceSensorStatus {
    var currentZAngularVelocityRadiansPerMinute: Double
    let initalZAngularVelocityRadiansPerMinute: Double
    var needsCorrection: Bool
    //basic initializer
    init(zAngularVelocityDegreesPerMinute: Double, needsCorrection: Bool = false) {
        let radiansPerMinute = zAngularVelocityDegreesPerMinute * 0.01745329251994
        self.currentZAngularVelocityRadiansPerMinute = radiansPerMinute
        self.initalZAngularVelocityRadiansPerMinute = radiansPerMinute
        self.needsCorrection = needsCorrection
    }
    //initializer that takes an int for needsCorrection rather than a Bool, while maintaining the basic initializer
    init(zAngularVelocityDegreesPerMinute: Double, needsCorrection: Int) {
        //let radiansPerMinute = zAngularVelocityDegreesPerMinute * 0.01745329251994
        //self.currentZAngularVelocityRadiansPerMinute = radiansPerMinute
        //self.initalZAngularVelocityRadiansPerMinute = radiansPerMinute
        //self.needsCorrection = (needsCorrection > 0)
        self.init(zAngularVelocityDegreesPerMinute: zAngularVelocityDegreesPerMinute, needsCorrection: (needsCorrection > 0))
    }
}


let guidanceStatus = GuidanceSensorStatus (zAngularVelocityDegreesPerMinute: 4.4)
    guidanceStatus.currentZAngularVelocityRadiansPerMinute
    guidanceStatus.needsCorrection

let moarGuidanceStatus = GuidanceSensorStatus(zAngularVelocityDegreesPerMinute: 2.2, needsCorrection: 4)
    moarGuidanceStatus.currentZAngularVelocityRadiansPerMinute
    moarGuidanceStatus.needsCorrection





//TWO PHASE INITIALIZATION
//https://www.raywenderlich.com/119922/swift-tutorial-initialization-part-1

struct CombustionChamberStatus {
    var temperatureKelvin: Double
    var pressureKiloPascals: Double
    
    init(temperatureKelvin: Double, pressureKiloPascals: Double) {
        //print("Phase 1 init")
        self.temperatureKelvin = temperatureKelvin
        self.pressureKiloPascals = pressureKiloPascals
        //print("CombustionChamberStatus filly initialized")
        //print("Phase 2 init")
    }
    init(temperatureCelsius: Double, pressureAtmospheric: Double) {
        //print("Phase 1 delegating init")
        let temperatureKelvin = temperatureCelsius + 273.15
        let pressureKiloPascals = pressureAtmospheric * 101.325
        self.init(temperatureKelvin: temperatureKelvin, pressureKiloPascals: pressureKiloPascals)
        //print("Phase 2 delegating init")
    }
}

CombustionChamberStatus(temperatureCelsius: 32, pressureAtmospheric: 0.96)
//console: 
//  Phase 1 delegating init
//  Phase 1 init
//  CombustionChamberStatus filly initialized
//  Phase 2 init
//  Phase 2 delegating init





//FAILABLE INITIALIZERS
//  - returns optional values
//  - can return nil if the initialization fails

struct TankStatus {
    var currentVolume: Double
    var currentLiquidType: String?
    
    init?(currentVolume: Double, currentLiquidType: String?) {
        if (currentVolume < 0) || (currentVolume > 0 && currentLiquidType == nil) {
            return nil
        }
        self.currentVolume = currentVolume
        self.currentLiquidType = currentLiquidType
    }
}

if let tankStatus = TankStatus(currentVolume: -10.0, currentLiquidType: nil) {
    //print("Tank Status Created.")
} else {
    //print("An initialization failure has occurred")
}





//THROWING FROM AN INITIALIZER
enum InvalidAstronautDataError: Error {
    case EmptyName
    case InvalidAge
}
struct Astronaut {
    let name: String
    let age: Int
    
    init(name: String, age: Int) throws {
        if name.isEmpty {
            throw InvalidAstronautDataError.EmptyName
        }
        if age < 18 || age > 70 {
            throw InvalidAstronautDataError.InvalidAge
        }
        
        self.name = name
        self.age = age
    }
}

let johnny = try? Astronaut(name: "Johnny Cosmoseed", age: 17)


//https://www.raywenderlich.com/121603/swift-tutorial-initialization-part-2


























































