sealed class Status {
  String message;
  Object data;

  Status({this.message = "", this.data = ""});
}

class Idle extends Status {
  Idle({super.message, super.data});
}

class Loading extends Status {
  Loading({super.message, super.data});
}

class Success extends Status {
  Success({super.message, super.data});
}

class Error extends Status {
  Error({super.message, super.data});
}
