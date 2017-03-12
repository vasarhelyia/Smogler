//
//  ComplicationController.swift
//  Smogler WatchKit Extension
//
//  Created by Vasarhelyi Agnes on 2017. 02. 19..
//  Copyright © 2017. vasarhelyia. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date())
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date())
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
		let template = CLKComplicationTemplateModularSmallStackText()
		let aqiLevel = AQILevelComplicationInfo.sharedInstance.level
		template.line1TextProvider = CLKSimpleTextProvider(text: aqiLevel.emoji)
		template.line2TextProvider = CLKSimpleTextProvider(text: aqiLevel.value < 0 ? "-" : "\(aqiLevel.value)")
		let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
		handler(entry)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
		let template = CLKComplicationTemplateModularSmallStackText()
		let aqiLevel = AQILevelComplicationInfo.sharedInstance.level
		template.line1TextProvider = CLKSimpleTextProvider(text: aqiLevel.emoji)
		template.line2TextProvider = CLKSimpleTextProvider(text: aqiLevel.value < 0 ? "-" : "\(aqiLevel.value)")
		handler(template)
    }
    
}
