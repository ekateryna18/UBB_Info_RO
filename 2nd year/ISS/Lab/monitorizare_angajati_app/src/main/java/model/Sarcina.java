package model;

import jakarta.persistence.*;

import java.time.LocalDateTime;
@jakarta.persistence.Entity
@Table(name="sarcina")
@AttributeOverride(name="id",column = @Column(name = "id"))
public class Sarcina extends Entity<Integer>{
    @Column(name = "descriere")
    private String descriere;
    @ManyToOne
    @JoinColumn(name= "id_sef")
    //@MapsId("id")
    private Sef sef;
    //@ManyToOne(fetch = FetchType.LAZY)
    @ManyToOne
    @JoinColumn(name= "id_angajat")
    private Angajat angajat;
    @Enumerated(EnumType.STRING)
    @Column(name="status")
    private StatusSarcina statusSarcina;
    public Sarcina(){}

    public Sarcina(String descriere, Sef sef, Angajat angajat, StatusSarcina statusSarcina) {
        this.descriere = descriere;
        this.sef = sef;
        this.angajat = angajat;
        this.statusSarcina = statusSarcina;
    }
    @Column(name = "descriere")
    public String getDescriere() {
        return descriere;
    }

    public void setDescriere(String descriere) {
        this.descriere = descriere;
    }
    public Sef getSef() {
        return sef;
    }

    public void setSef(Sef sef) {
        this.sef = sef;
    }
    @Column(name = "id_angajat")
    public Angajat getAngajat() {
        return angajat;
    }

    public void setAngajat(Angajat angajat) {
        this.angajat = angajat;
    }

    public StatusSarcina getStatusSarcina() {
        return statusSarcina;
    }

    public void setStatusSarcina(StatusSarcina statusSarcina) {
        this.statusSarcina = statusSarcina;
    }
}
