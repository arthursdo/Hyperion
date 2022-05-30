/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author arthu
 */
@Entity
@Table(name = "value")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Value.findAll", query = "SELECT v FROM Value v")
    , @NamedQuery(name = "Value.findByIdval", query = "SELECT v FROM Value v WHERE v.idval = :idval")
    , @NamedQuery(name = "Value.findByValue", query = "SELECT v FROM Value v WHERE v.value = :value")
    , @NamedQuery(name = "Value.findByDate", query = "SELECT v FROM Value v WHERE v.date = :date")})
public class Value implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idval")
    private Integer idval;
    @Basic(optional = false)
    @Column(name = "value")
    private float value;
    @Basic(optional = false)
    @Column(name = "date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date date;
    @JoinColumn(name = "idsen", referencedColumnName = "idsen")
    @ManyToOne(optional = false)
    private Sensor idsen;

    public Value() {
    }

    public Value(Integer idval) {
        this.idval = idval;
    }

    public Value(Integer idval, float value, Date date) {
        this.idval = idval;
        this.value = value;
        this.date = date;
    }

    public Integer getIdval() {
        return idval;
    }

    public void setIdval(Integer idval) {
        this.idval = idval;
    }

    public float getValue() {
        return value;
    }

    public void setValue(float value) {
        this.value = value;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Sensor getIdsen() {
        return idsen;
    }

    public void setIdsen(Sensor idsen) {
        this.idsen = idsen;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idval != null ? idval.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Value)) {
            return false;
        }
        Value other = (Value) object;
        if ((this.idval == null && other.idval != null) || (this.idval != null && !this.idval.equals(other.idval))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.Value[ idval=" + idval + " ]";
    }
    
}
