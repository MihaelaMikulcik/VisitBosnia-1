import 'dart:convert';

import 'package:visit_bosnia_mobile/model/transactions/transaction.dart';
import 'package:visit_bosnia_mobile/model/transactions/transaction_insert_request.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

class TransactionProvider extends BaseProvider<Transaction> {
  TransactionProvider() : super("Transaction");

  @override
  Transaction fromJson(data) {
    // TODO: implement fromJson
    return Transaction.fromJson(data);
  }

  Future<dynamic> ProcessTransaction(TransactionInsertRequest request) async {
    var url = "https://10.0.2.2:44373/Transaction/ProcessTransaction";
    var uri = Uri.parse(url);
    Map<String, String> headers = createHeaders();
    var jsonRequest = jsonEncode(request.toJson());
    try {
      var response = await http!.post(uri, headers: headers, body: jsonRequest);
      if (isValidResponseCode(response)) {
        // var data = jsonDecode(response.body);
        return response.body;
        // return fromJson(data) as Transaction;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
