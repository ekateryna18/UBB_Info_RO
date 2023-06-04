package model;

import jakarta.persistence.AttributeOverride;
import jakarta.persistence.Column;
import jakarta.persistence.Table;

@jakarta.persistence.Entity
@Table(name="sef")
//@AttributeOverride(name="id",column = @Column(name = "id"))
public class Sef extends Entity<Integer>{
    @Column(name="nume")
    private String nume;
    @Column(name="username")
    private String username;
    @Column(name="parola")
    private String parola;
    public Sef(){}
    public Sef(String nume, String username, String parola) {
        this.nume = nume;
        this.username = username;
        this.parola = parola;
    }

    public String getNume() {
        return nume;
    }

    public void setNume(String nume) {
        this.nume = nume;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getParola() {
        return parola;
    }

    public void setParola(String parola) {
        this.parola = parola;
    }
    @Override
    public String toString() {
        return "id:" + this.getID() + " username:" +this.getUsername();
    }
}
