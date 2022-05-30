package dao;

import java.io.Serializable;
import modelo.Sensor;

public class SensorDAO extends GenericDAO<Sensor, Serializable>{

    public SensorDAO() {
        super(Sensor.class);
    }    
}
