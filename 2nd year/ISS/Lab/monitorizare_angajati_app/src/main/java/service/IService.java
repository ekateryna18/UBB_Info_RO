package service;

import model.Admin;
import model.Angajat;
import model.Sarcina;

import java.util.List;

public interface IService {
    Angajat authentificate_angajat(String username, String password);
    List<Sarcina> getAllSarcina();
    void update_angajat_status(Angajat angajat);
}
