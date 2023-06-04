package uiController;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.Node;
import javafx.scene.control.Alert;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;
import model.Angajat;
import model.Sarcina;
import model.StatusAngajat;
import model.StatusSarcina;
import service.Service;

import java.io.IOException;


public class AngajatController {
    @FXML
    private Label usernameLabel;
    @FXML
    private Label activLabel;
    @FXML
    private TableView<Sarcina> tableViewSarcini;
    @FXML
    private TableColumn<Sarcina,String> descrierieCol;
    @FXML
    private TableColumn<Sarcina,String> statusCol;
    @FXML
    private TableColumn<Sarcina,String> sefCol;
    ObservableList<Sarcina> modelSarcina = FXCollections.observableArrayList();
    private Service srv;
    private Stage stage;
    private Angajat angajat;
    public void setService(Service srv, Angajat angajat, Stage stage){
        this.srv = srv;
        this.angajat = angajat;
        usernameLabel.setText(this.angajat.getUsername());
        this.stage = stage;
    }

    @FXML
    public void initialize(){
        descrierieCol.setCellValueFactory(new PropertyValueFactory<Sarcina,String>("descriere"));
        statusCol.setCellValueFactory(new PropertyValueFactory<Sarcina,String>("statusSarcina"));
        sefCol.setCellValueFactory(new PropertyValueFactory<Sarcina,String>("sef"));
    }

    public void pressPrezent(ActionEvent event) throws IOException {
        this.angajat.setStatus(StatusAngajat.ACTIV);
        srv.update_angajat_status(this.angajat);
        modelSarcina.setAll(srv.getAllSarcinaForAngajat(this.angajat.getID()));
        tableViewSarcini.setItems(modelSarcina);
    }
    public void logout(ActionEvent event) throws IOException{
        this.angajat.setStatus(StatusAngajat.INACTIV);
        srv.update_angajat_status(this.angajat);
        stage.show();
        ((Node) (event.getSource())).getScene().getWindow().hide();
    }
    public void prelucrareSarcina(ActionEvent event) throws IOException{
        Sarcina selected = (Sarcina) tableViewSarcini.getSelectionModel().getSelectedItem();
        if(selected != null && (selected.getStatusSarcina().equals(StatusSarcina.TRIMISA) ||
                selected.getStatusSarcina().equals(StatusSarcina.MODIFICATA))){
            selected.setStatusSarcina(StatusSarcina.PRELUATA);
            srv.update_sarcina(selected);
            modelSarcina.setAll(srv.getAllSarcinaForAngajat(this.angajat.getID()));
            tableViewSarcini.setItems(modelSarcina);
            MessageAlert.showMessage(null, Alert.AlertType.INFORMATION, "Sarcina preluata", "Sarcina preluata cu succes");
        }else MessageAlert.showErrorMessage(null, "Nu ati selectat nicio sarcina sau nu poate fi selectata!");
    }
    public void finalizareSarcina(ActionEvent even) throws IOException{
        Sarcina selected = (Sarcina) tableViewSarcini.getSelectionModel().getSelectedItem();
        if(selected != null && (selected.getStatusSarcina().equals(StatusSarcina.PRELUATA))){
            selected.setStatusSarcina(StatusSarcina.FINALIZATA);
            srv.update_sarcina(selected);
            modelSarcina.setAll(srv.getAllSarcinaForAngajat(this.angajat.getID()));
            tableViewSarcini.setItems(modelSarcina);
            MessageAlert.showMessage(null, Alert.AlertType.INFORMATION, "Sarcina finalizata", "Sarcina finalizata cu succes");
        }else MessageAlert.showErrorMessage(null, "Sarcina nu a fost preluata,nu poate fi finalizata!");
    }

    public void refresh_for_angajat(ActionEvent event){
        modelSarcina.setAll(srv.getAllSarcinaForAngajat(this.angajat.getID()));
        tableViewSarcini.setItems(modelSarcina);
    }
}
