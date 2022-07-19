//
//  MiniStockWidget.swift
//  MiniStockWidget
//
//  Created by iMac on 2022/06/07.
//

import WidgetKit
import SwiftUI

@available(iOS 14.0, *)
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (SimpleEntry) -> Void
    ) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> Void
    ) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(
                byAdding: .hour,
                value: hourOffset,
                to: currentDate
            )!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(
            entries: entries,
            policy: .atEnd
        )
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

@available(iOS 14.0, *)
struct MiniStockWidgetEntryView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry

    var body: some View {
        sizeBody()
    }
    @ViewBuilder
    func sizeBody() -> some View {
        switch family {
        case .systemSmall:
            VStack {
                Text("small")
                Text(entry.date, style: .time)
            }
        case .systemMedium:
            VStack {
                Text("medium")
                Text(entry.date, style: .time)
            }
        case .systemLarge:
            VStack {
                Text("large")
                Text(entry.date, style: .time)
            }
        case .systemExtraLarge:
            VStack {
                Text("extraLarge")
                Text(entry.date, style: .time)
            }
        @unknown default:
            EmptyView()
        }
    }
}

@available(iOS 14.0, *)
@main
struct MiniStockWidget: Widget {
    let kind: String = "MiniStockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MiniStockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

@available(iOS 14.0, *)
struct MiniStockWidget_Previews: PreviewProvider {
    static var previews: some View {
        MiniStockWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
