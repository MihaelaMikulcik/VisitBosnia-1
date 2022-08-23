import 'package:visit_bosnia_mobile/model/eventOrder/event_order.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

class EventOrderProvider extends BaseProvider<EventOrder> {
  EventOrderProvider() : super("EventOrder");

  @override
  EventOrder fromJson(data) {
    // TODO: implement fromJson
    return EventOrder.fromJson(data);
  }
}
