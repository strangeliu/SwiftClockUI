import SwiftUI
import Combine

struct ArmView: View {
    @Environment(\.calendar) var calendar
    @Environment(\.clockDate) var date
    @Environment(\.clockStyle) var style
    let type: ArmType

    var body: some View {
        Group {
            if style == .artNouveau {
                ArtNouveauArm(type: self.type)
            } else if style == .drawing {
                DrawnArm(type: self.type)
            } else {
                ClassicArm(type: self.type)
            }
        }
        .modifier(ArmDragGesture(type: type))
        .rotationEffect(angle)
    }

    private var angle: Angle {
        switch type {
        case .hour: return .fromHour(date: date.wrappedValue, calendar: calendar)
        case .minute: return .fromMinute(date: date.wrappedValue, calendar: calendar)
        }
    }
}

#if DEBUG
struct ArmMinute_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .aspectRatio(1/1, contentMode: .fit)
        .padding()
        .environment(\.clockDate, .constant(.init(hour: 0, minute: 0, calendar: calendar)))
    }
}

struct ArmHour_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .hour)
        }
        .aspectRatio(1/1, contentMode: .fit)
        .padding()
        .environment(\.clockDate, .constant(.init(hour: 0, minute: 0, calendar: calendar)))
    }
}

struct ArmWith25MinuteAngle_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .aspectRatio(1/1, contentMode: .fit)
        .padding()
        .environment(\.clockDate, .constant(.init(hour: 0, minute: 25, calendar: calendar)))
    }
}

struct ArtNouveauDesignArm_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .aspectRatio(1/1, contentMode: .fit)
        .padding()
        .environment(\.clockDate, .constant(.init(hour: 0, minute: 0, calendar: calendar)))
        .environment(\.clockStyle, .artNouveau)
    }
}

struct DrawingDesignArm_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .aspectRatio(1/1, contentMode: .fit)
        .padding()
        .environment(\.clockDate, .constant(.init(hour: 0, minute: 0, calendar: calendar)))
        .environment(\.clockStyle, .drawing)
    }
}
#endif
