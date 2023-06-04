package uiController;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import model.Angajat;
import model.Sef;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import repository.jdbc.AdminDBRepo;
import repository.jdbc.AngajatDBRepo;
import repository.jdbc.SarciniDBRepo;
import repository.jdbc.SefDBRepo;
import service.Service;

import java.io.IOException;

public class StartApp extends Application{
    static SessionFactory sessionFactory;

    @Override
    public void start(Stage stage) throws IOException {
        initialize();
        SarciniDBRepo sarciniDBRepo = new SarciniDBRepo(sessionFactory);
        AngajatDBRepo angajatDBRepo = new AngajatDBRepo(sessionFactory);
        SefDBRepo sefDBRepo = new SefDBRepo(sessionFactory);
        Service service = new Service(angajatDBRepo, sarciniDBRepo, sefDBRepo);
        FXMLLoader loader = new FXMLLoader(getClass().getClassLoader().getResource("view/LoginView.fxml"));
        Parent root=loader.load();
        LoginController ctrl = loader.<LoginController>getController();
        stage.setTitle("MPP app");
        stage.setScene(new Scene(root));
        ctrl.setService(service,stage);

        FXMLLoader angajatLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/AngajatView.fxml"));
        Parent angajatroot=angajatLoader.load();
        AngajatController angajatCtrl = angajatLoader.<AngajatController>getController();
        angajatCtrl.setService(service, new Angajat(),stage);

        FXMLLoader sefLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/SefMainView.fxml"));
        Parent sefroot=sefLoader.load();
        SefController sefCtrl = sefLoader.<SefController>getController();
        sefCtrl.setService(service, new Sef(" "," "," "));

        ctrl.setControllers(angajatCtrl, sefCtrl);
        ctrl.setParents(angajatroot, sefroot);
        stage.show();

    }

    static void initialize() {
        // A SessionFactory is set up once for an application!
        final StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
        try {
            sessionFactory = new MetadataSources( registry ).buildMetadata().buildSessionFactory();
        }
        catch (Exception e) {
            System.err.println("Exception "+e);
            StandardServiceRegistryBuilder.destroy( registry );
        }
    }
    public static void main(String[] args) {
        launch();
    }
}
