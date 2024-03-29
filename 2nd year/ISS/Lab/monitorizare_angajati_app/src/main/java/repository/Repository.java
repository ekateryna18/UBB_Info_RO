package repository;

import model.Entity;

import java.io.Serial;
import java.io.Serializable;

public interface Repository<ID extends Serializable, E extends Entity<ID>> {
    E findOne(ID id);
    Iterable<E> findAll();
    void save(E entity);
    void delete(ID id);
    void update(E entity);
}
