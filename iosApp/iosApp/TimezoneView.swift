//
//  TimezoneView.swift
//  iosApp
//
//  Created by Miguel Susano on 13/10/2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

struct TimezoneView: View {
    // 1
    @EnvironmentObject private var timezoneItems: TimezoneItems
    // 2
    private var timezoneHelper = TimeZoneHelperImpl()
    // 3
    @State private var currentDate = Date()
    // 4
    let timer = Timer.publish(every: 1000, on: .main, in: .common).autoconnect()
    // 5
    @State private var showTimezoneDialog = false

    var body: some View {
        // 1
        NavigationView {
          // 2
          VStack {
            // 3
            TimeCard(timezone: timezoneHelper.currentTimeZone(),
                     time: DateFormatter.short.string(from: currentDate),
                     date: DateFormatter.long.string(from: currentDate))
            Spacer()
              // 1
              List {
                // 2
                ForEach(Array(timezoneItems.selectedTimezones), id: \.self) { timezone in
                  // 3
                  NumberTimeCard(timezone: timezone,
                                 time: timezoneHelper.getTime(timezoneId: timezone),
                                 hours: "\(timezoneHelper.hoursFromTimeZone(otherTimeZoneId: timezone)) hours from local",
                                 date: timezoneHelper.getDate(timezoneId: timezone))
                      .withListModifier()
                } // ForEach
                // 4
                .onDelete(perform: deleteItems)
              } // List
              // 5
              .listStyle(.plain)
              Spacer()

          } // VStack
          // 4
          .onReceive(timer) { input in
            currentDate = input
          }
          .navigationTitle("World Clocks")
            // 1
            .toolbar {
              // 2
              ToolbarItem(placement: .navigationBarTrailing) {
                // 3
                Button(action: {
                    showTimezoneDialog = true
                }) {
                    Image(systemName: "plus")
                        .frame(alignment: .trailing)
                        .foregroundColor(.black)
                }
              } // ToolbarItem
            } // toolbar

        } // NavigationView
        .fullScreenCover(isPresented: $showTimezoneDialog) {
          TimezoneDialog()
            .environmentObject(timezoneItems)
        }
    }
    func deleteItems(at offsets: IndexSet) {
        let timezoneArray = Array(timezoneItems.selectedTimezones)
        for index in offsets {
          let element = timezoneArray[index]
          timezoneItems.selectedTimezones.remove(element)
        }
    }

}

#Preview {
    TimezoneView()
}
