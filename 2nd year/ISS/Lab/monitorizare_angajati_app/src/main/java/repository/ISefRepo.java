package repository;

import model.Angajat;
import model.Sarcina;
import model.Sef;

public interface ISefRepo extends Repository<Integer, Sef>{
    Sef authentificate(String username, String password);
}
