/// The class created for storing the response from spitfire's backend; The server made
/// for connecting to OpenAI API. This class serves as a model for holding the
/// information returned from the backend. Whether it's an error or it's a message
/// responding to a particular query.
class OpenAIModel {
  /// The String variable to hold any kind of error the server sends back while
  /// trying to get a response to a query made by the developer/user of the app.
  final String error;

  /// The String variable to hold the response to the query sent provided the request
  /// was successful.
  final String message;

  /// Constructor for creating OpenAIModel object.
  /// This constructor takes two non-nullable arguments; [error] and [message].
  ///
  /// ```dart
  /// final model = OpenAIModel(error: "Some Error", message: "Some message");
  /// ```
  ///
  /// We call [model.error] to access the error stored within the object.
  /// We call [model.message] to access the message stored within the object.
  OpenAIModel({required this.error, required this.message});

  /// Convert the response of a request to OpenAIModel object using [json].
  /// The argument passed to this constructor must be a Map object so the body
  /// of the response must be decoded with [jsonDecode()] or [json.decode()].
  ///
  /// Example:
  /// ```dart
  /// final jsonResponse = jsonDecode(response.body); // Decodes the body
  ///
  /// // returns an OpenAIModel object
  /// OpenAIModel model = OpenAIModel.fromJson(jsonResponse);
  /// ```
  ///
  /// We are expecting [message] as the default; provided all goes well.
  OpenAIModel.fromJson(Map<String, dynamic> json)
      : error = json["error"] ?? "",
        message = json["message"];

  /// Convert our OpenAIModel object into a Map object that can be sent back to the
  /// server should we ever need to.
  ///
  /// Example:
  /// ```dart
  /// OpenAIModel model = OpenAIModel(error: "", message: "Sample Message");
  /// Map<String, dynamic> json = model.toJson();
  ///
  /// // The content of the json above is:
  /// //
  /// // {
  /// //  "error": "",
  /// //  "message": "Sample Message"
  /// // }
  /// ```
  ///
  /// Then the [json] can be used anywhere it's needed.
  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
      };
}
