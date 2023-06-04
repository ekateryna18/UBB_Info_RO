package model;

import jakarta.persistence.*;

import java.time.LocalDateTime;
@jakarta.persistence.Entity
@Table(name="angajat")
@AttributeOverride(name="id", column = @Column(name="id"))
public class Angajat extends Entity<Integer>{
    @Column(name="nume")
    private String nume;
    @Column(name = "username")
    private String username;
    @Column(name="parola")
    private String parola;
    @Enumerated(EnumType.STRING)
    @Column(name="status")
    private StatusAngajat status;
    @Basic
    @Column(name="login_time")
    private LocalDateTime loginTime;
    public Angajat(){}
    public Angajat(String nume, String username, String parola, StatusAngajat status, LocalDateTime loginTime) {
        this.nume = nume;
        this.username = username;
        this.parola = parola;
        this.status = status;
        this.loginTime = loginTime;
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

    public StatusAngajat getStatus() {
        return status;
    }

    public void setStatus(StatusAngajat status) {
        this.status = status;
    }

    public LocalDateTime getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(LocalDateTime loginTime) {
        this.loginTime = loginTime;
    }
    @Override
    public String toString() {
        return this.getID().toString() +"," + this.getUsername()+ "," + this.getNume();
    }
}
