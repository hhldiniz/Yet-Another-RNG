abstract class BaseDao<T> {
  insert(T model);
  update(T model, T newModel);
  delete(T model);
  Future<List<T>> query();
}