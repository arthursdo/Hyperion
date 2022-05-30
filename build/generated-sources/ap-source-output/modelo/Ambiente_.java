package modelo;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Interruptor;
import modelo.Sensor;
import modelo.Usuario;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-07-09T13:36:52")
@StaticMetamodel(Ambiente.class)
public class Ambiente_ { 

    public static volatile SingularAttribute<Ambiente, Integer> idevr;
    public static volatile SingularAttribute<Ambiente, String> name;
    public static volatile ListAttribute<Ambiente, Sensor> sensorList;
    public static volatile ListAttribute<Ambiente, Interruptor> interruptorList;
    public static volatile SingularAttribute<Ambiente, Usuario> login;

}