package model;

import jakarta.persistence.Column;
import jakarta.persistence.Table;

@jakarta.persistence.Entity
@Table(name="admin")
public class Admin extends Entity<Integer>{
    private String nume;
    private String username;
    private String parola;
    public Admin(){}
    public Admin(String nume, String username, String parola) {
        this.nume = nume;
        this.username = username;
        this.parola = parola;
    }
    @Column(name = "nume")
    public String getName() {
        return nume;
    }

    public void setName(String nume) {
        this.nume = nume;
    }
    @Column(name="username")
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    @Column(name= "parola")
    public String getParola() {
        return parola;
    }

    public void setParola(String parola) {
        this.parola = parola;
    }
}
