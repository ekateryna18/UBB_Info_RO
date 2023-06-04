package uiController;

import javafx.fxml.FXML;
import service.Service;

import java.awt.*;

public class AdminController {
    private Service srv;
    private String username;
    @FXML
    private Label usernameLabel;
    public void setService(Service srv, String username){
        this.srv = srv;
        //this.username = username;
        //usernameLabel.setText(this.username);
    }
}
