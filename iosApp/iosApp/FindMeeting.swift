//
//  FindMeeting.swift
//  iosApp
//
//  Created by Miguel Susano on 13/10/2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

struct FindMeeting: View {
    // 1
    @EnvironmentObject private var timezoneItems: TimezoneItems
    // 2
    private var timezoneHelper = TimeZoneHelperImpl()
    // 3
    @State private var meetingHours: [Int] = []
    @State private var showHoursDialog = false
    // 4
    @State private var startDate = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
    @State private var endDate = Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: Date())!

    var body: some View {
        NavigationView {
          VStack {
            Spacer()
              .frame(height: 8)
              Form {
                Section(header: Text("Time Range")) {
                    // 1
                    DatePicker("Start Time", selection: $startDate, displayedComponents: .hourAndMinute)
                    // 2
                    DatePicker("End Time", selection: $endDate, displayedComponents: .hourAndMinute)
                }
                Section(header: Text("Time Zones")) {
                  // 3
                  ForEach(Array(timezoneItems.selectedTimezones), id: \.self) {  timezone in
                    HStack {
                      Text(timezone)
                      Spacer()
                    }
                  }
                }
              } // Form
              Spacer()
              Button(action: {
                // 1
                meetingHours.removeAll()
                // 2
                let startHour = Calendar.current.component(.hour, from: startDate)
                let endHour = Calendar.current.component(.hour, from: endDate)
                // 3
                let hours = timezoneHelper.search(
                  startHour: Int32(startHour),
                  endHour: Int32(endHour),
                  timezoneStrings: Array(timezoneItems.selectedTimezones))
                // 4
                let hourInts = hours.map { kotinHour in
                  Int(truncating: kotinHour)
                }
                meetingHours += hourInts
                // 5
                showHoursDialog = true
              }, label: {
                Text("Search")
                  .foregroundColor(Color.black)
              })
              Spacer()
                .frame(height: 8)


          } // VStack
          .navigationTitle("Find Meeting Time")
          .sheet(isPresented: $showHoursDialog) {
            HourSheet(hours: $meetingHours)
          }

        } // NavigationView
    }
}

#Preview {
    FindMeeting()
}
