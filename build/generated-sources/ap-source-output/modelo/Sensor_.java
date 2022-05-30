package modelo;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Ambiente;
import modelo.Value;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-07-09T13:36:52")
@StaticMetamodel(Sensor.class)
public class Sensor_ { 

    public static volatile SingularAttribute<Sensor, Ambiente> idevr;
    public static volatile SingularAttribute<Sensor, Integer> idsen;
    public static volatile ListAttribute<Sensor, Value> valueList;
    public static volatile SingularAttribute<Sensor, String> name;
    public static volatile SingularAttribute<Sensor, String> model;

}