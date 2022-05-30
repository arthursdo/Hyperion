package dao;

import java.io.Serializable;
import modelo.Interruptor;

public class InterruptorDAO extends GenericDAO<Interruptor, Serializable>{    
    public InterruptorDAO(){
        super(Interruptor.class);
    }    
}
