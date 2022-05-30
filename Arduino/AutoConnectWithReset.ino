#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <DNSServer.h>
#include <ESP8266WebServer.h>
#include <DHT.h>

ESP8266WebServer handle(80);

const char *ssid = "TCC";
const char *password = "tcc2018!@";

const String com = "http://hyperion.jelasticlw.com.br";

//id=porta A0
//dtt=DHT temperatura
//dth=dht umidade
//ciclos ate comitar os dados novamente
//tem= contagem atual de ciclos
//tp=tipo de dado a ser commitado

int id, dtt = 0, dth = 0, ciclos = 5000, tem = 0, tp = 0;
String login, key, ids;
String Leds = com + "/status.jsp?id=";

//bot=referencia ao id dos botoes no servidor
//ip=ip local usado para configuração

int bot[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
String ip;

void setup()
{
    Serial.begin(115200);
    WiFi.begin(ssid, password);
    Serial.print("Connecting");

    while (WiFi.status() != WL_CONNECTED)
    {
        Serial.print(".");
        delay(800);
    }

    Serial.println("connected...yeey :)");
    Serial.println("local ip");
    ip = WiFi.localIP().toString();
    Serial.println(ip);

    handle.on("/", graf);
    handle.begin();

    pinMode(A0, INPUT);
    pinMode(D0, OUTPUT);
    pinMode(D1, OUTPUT);
    pinMode(D2, OUTPUT);
    pinMode(D3, OUTPUT);
    pinMode(D4, OUTPUT);
    pinMode(D5, OUTPUT);
    pinMode(D6, OUTPUT);
    pinMode(D7, OUTPUT);
    pinMode(D8, OUTPUT);
}

void loop()
{
    Serial.println("-----------------");
    for (int i = 0; i < 9; i++)
    {
        Serial.print(bot[i]);
        Serial.print(",");
    }
    Serial.println();
    Serial.println(Leds);
    Serial.println("-----------------");
    if (WiFi.status() == WL_CONNECTED)
    {
        Serial.println("ok");
        HTTPClient led;
        for (int i = 0; i < 9; i++)
        {
            if (bot[i] > 0)
            {
                Serial.print("START ");
                led.begin(Leds + bot[i]);
                int code = led.GET();
                if (code > 0)
                {
                    String payload = led.getString();
                    Serial.println(payload);
                    if (payload == "\n\ntrue\n")
                    {
                        Serial.print("Pin ");
                        Serial.print(bot[i]);
                        Serial.print("true");
                        Serial.println();
                        toggleLed(bot[i], HIGH);
                    }
                    else
                    {
                        Serial.print("Pin ");
                        Serial.print(bot[i]);
                        Serial.print("false");
                        Serial.println();
                        toggleLed(bot[i], LOW);
                    }
                    led.end();
                }
            }
        }
        enviar();
        handle.handleClient();
    }

    else
    {
        Serial.println("ERRO");
    }
}

void graf()
{
    if (handle.arg("login") != '\0')
    {
        login = handle.arg("login");
        key = handle.arg("key");
    }
    if (handle.arg("upd").toInt() == 1)
    {
        ids = "";
        Serial.println("UPD");

        dtt = (handle.arg("dtt") != '\0') ? handle.arg("dtt").toInt() : dtt;
        dth = (handle.arg("dth") != '\0') ? handle.arg("dth").toInt() : dth;
        tp = (handle.arg("tp") != '\0') ? handle.arg("tp").toInt() : tp;
        id = (handle.arg("A0") != '\0') ? handle.arg("A0").toInt() : A0;
        bot[0] = (handle.arg("D0") != '\0') ? handle.arg("D0").toInt() : bot[0];
        bot[1] = (handle.arg("D1") != '\0') ? handle.arg("D1").toInt() : bot[1];
        bot[2] = (handle.arg("D2") != '\0') ? handle.arg("D2").toInt() : bot[2];
        bot[3] = (handle.arg("D3") != '\0') ? handle.arg("D3").toInt() : bot[3];
        bot[4] = (handle.arg("D4") != '\0') ? handle.arg("D4").toInt() : bot[4];
        bot[5] = (handle.arg("D5") != '\0') ? handle.arg("D5").toInt() : bot[5];
        bot[6] = (handle.arg("D6") != '\0') ? handle.arg("D6").toInt() : bot[6];
        bot[7] = (handle.arg("D7") != '\0') ? handle.arg("D7").toInt() : bot[7];
        bot[8] = (handle.arg("D8") != '\0') ? handle.arg("D8").toInt() : bot[8];
        ciclos = (handle.arg("cicl") != '\0') ? handle.arg("cicl").toInt() : ciclos;
        for (int i = 0; i < 9; i++)
        {
            ids = ids + "&D" + i + "=" + bot[i];
        }
        ids = ids + "&A0=" + id + "&cicl=" + ciclos + "&login=" + login + "&key=" + key + "&dth=" + dth + "&dtt=" + dtt;
    }
    String page = "<!DOCTYPE html><html><head><style>iframe {display: block;background: #000;border: none;height: 100vh;width: 100vw;}</style></head><body><iframe src=\"" + com + "/esp.jsp?ip=" + ip + ids + "\"></iframe></body></html>";
    handle.send(200, "text/html", page);
}

void toggleLed(int idb, uint8_t val)
{
    if (idb == bot[0])
    {
        digitalWrite(D0, val);
    }
    else if (idb == bot[1])
    {
        digitalWrite(D1, val);
    }
    else if (idb == bot[2])
    {
        digitalWrite(D2, val);
    }
    else if (idb == bot[3])
    {
        digitalWrite(D3, val);
    }
    else if (idb == bot[4])
    {
        digitalWrite(D4, val);
    }
    else if (idb == bot[5])
    {
        digitalWrite(D5, val);
    }
    else if (idb == bot[6])
    {
        digitalWrite(D6, val);
    }
    else if (idb == bot[7])
    {
        digitalWrite(D7, val);
    }
    else if (idb == bot[8])
    {
        digitalWrite(D8, val);
    }
}

void enviar()
{
    if (tem++ > ciclos)
    {
        String env = com + "/commit.jsp?log=" + login + "&key=" + key+"&val=";
        if (id>0)
        {
            tem = 0;
            int val = leitura();
            HTTPClient http;
            http.begin(env + val + "&sen="+id);

            int code = http.GET();

            if (code > 0)
            { //Check the returning code
                Serial.print("ENVIAR ");
                Serial.print(env + val + "&sen="+id);
                Serial.println();
                String payload = http.getString(); //Get the request response payload
                Serial.println(payload);           //Print the response payload
                http.end();
            }
        }
        if ((dth + dtt) > 0)
        {
            enviarDHT(env);
        }
    }
    else
    {
        return;
    }
}

float leitura()
{
    //leitura normal
    if (tp == 0)
    {
        return analogRead(A0);
    }
    //Porecentagem
    else if (tp == 1)
    {
        return map(analogRead(A0), 0, 1024, 0, 100);
    }
}

void enviarDHT(String link)
{
    int code;
    HTTPClient http;
    DHT dht(D0, DHT11);
    dht.begin();
    if (dtt > 0)
    {
        http.begin(link + dht.readTemperature()+ "&sen="+dtt);
        Serial.println(link + dht.readTemperature()+ "&sen="+dtt);
        code = http.GET();
        if (code > 0)
        {
            Serial.print("ENVIAR DHT");
            Serial.print("Temperature = ");
            Serial.print(dht.readTemperature());
            String payload = http.getString();
            Serial.println(payload);
            http.end();
        }
    }
    if (dth > 0)
    {
        http.begin(link + dht.readHumidity()+ "&sen="+dth);
        code = http.GET();
        if (code > 0)
        {
            Serial.print("Humidity = ");
            Serial.println(dht.readHumidity());
            Serial.println(link + dht.readTemperature()+ "&sen="+dth);
            String payload = http.getString();
            Serial.println(payload);
            http.end();
        }
    }
}
