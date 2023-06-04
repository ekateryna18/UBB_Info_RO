package service;

import model.Admin;
import model.Angajat;
import model.Sarcina;
import model.Sef;
import repository.IAdminRepo;
import repository.IAngajatRepo;
import repository.ISarcinaRepo;
import repository.ISefRepo;

import java.util.ArrayList;
import java.util.List;

public class Service implements IService{
    private final IAngajatRepo angajatRepo;
    private final ISarcinaRepo sarcinaRepo;
    private final ISefRepo sefRepo;
    public Service(IAngajatRepo angajatRepo, ISarcinaRepo sarcinaRepo, ISefRepo sefRepo) {
        this.angajatRepo = angajatRepo;
        this.sarcinaRepo = sarcinaRepo;
        this.sefRepo = sefRepo;
    }

    public Angajat authentificate_angajat(String username, String password){
        return angajatRepo.authentificate(username, password);
    }
    public Sef authentificate_sef(String username, String password){
        return sefRepo.authentificate(username, password);
    }
    public List<Sarcina> getAllSarcina(){
        return (List<Sarcina>)sarcinaRepo.findAll();
    }
    public List<Angajat> getAngajatiActivi(){
        return (List<Angajat>)angajatRepo.findAll();
    }
    public void update_angajat_status(Angajat angajat){
        angajatRepo.update(angajat);
    }
    public void update_sarcina(Sarcina sarcina){
        sarcinaRepo.update(sarcina);
    }
    public List<Sarcina> getAllSarcinaForAngajat(Integer id_angajat){
        List<Sarcina> sarcini = (List<Sarcina>)sarcinaRepo.findAllforAngajat(id_angajat);
        return sarcini;
    }
    public void delete_sarcina(Sarcina sarcina){
        sarcinaRepo.delete(sarcina.getID());
    }
    public void trimite_sarcina(Sarcina sarcina){
        sarcinaRepo.save(sarcina);
    }
}
