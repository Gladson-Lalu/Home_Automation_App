import 'package:dialog_flowtter/dialog_flowtter.dart';

class DialogflowService {
  late final DialogFlowtter _dialogFlowtter;
  static final DialogflowService _dialogflowService =
      DialogflowService._internal();
  DialogflowService._internal() {
    DialogAuthCredentials.fromFile(
            'assets/auth/dialog_flow_auth.json')
        .then((value) => _dialogFlowtter =
            DialogFlowtter(credentials: value));
  }

  factory DialogflowService() {
    return _dialogflowService;
  }

  Future<QueryResult> getIntent(String query) async {
    final DetectIntentResponse detectIntentResponse =
        await _dialogFlowtter.detectIntent(
            queryInput:
                QueryInput(text: TextInput(text: query)));
    if (detectIntentResponse.queryResult != null) {
      return detectIntentResponse.queryResult!;
    } else {
      throw Exception('No Result');
    }
  }

  //check if the query is a short talk

}
