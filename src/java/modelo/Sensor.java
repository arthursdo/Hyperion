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
@Table(name = "sensor")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Sensor.findAll", query = "SELECT s FROM Sensor s")
    , @NamedQuery(name = "Sensor.findByIdsen", query = "SELECT s FROM Sensor s WHERE s.idsen = :idsen")
    , @NamedQuery(name = "Sensor.findByName", query = "SELECT s FROM Sensor s WHERE s.name = :name")
    , @NamedQuery(name = "Sensor.findByModel", query = "SELECT s FROM Sensor s WHERE s.model = :model")})
public class Sensor implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idsen")
    private Integer idsen;
    @Basic(optional = false)
    @Column(name = "name")
    private String name;
    @Column(name = "model")
    private String model;
    @JoinColumn(name = "idevr", referencedColumnName = "idevr")
    @ManyToOne(optional = false)
    private Ambiente idevr;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idsen")
    private List<Value> valueList;

    public Sensor() {
    }

    public Sensor(Integer idsen) {
        this.idsen = idsen;
    }

    public Sensor(Integer idsen, String name) {
        this.idsen = idsen;
        this.name = name;
    }

    public Integer getIdsen() {
        return idsen;
    }

    public void setIdsen(Integer idsen) {
        this.idsen = idsen;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public Ambiente getIdevr() {
        return idevr;
    }

    public void setIdevr(Ambiente idevr) {
        this.idevr = idevr;
    }

    @XmlTransient
    public List<Value> getValueList() {
        return valueList;
    }

    public void setValueList(List<Value> valueList) {
        this.valueList = valueList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idsen != null ? idsen.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Sensor)) {
            return false;
        }
        Sensor other = (Sensor) object;
        if ((this.idsen == null && other.idsen != null) || (this.idsen != null && !this.idsen.equals(other.idsen))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.Sensor[ idsen=" + idsen + " ]";
    }
    
}
