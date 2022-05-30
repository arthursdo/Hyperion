package dao;

import java.io.Serializable;
import modelo.Ambiente;

public class SistemaDAO extends GenericDAO<Ambiente, Serializable> {

    public SistemaDAO() {
        super(Ambiente.class);
    }
}
