

class EntireResult<T extends Object> {

  final String error;
  final T result;

  EntireResult(this.result,{this.error});
}