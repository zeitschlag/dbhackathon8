//
//  DataManager.swift
//  Wagenreihungsplan
//
//  Created by Nathan Mattes on 16.12.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import Foundation
import SWXMLHash

struct DataManager {
    var stations: [Station]
    
    init() {
        self.stations = [Station]()
    }
    
    mutating func readStationData() {
        // get list of files
        // read every file
        // create stations, tracks, trains, waggons...
        
        guard let listOfStationFiles = self.listOfStationFiles() else {
            fatalError("Check filepaths")
        }
        
        var tmpStations = [Station]()
        
        for stationFile in listOfStationFiles {
            // read XML-file
            let stationXML = SWXMLHash.parse(try! Data(contentsOf: stationFile))
            
            if let stationShortCode = stationXML["station"]["shortcode"].element?.text,
                let stationName = stationXML["station"]["name"].element?.text {
                
                let tracks = stationXML["station"]["tracks"].children
                
                var tmpTracks = [Track]()
                
                for track in tracks {
                    if let trackName = track["name"].element?.text,
                        let numberText = track["number"].element?.text,
                        let number = Int(numberText) {
                        
                        var tmpTrains = [Train]()
                        
                        let trains = track["trains"].children
                        
                        for train in trains {
                            
                            var tmpTrainNumbers = [Int]()
                            
                            let trainNumbers = train["trainNumbers"].children
                            for trainNumber in trainNumbers {
                                if let trainNumberText = trainNumber.element?.text, let trainNumberNumber = Int(trainNumberText) {
                                    tmpTrainNumbers.append(trainNumberNumber)
                                }
                            }
                            
                            var tmpWaggons = [Waggon]()
                            let waggons = train["waggons"].children
                            
                            for waggon in waggons {
                                if let waggonNumberText = waggon["number"].element?.text, let waggonNumber = Int(waggonNumberText) {
                                    var tmpWaggonSections = [String]()
                                    for section in waggon["sections"].children {
                                        if let sectionIdentifier = section.element?.text {
                                            tmpWaggonSections.append(sectionIdentifier)
                                        }
                                    }
                                    
                                    let newWaggon = Waggon(sections: tmpWaggonSections, number: waggonNumber)
                                    tmpWaggons.append(newWaggon)
                                }
                            }
                            
                            var tmpTrainTypes = [String]()
                            let trainTypes = train["traintypes"].children
                            for trainType in trainTypes {
                                if let trainTypeText = trainType.element?.text {
                                    tmpTrainTypes.append(trainTypeText)
                                }
                            }

                            
                            var tmpSubtrains = [Subtrain]()
                            let subtrains = train["subtrains"].children.enumerated()
                            
                            for (index, subtrain) in subtrains {
                                
                                var tmpSubtrainSection = [String]()
                                let subtrainSections = subtrain["sections"].children
                                for subtrainSection in subtrainSections {
                                    if let subtrainSectionIdentifier =  subtrainSection.element?.text {
                                        tmpSubtrainSection.append(subtrainSectionIdentifier)
                                    }
                                }
                                                                
                                let newSubtrain = Subtrain(trainNumber: tmpTrainNumbers[safe: index], trainType: tmpTrainTypes[safe: index], sections: tmpSubtrainSection)
                                tmpSubtrains.append(newSubtrain)
                            }
                            
                            
                            let newTrain = Train(subtrains: tmpSubtrains, waggons: tmpWaggons)
                            tmpTrains.append(newTrain)
                        }
                        
                        let newTrack = Track(name: trackName, number: number, trains: tmpTrains)
                        tmpTracks.append(newTrack)
                    }
                }
                
                let station = Station(shortCode: stationShortCode, name: stationName, tracks: tmpTracks)
                tmpStations.append(station)
                
            }
            
        }
        
        stations = tmpStations

    }
    
    func listOfStationFiles() -> [URL]? {
        return Bundle.main.urls(forResourcesWithExtension: "xml", subdirectory: nil)
    }
}
