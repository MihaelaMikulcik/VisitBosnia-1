import 'dart:convert';

import 'package:visit_bosnia_mobile/model/transactions/transaction.dart';
import 'package:visit_bosnia_mobile/model/transactions/transaction_insert_request.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/UserExceptionResponse.dart';

class TransactionProvider extends BaseProvider<Transaction> {
  TransactionProvider() : super("Transaction");

  @override
  Transaction fromJson(data) {
    // TODO: implement fromJson
    return Transaction.fromJson(data);
  }

  Future<dynamic> ProcessTransaction(TransactionInsertRequest request) async {
    var url = "${BaseProvider.baseUrl}Transaction/ProcessTransaction";
    var uri = Uri.parse(url);
    Map<String, String> headers = createHeaders();
    var jsonRequest = jsonEncode(request.toJson());

    var response = await http!.post(uri, headers: headers, body: jsonRequest);
    if (response.statusCode == 200) {
      return response.body;
      // return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return UserExceptionResponse.fromJson(json.decode(response.body));
    }
  }
}
