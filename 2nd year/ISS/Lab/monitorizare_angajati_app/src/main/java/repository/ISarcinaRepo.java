package repository;

import model.Sarcina;

public interface ISarcinaRepo extends Repository<Integer, Sarcina>{
    Iterable<Sarcina> findAllforAngajat(Integer id_angajat);
}
