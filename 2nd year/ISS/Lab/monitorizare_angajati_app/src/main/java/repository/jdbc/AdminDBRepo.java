package repository.jdbc;

import model.Admin;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import repository.IAdminRepo;

import java.util.List;

public class AdminDBRepo implements IAdminRepo {
    private static final Logger logger = LogManager.getLogger();
    private static SessionFactory sessionFactory;

    public AdminDBRepo(SessionFactory sessionFac){
        sessionFactory=sessionFac;
    }

    @Override
    public Admin authentificate(String username, String password) {
        logger.traceEntry("authentificating admin username {} ", username);
        try (Session session = sessionFactory.openSession()) {
            Transaction tx = null;
            try {
                tx = session.beginTransaction();
                String queryString = "From Admin a where a.username like :usernamepar";
                List<Admin> result = session.createQuery(queryString).setParameter("usernamepar", username).list();
                Admin adm = result.get(0);
                tx.commit();
                if (adm.getParola().equals(password)) {

                    logger.info("Authentification successfull!");
                    return adm;
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
    public Admin findOne(Integer integer) {
        return null;
    }

    @Override
    public Iterable<Admin> findAll() {
        return null;
    }

    @Override
    public void save(Admin entity) {

    }

    @Override
    public void delete(Integer integer) {

    }

    @Override
    public void update(Admin entity) {

    }
}
