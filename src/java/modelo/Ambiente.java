/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author arthur
 */
@Entity
@Table(name = "environment")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Ambiente.findAll", query = "SELECT a FROM Ambiente a")
    , @NamedQuery(name = "Ambiente.findByIdevr", query = "SELECT a FROM Ambiente a WHERE a.idevr = :idevr")
    , @NamedQuery(name = "Ambiente.findByName", query = "SELECT a FROM Ambiente a WHERE a.name = :name")})
public class Ambiente implements Serializable {

    @OneToMany(mappedBy = "idevr")
    private List<Interruptor> interruptorList;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idevr")
    private Integer idevr;
    @Basic(optional = false)
    @Column(name = "name")
    private String name;
    @JoinColumn(name = "login", referencedColumnName = "login")
    @ManyToOne(optional = false)
    private Usuario login;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idevr")
    private List<Sensor> sensorList;

    public Ambiente() {
    }

    public Ambiente(Integer idevr) {
        this.idevr = idevr;
    }

    public Ambiente(Integer idevr, String name) {
        this.idevr = idevr;
        this.name = name;
    }

    public Integer getIdevr() {
        return idevr;
    }

    public void setIdevr(Integer idevr) {
        this.idevr = idevr;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Usuario getLogin() {
        return login;
    }

    public void setLogin(Usuario login) {
        this.login = login;
    }

    @XmlTransient
    public List<Sensor> getSensorList() {
        return sensorList;
    }

    public void setSensorList(List<Sensor> sensorList) {
        this.sensorList = sensorList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idevr != null ? idevr.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Ambiente)) {
            return false;
        }
        Ambiente other = (Ambiente) object;
        if ((this.idevr == null && other.idevr != null) || (this.idevr != null && !this.idevr.equals(other.idevr))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.Ambiente[ idevr=" + idevr + " ]";
    }

    @XmlTransient
    public List<Interruptor> getInterruptorList() {
        return interruptorList;
    }

    public void setInterruptorList(List<Interruptor> interruptorList) {
        this.interruptorList = interruptorList;
    }
    
}
