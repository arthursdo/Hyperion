package modelo;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Sensor;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-07-09T13:36:52")
@StaticMetamodel(Value.class)
public class Value_ { 

    public static volatile SingularAttribute<Value, Integer> idval;
    public static volatile SingularAttribute<Value, Date> date;
    public static volatile SingularAttribute<Value, Sensor> idsen;
    public static volatile SingularAttribute<Value, Float> value;

}