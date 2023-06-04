package repository.jdbc;

import model.Admin;
import model.Angajat;
import model.Sarcina;
import model.StatusSarcina;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import repository.ISarcinaRepo;

import java.time.LocalDateTime;
import java.util.List;

public class SarciniDBRepo implements ISarcinaRepo{
    private static SessionFactory sessionFactory;

    public SarciniDBRepo(SessionFactory sessionFac) {
        sessionFactory=sessionFac;
    }

    @Override
    public Sarcina findOne(Integer integer) {
        return null;
    }

    @Override
    public Iterable<Sarcina> findAll() {
        try(Session session = sessionFactory.openSession()) {
            Transaction tx = null;
            try {
                tx = session.beginTransaction();
                List<Sarcina> sarcini = session.createQuery("from Sarcina s order by s.id desc",Sarcina.class).list();
                System.out.println(sarcini.size() + " sarcini found:");
                for (Sarcina s : sarcini) {
                    System.out.println(s.getDescriere() + ' ' + s.getID());
                }
                tx.commit();
                return sarcini;
            } catch (RuntimeException ex) {
                System.err.println("Eroare la select "+ex);
                if (tx != null)
                    tx.rollback();
                return null;
            }
        }
    }
    @Override
    public Iterable<Sarcina> findAllforAngajat(Integer id_angajat) {
        try(Session session = sessionFactory.openSession()) {
            Transaction tx = null;
            try {
                tx = session.beginTransaction();
                String queryString ="from Sarcina s where s.angajat.id = :id_param order by s.id desc";
                List<Sarcina> sarcini = session.createQuery(queryString,Sarcina.class).setParameter("id_param", id_angajat).list();
                System.out.println(sarcini.size() + " sarcini found:");
                for (Sarcina s : sarcini) {
                    System.out.println(s.getDescriere() + ' ' + s.getID());
                }
                tx.commit();
                return sarcini;
            } catch (RuntimeException ex) {
                System.err.println("Eroare la select "+ex);
                if (tx != null)
                    tx.rollback();
                return null;
            }
        }
    }
    @Override
    public void save(Sarcina entity) {
        try(Session session = sessionFactory.openSession()){
            Transaction tx=null;
            try{
                tx = session.beginTransaction();
                entity.setStatusSarcina(StatusSarcina.TRIMISA);
                entity.setID(99);
                session.save(entity);
                tx.commit();
            }catch(RuntimeException ex){
                if (tx!=null)
                    tx.rollback();
            }
        }
    }

    @Override
    public void delete(Integer integer) {
        try(Session session = sessionFactory.openSession()){
            Transaction tx=null;
            try{
                tx = session.beginTransaction();
                Sarcina sarcina = session.createQuery("from Sarcina s where s.id = :idparam",Sarcina.class).setParameter("idparam", integer).setMaxResults(1).uniqueResult();
                session.delete(sarcina);
                tx.commit();
            }catch(RuntimeException ex){
                if(tx!=null)
                    tx.rollback();
            }
        }
    }

    @Override
    public void update(Sarcina entity) {
        try(Session session = sessionFactory.openSession()){
            Transaction tx = null;
            try{
                tx=session.beginTransaction();
                Sarcina sarcina = (Sarcina) session.load(Sarcina.class, entity.getID());
                sarcina.setStatusSarcina(entity.getStatusSarcina());
                sarcina.setDescriere(entity.getDescriere());
                tx.commit();
            }catch(RuntimeException ex){
                if(tx!=null)
                    tx.rollback();
            }
        }
    }
}
