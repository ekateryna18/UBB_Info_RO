package uiController;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;
import model.Angajat;
import model.Sarcina;
import model.Sef;
import model.StatusSarcina;
import service.Service;

public class SefController {
    @FXML
    private TableView<Sarcina> tableViewSarcini;
    @FXML
    private TableColumn<Sarcina,String> descrierieCol;
    @FXML
    private TableColumn<Sarcina,String> statusCol;
    @FXML
    private TableColumn<Sarcina,String> sefCol;
    ObservableList<Sarcina> modelSarcina = FXCollections.observableArrayList();
    @FXML
    private TableView<Angajat> tableViewAngajati;
    @FXML
    private TableColumn<Angajat,String> usernameCol;
    @FXML
    private TableColumn<Angajat,String> numeCol;
    @FXML
    private TableColumn<Angajat,String> timeCol;
    ObservableList<Angajat> modelAngajat = FXCollections.observableArrayList();
    @FXML
    private TextField descriereField;
    @FXML
    private TextField descrNouaField;
    @FXML
    private Label usernameLabel;
    private Service srv;
    private Sef sef;
    public void setService(Service srv, Sef sef){
        this.srv = srv;
        this.sef = sef;
        usernameLabel.setText(this.sef.getUsername());
        modelSarcina.setAll(srv.getAllSarcina());
        tableViewSarcini.setItems(modelSarcina);

        modelAngajat.setAll(srv.getAngajatiActivi());
        tableViewAngajati.setItems(modelAngajat);
    }
    @FXML
    public void initialize(){
        descrierieCol.setCellValueFactory(new PropertyValueFactory<Sarcina,String>("descriere"));
        statusCol.setCellValueFactory(new PropertyValueFactory<Sarcina,String>("statusSarcina"));
        sefCol.setCellValueFactory(new PropertyValueFactory<Sarcina,String>("angajat"));

        usernameCol.setCellValueFactory(new PropertyValueFactory<Angajat,String>("username"));
        numeCol.setCellValueFactory(new PropertyValueFactory<Angajat,String>("nume"));
        timeCol.setCellValueFactory(new PropertyValueFactory<Angajat,String>("loginTime"));
    }

    public void modifica_sarcina(ActionEvent event){
        String descrNoua = descrNouaField.getText();
        if(descrNoua != null)
        {
            Sarcina selected = (Sarcina)tableViewSarcini.getSelectionModel().getSelectedItem();
            if(selected.getStatusSarcina().equals(StatusSarcina.TRIMISA) || selected.getStatusSarcina().equals(StatusSarcina.MODIFICATA)){
                selected.setDescriere(descrNoua);
                srv.update_sarcina(selected);
                modelSarcina.setAll(srv.getAllSarcina());
                tableViewSarcini.setItems(modelSarcina);
                descrNouaField.clear();
                MessageAlert.showMessage(null, Alert.AlertType.INFORMATION,"Sarcina modificata","Sarcina modificata cu succes!");
            }else{
                MessageAlert.showErrorMessage(null, "Sarcina nu mai poate fi modificata!");
            }
            }else{
            MessageAlert.showErrorMessage(null, "Campul cu descrierea noua nu a fost completat");
        }
    }

    public void sterge_sarcina(ActionEvent event){
        Sarcina selected = (Sarcina)tableViewSarcini.getSelectionModel().getSelectedItem();
        if(selected.getStatusSarcina().equals(StatusSarcina.TRIMISA)){
            srv.delete_sarcina(selected);
            modelSarcina.setAll(srv.getAllSarcina());
            tableViewSarcini.setItems(modelSarcina);
            MessageAlert.showMessage(null, Alert.AlertType.INFORMATION,"Sarcina stearsa","Sarcina stearsa cu succes!");
        }else{
            MessageAlert.showErrorMessage(null, "Sarcina nu mai poate fi stearsa!");
        }
    }
    public void trimite_sarcina(ActionEvent event){
        Angajat selected = (Angajat)tableViewAngajati.getSelectionModel().getSelectedItem();
        System.out.println(selected);
        String text = descriereField.getText();
        try {
            Sarcina newSarc = new Sarcina(text, this.sef, selected, StatusSarcina.TRIMISA);
            System.out.println(newSarc);
            srv.trimite_sarcina(newSarc);
            modelSarcina.setAll(srv.getAllSarcina());
            tableViewSarcini.setItems(modelSarcina);
            descriereField.clear();
            MessageAlert.showMessage(null, Alert.AlertType.INFORMATION,"Sarcina adaugata","Sarcina adaugata cu succes!");
        }catch (Exception ex){
            MessageAlert.showErrorMessage(null, "Sarcina nu a fost trimisa!");
        }
    }

    public void refresh_for_sef(ActionEvent event){
        modelSarcina.setAll(srv.getAllSarcina());
        tableViewSarcini.setItems(modelSarcina);

        modelAngajat.setAll(srv.getAngajatiActivi());
        tableViewAngajati.setItems(modelAngajat);
    }
}
