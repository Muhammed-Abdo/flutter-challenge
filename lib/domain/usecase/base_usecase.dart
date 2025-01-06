abstract class BaseUsecase<In, Out> {
  Future<List<Out>> execute(In input);
}
