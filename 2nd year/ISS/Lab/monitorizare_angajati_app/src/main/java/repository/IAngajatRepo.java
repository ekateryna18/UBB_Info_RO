package repository;

import model.Angajat;
import model.Sarcina;

public interface IAngajatRepo extends Repository<Integer, Angajat>{
    Angajat authentificate(String username, String password);
}
