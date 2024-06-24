import processing.serial.*;
import controlP5.*;

Serial port;  // Objek Serial untuk komunikasi serial

String selectedPort;

boolean isConnected = false;
int baudRate = 115200;
int N_Anchor;

ControlP5 cp5;

void serialSetup(){
  // Membuat objek ControlP5
  cp5 = new ControlP5(this);

  // Menambahkan tombol Connect
  cp5.addButton("Connect")
     .setPosition(30, 70)
     .setSize(80, 20)
     .setLabel("Connect");

  // Menambahkan tombol Disconnect
  cp5.addButton("Disconnect")
     .setPosition(130, 70)
     .setSize(80, 20)
     .setLabel("Disconnect");

  // Menambahkan Combo Box untuk memilih port serial
  cp5.addDropdownList("PortList")
     .setPosition(30, 40)
     .setSize(300, 300)
     .setCaptionLabel("Select Serial Port")
     .setBarHeight(20)
     .setColorBackground(color(60))
     .setColorActive(color(255, 128))
     .setColorForeground(color(255))
     .addItem("Select Port", 0);
     
  // Tampilkan daftar port
  String[] ports = Serial.list();
  for (String p : ports) {
    cp5.get(DropdownList.class, "PortList").addItem(p, 1);
  }
}


void serialEvent(Serial port) {
  String data = port.readStringUntil('\n');
  if (data != null) {
    data = data.trim();
    // Proses data yang diterima dari serial
    String[] coordinates = split(data, ',');
    
    N_Anchor = int(coordinates[0]);
    if (coordinates.length > 2) { 
      
      for (int i = 0; i <= N_Anchor; i++) {
        anchorX[i] = float(coordinates[i+1]);
        anchorY[i] = float(coordinates[(i+1) + N_Anchor]);         
      }
    } 
    else if(coordinates.length == 2) {
      tagX = float(coordinates[0]);
      tagY = float(coordinates[1]); 
    }else{
      println("Invalid data format");
    }
  }
}

void controlEvent(ControlEvent event) {
    if (event.isFrom("PortList")) {
    int selectedIdx = int(event.getValue());
    if (selectedIdx > 0) {
      // Port yang dipilih
      selectedPort = Serial.list()[selectedIdx - 1];
      println("Selected Port: " + selectedPort);
    }
  } else if (event.isFrom("Connect")) {
    // Coba membuat koneksi
    if (selectedPort != null) {
      port = new Serial(this, selectedPort, baudRate);
      port.bufferUntil('\n');
      isConnected = true;
      println("Connected to " + selectedPort);
    } else {
      println("Select a port first.");
    }
  } else if (event.isFrom("Disconnect")) {
    // Tutup koneksi
    if (port != null) {
      port.stop();
      isConnected = false;
      println("Disconnected");
    }
  }
}
