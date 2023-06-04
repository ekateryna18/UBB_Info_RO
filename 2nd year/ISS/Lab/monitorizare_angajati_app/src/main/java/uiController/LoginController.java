package uiController;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextField;
import javafx.scene.control.ToggleGroup;
import javafx.scene.paint.Paint;
import javafx.stage.Stage;
import model.Admin;
import model.Angajat;
import model.Sef;
import service.MyException;
import service.Service;

import java.io.IOException;

public class LoginController {
    @FXML
    private Label loginLabel;
    @FXML
    private TextField usernameField;
    @FXML
    private TextField passwordField;
    @FXML
    private ToggleGroup toggleGroup;
    @FXML
    private RadioButton adminRadioBtn;

    @FXML
    private RadioButton sefRadioBtn;
    @FXML
    private RadioButton angajatRadioBtn;

    private Service srv;
    Parent angajatParent;
    Parent sefParent;
    private Stage stage;
    private AngajatController angajatCtrl;
    private SefController sefController;
    public void setService(Service srv, Stage stage){
        this.srv = srv;
        this.stage = stage;
    }
    public void setParents(Parent angajatParent, Parent sefParent){
        this.angajatParent = angajatParent;
        this.sefParent = sefParent;
    }
    public void setControllers(AngajatController angajatController, SefController sefController){
        this.angajatCtrl = angajatController;
        this.sefController = sefController;
    }
    @FXML
    public void initialize() {
        adminRadioBtn.setToggleGroup(toggleGroup);
        adminRadioBtn.setSelected(true);
        sefRadioBtn.setToggleGroup(toggleGroup);
        angajatRadioBtn.setToggleGroup(toggleGroup);
    }
    public void login(ActionEvent event) throws IOException {
        String username = usernameField.getText();
        String password = passwordField.getText();
        String user_type = ((RadioButton)toggleGroup.getSelectedToggle()).getText();
        System.out.println(user_type);
        if(user_type.equals("Angajat")) {
            try {
                Angajat angajat = srv.authentificate_angajat(username, password);
                Stage stage = new Stage();
                stage.setTitle("Angajat: " + username);
                angajatCtrl.setService(srv, angajat,this.stage);
                stage.setScene(new Scene(angajatParent));
                stage.show();
                //((Node) (event.getSource())).getScene().getWindow().hide();
            } catch (Exception e) {
                loginLabel.setText("username or password incorrect");
                loginLabel.setTextFill(Paint.valueOf("red"));
            }
        }
        else if(user_type.equals("Sef")){
            try {
                Sef sef = srv.authentificate_sef(username, password);
                Stage stage = new Stage();
                stage.setTitle("Sef: " + username);
                sefController.setService(srv, sef);
                stage.setScene(new Scene(sefParent));
                stage.show();
                //((Node) (event.getSource())).getScene().getWindow().hide();
            } catch (Exception e) {
                loginLabel.setText("username or password incorrect");
                loginLabel.setTextFill(Paint.valueOf("red"));
            }
        }
    }

}
