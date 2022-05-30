/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author arthur
 */
@Entity
@Table(name = "interruptor")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Interruptor.findAll", query = "SELECT i FROM Interruptor i")
    , @NamedQuery(name = "Interruptor.findByIdint", query = "SELECT i FROM Interruptor i WHERE i.idint = :idint")
    , @NamedQuery(name = "Interruptor.findByName", query = "SELECT i FROM Interruptor i WHERE i.name = :name")
    , @NamedQuery(name = "Interruptor.findByEstado", query = "SELECT i FROM Interruptor i WHERE i.estado = :estado")})
public class Interruptor implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idint")
    private Integer idint;
    @Column(name = "name")
    private String name;
    @Column(name = "estado")
    private Boolean estado;
    @JoinColumn(name = "idevr", referencedColumnName = "idevr")
    @ManyToOne
    private Ambiente idevr;

    public Interruptor() {
    }

    public Interruptor(Integer idint) {
        this.idint = idint;
    }

    public Integer getIdint() {
        return idint;
    }

    public void setIdint(Integer idint) {
        this.idint = idint;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getEstado() {
        return estado;
    }

    public void setEstado(Boolean estado) {
        this.estado = estado;
    }

    public Ambiente getIdevr() {
        return idevr;
    }

    public void setIdevr(Ambiente idevr) {
        this.idevr = idevr;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idint != null ? idint.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Interruptor)) {
            return false;
        }
        Interruptor other = (Interruptor) object;
        if ((this.idint == null && other.idint != null) || (this.idint != null && !this.idint.equals(other.idint))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.Interruptor[ idint=" + idint + " ]";
    }
    
}
