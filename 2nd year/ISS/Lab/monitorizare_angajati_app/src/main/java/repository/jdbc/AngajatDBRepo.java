package repository.jdbc;

import model.Admin;
import model.Angajat;
import model.Sarcina;
import model.StatusAngajat;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import repository.IAngajatRepo;

import java.time.LocalDateTime;
import java.util.List;

public class AngajatDBRepo implements IAngajatRepo {
    private static final Logger logger = LogManager.getLogger();
    private static SessionFactory sessionFactory;

    public AngajatDBRepo(SessionFactory sessionFac) {
        sessionFactory = sessionFac;
    }

    @Override
    public Angajat authentificate(String username, String password) {
        logger.traceEntry("authentificating angajat username {} ", username);
        try (Session session = sessionFactory.openSession()) {
            Transaction tx = null;
            try {
                tx = session.beginTransaction();
                String queryString = "From Angajat a where a.username like :usernamepar";
                List<Angajat> result = session.createQuery(queryString,Angajat.class).setParameter("usernamepar", username).list();
                Angajat angajat = result.get(0);
                System.out.println(angajat);
                tx.commit();
                if (angajat.getParola().equals(password)) {

                    logger.info("Authentification successfull!");
                    return angajat;
                } else {
                    logger.info("Authentification failed!");
                    return null;
                }
            } catch (RuntimeException ex) {
                logger.error(ex);
                if (tx != null)
                    tx.rollback();
            }
        }
        return null;
    }

    @Override
    public Angajat findOne(Integer integer) {
        return null;
    }

    @Override
    public Iterable<Angajat> findAll() {
        try(Session session = sessionFactory.openSession()) {
            Transaction tx = null;
            try {
                tx = session.beginTransaction();
                String queryString ="from Angajat a where a.status = :statusparam";
                List<Angajat> angajati = session.createQuery(queryString,Angajat.class).setParameter("statusparam",StatusAngajat.ACTIV).list();
                System.out.println(angajati.size() + " angajati found:");
                for (Angajat a : angajati) {
                    System.out.println(a.getUsername() + ' ' + a.getID() + ' ' + a.getLoginTime());
                }
                tx.commit();
                return angajati;
            } catch (RuntimeException ex) {
                System.err.println("Eroare la select "+ex);
                if (tx != null)
                    tx.rollback();
                return null;
            }
        }
    }

    @Override
    public void save(Angajat entity) {

    }

    @Override
    public void delete(Integer integer) {

    }

    @Override
    public void update(Angajat entity) {
        try(Session session = sessionFactory.openSession()){
            Transaction tx = null;
            try{
                tx=session.beginTransaction();
                Angajat angajat = (Angajat) session.load(Angajat.class, entity.getID());
                angajat.setStatus(entity.getStatus());
                angajat.setLoginTime(LocalDateTime.now());
                tx.commit();
            }catch(RuntimeException ex){
                if(tx!=null)
                    tx.rollback();
            }
        }
    }
}
