package repository.jdbc;

import model.Angajat;
import model.Sef;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import repository.ISefRepo;

import java.util.List;

public class SefDBRepo implements ISefRepo {
    private static final Logger logger = LogManager.getLogger();
    private static SessionFactory sessionFactory;

    public SefDBRepo(SessionFactory sessionFac) {
        sessionFactory = sessionFac;
    }

    @Override
    public Sef authentificate(String username, String password) {
        logger.traceEntry("authentificating sef username {} ", username);
        try (Session session = sessionFactory.openSession()) {
            Transaction tx = null;
            try {
                tx = session.beginTransaction();
                String queryString = "From Sef s where s.username like :usernamepar";
                List<Sef> result = session.createQuery(queryString,Sef.class).setParameter("usernamepar", username).list();
                Sef sef = result.get(0);
                System.out.println(sef);
                tx.commit();
                if (sef.getParola().equals(password)) {

                    logger.info("Authentification successfull!");
                    return sef;
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
    public Sef findOne(Integer integer) {
        return null;
    }

    @Override
    public Iterable<Sef> findAll() {
        return null;
    }

    @Override
    public void save(Sef entity) {

    }

    @Override
    public void delete(Integer integer) {

    }

    @Override
    public void update(Sef entity) {

    }
}
