// Variables de los pines de los botones
const int buttonPins[9] = {2,  3, 4, 5, 6, 7, 8, 9, 10};//{10, 9, 8, 7, 6, 5, 4, 3, 2};  // El pin 10 será el botón 1, el pin 9 será el botón 2, etc.

// Variables para el estado de los botones
bool botonActual[9] = {LOW, LOW, LOW, LOW, LOW, LOW, LOW, LOW, LOW};
bool botonAnterior[9] = {LOW, LOW, LOW, LOW, LOW, LOW, LOW, LOW, LOW};

int modo = 1;  // Variable para el modo de operación, inicia en modo de botones

void setup() {
  // Configuración de los pines de entrada
  for (int i = 0; i < 9; i++) {
    pinMode(buttonPins[i], INPUT); // Configurar cada pin del botón como entrada
  }

  // Inicializar el monitor serie
  Serial.begin(9600);
  
  // Mostrar instrucciones iniciales
  Serial.println("Ingresa 1 para detectar botones o 0 para generar un numero aleatorio.");
}

void loop() {
  // Verificar si se ha recibido algo por el monitor serial
  if (Serial.available() > 0) {
    char input = Serial.read(); // Leer el valor ingresado
    if (input == '1') {
      modo = 1; // Cambiar a modo de detección de botones
      Serial.println("Modo de detección de botones activado.");
    } 
    else if (input == '0') {
      modo = 0; // Cambiar a modo de número aleatorio
      Serial.println("Modo de generacion aleatoria activado.");
      int numeroAleatorio = random(1, 10);  // Generar un número aleatorio entre 1 y 9
      Serial.print("Numero aleatorio generado: ");
      Serial.println(numeroAleatorio);
      
      // Después de generar el número aleatorio, volver a pedir la entrada de modo
      Serial.println("Ingresa 1 para detectar botones o 0 para generar otro número aleatorio.");
    }
  }

  // Si el modo es 1, proceder a detectar botones
  if (modo == 1) {
    // Iterar sobre todos los botones
    for (int i = 0; i < 9; i++) {
      // Leer el estado actual del botón
      botonActual[i] = digitalRead(buttonPins[i]);

      // Detectar si hubo un cambio de estado de LOW a HIGH (flanco ascendente)
      if (botonActual[i] == HIGH && botonAnterior[i] == LOW) {
        Serial.print("Boton ");
        Serial.print(i + 1); // Imprimir el número de botón según el índice del arreglo
        Serial.println(" presionado (Encendido)");
      }

      // Detectar si hubo un cambio de estado de HIGH a LOW (flanco descendente)
      if (botonActual[i] == LOW && botonAnterior[i] == HIGH) {
        Serial.print("Boton ");
        Serial.print(i + 1); // Imprimir el número de botón según el índice del arreglo
        Serial.println(" liberado (Apagado)");
      }

      // Actualizar el estado anterior del botón
      botonAnterior[i] = botonActual[i];
    }
  }
}
