#include <SPI.h>

// Pines de los botones
const int buttonPins[9] = {2,  3, 4, 5, 6, 7, 8, 9, 14};  
bool botonActual[9] = {LOW, LOW, LOW, LOW, LOW, LOW, LOW, LOW, LOW};
bool botonAnterior[9] = {LOW, LOW, LOW, LOW, LOW, LOW, LOW, LOW, LOW};

// Variables de control
bool modoDefinido = false;  // Se asegurará que el modo sólo se defina una vez
int modo = 0;               // 0 = número aleatorio, 1 = botones
int numeroAleatorio = 0;    // Número aleatorio generado

// Pines SPI
const int cs_pin = 10;

void setup() {
  // Configuración de los pines de entrada para los botones
  for (int i = 0; i < 9; i++) {
    pinMode(buttonPins[i], INPUT);
  }

  // Inicializar SPI y el monitor serie
  Serial.begin(9600);
  SPI.begin();

  pinMode(cs_pin, OUTPUT); // CS como salida
  digitalWrite(cs_pin, HIGH); // Mantener CS desactivado por defecto
  
  Serial.println("Esperando señal inicial de la FPGA para definir el modo...");
}

void loop() {
  // Comenzar transacción SPI
  SPI.beginTransaction(SPISettings(16000000, MSBFIRST, SPI_MODE0));
  digitalWrite(cs_pin, LOW); // Activar el esclavo (FPGA)

  // Si el modo no ha sido definido aún, esperar a la FPGA
  if (!modoDefinido) {
    byte recibido = SPI.transfer(0x00); // Recibir el primer byte de la FPGA
    if (recibido == 1) {
      modo = 1;  // Modo de botones
      modoDefinido = true;
      Serial.println("Modo de botones activado.");
    } else if (recibido == 0) {
      modo = 0;  // Modo de número aleatorio
      modoDefinido = true;
      Serial.println("Modo de generacion aleatoria activado.");
    }
  } else {
    // El modo ya está definido, operar según el modo
    if (modo == 1) {
      // Modo de botones
      for (int i = 0; i < 9; i++) {
        // Leer el estado actual del botón
        botonActual[i] = digitalRead(buttonPins[i]);

        // Detectar flanco ascendente
        if (botonActual[i] == HIGH && botonAnterior[i] == LOW) {
          Serial.print("Boton ");
          Serial.print(i + 1); // Imprimir el número de botón
          Serial.println(" presionado (Encendido)");

          // Enviar el número del botón presionado a la FPGA
          byte botonPresionado = i + 1; // El número del botón es i+1
          SPI.transfer(botonPresionado); // Enviar el número del botón a la FPGA

          // Leer respuesta de la FPGA
          byte respuesta = SPI.transfer(0x00);  // Recibir si es válido o no
          if (respuesta == 1) {
            Serial.println("Posición válida, continuar el juego.");
          } else if (respuesta == 0) {
            Serial.println("Posición inválida, presiona un botón de nuevo.");
          }
        }

        // Actualizar el estado anterior del botón
        botonAnterior[i] = botonActual[i];
      }
    } else if (modo == 0) {
      // Modo de número aleatorio
      if (numeroAleatorio == 0) {
        // Generar un número aleatorio entre 1 y 9
        numeroAleatorio = random(1, 10);
        Serial.print("Numero aleatorio generado: ");
        Serial.println(numeroAleatorio);

        // Enviar el número aleatorio a la FPGA
        SPI.transfer(numeroAleatorio);
      }

      // Leer respuesta de la FPGA
      byte respuesta = SPI.transfer(0x00);  // Recibir si es válido o no
      if (respuesta == 1) {
        Serial.println("Número aleatorio válido.");
        numeroAleatorio = 0;  // Resetear para generar un nuevo número si es necesario
      } else if (respuesta == 0) {
        Serial.println("Número aleatorio inválido, generando otro...");
        numeroAleatorio = random(1, 10);  // Generar otro número
        SPI.transfer(numeroAleatorio);    // Enviar el nuevo número
      }
    }
  }

  // Terminar la transacción SPI
  digitalWrite(cs_pin, HIGH); // Desactivar el esclavo
  SPI.endTransaction();

  delay(100);  // Pequeño retraso para evitar lecturas demasiado rápidas
}

