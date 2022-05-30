package dao;

import java.io.Serializable;
import modelo.Value;

public class ValueDAO extends GenericDAO<Value, Serializable>{

    public ValueDAO() {
        super(Value.class);
    }  
}
