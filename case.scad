echo(version=version());


wand_staerke=6;
gehaeuse_breite = 125;
gehaeuse_laenge = 200;
gehaeuse_hoehe = 80;



//unterwand(gehaeuse_breite, gehaeuse_laenge, wand_staerke);

//hinterwand(gehaeuse_breite, gehaeuse_hoehe, wand_staerke);

// forderwand_oben(gehaeuse_breite, gehaeuse_hoehe, wand_staerke);
// forderwand_unten(gehaeuse_breite, gehaeuse_hoehe, gehaeuse_hoehe / 3.5, wand_staerke);
//forderwand(gehaeuse_breite, gehaeuse_hoehe, wand_staerke);

// unterteil(gehaeuse_breite, gehaeuse_laenge, gehaeuse_hoehe, wand_staerke);

// seite(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke);

//oberteil(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke);

//ansicht_zusammen(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke);

ansicht_druck(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke);


module ansicht_druck(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke){
  color("red")
    translate([0,0,gehaeuse_breite/2])
      rotate([0,90,0])
        unterteil(gehaeuse_breite, gehaeuse_laenge, gehaeuse_hoehe, wand_staerke);
    
  color("blue")
    translate([gehaeuse_breite / 2 + wand_staerke*3  ,gehaeuse_hoehe / 2,gehaeuse_laenge / 2])
      rotate([90,0,0])
        oberteil(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke);  
}


module ansicht_zusammen(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke){
  color("red")
    unterteil(gehaeuse_breite, gehaeuse_laenge, gehaeuse_hoehe, wand_staerke);
  color("blue")
    oberteil(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke);  
}


module oberteil(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke){
  difference(){
    hull(){
      translate([gehaeuse_breite / 2 + wand_staerke,0,0])
        seite(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke);

      mirror([1,0,0])
        translate([gehaeuse_breite / 2 + wand_staerke,0,0])
          seite(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke);
      
      dach(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke);
    }
    
    translate([0,0,-0.1])
      scale([1,2,1])
        hull(){
          unterteil(gehaeuse_breite, gehaeuse_laenge, gehaeuse_hoehe, wand_staerke);
        }
    
    // Loch 1
    scale([100,1,1])
      translate([-gehaeuse_breite / 2 +1, 0,0])      
        montage_hilfe_loch(gehaeuse_breite, gehaeuse_laenge, wand_staerke);
    
    // Loch 2
    mirror([0,1,0])
      scale([100,1,1])
        translate([-gehaeuse_breite / 2 +1, 0,0])      
          montage_hilfe_loch(gehaeuse_breite, gehaeuse_laenge, wand_staerke);
  }
}


module dach(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke){
  translate([0, -wand_staerke /2])
    difference(){
      resize([gehaeuse_breite, gehaeuse_laenge - wand_staerke, gehaeuse_hoehe + wand_staerke])
      hull(){
        unterteil(gehaeuse_breite, gehaeuse_laenge, gehaeuse_hoehe, wand_staerke);
      }
      translate([0,0,gehaeuse_hoehe/2])
        cube([
          gehaeuse_breite+1,
          gehaeuse_laenge +1,
          gehaeuse_hoehe+0.1,
        ], center = true);
    }
}


module seite(gehaeuse_laenge, gehaeuse_breite, gehaeuse_hoehe, wand_staerke){
  rotate([0,-90])
    translate([gehaeuse_hoehe / 2,0,0])
      difference(){
        translate([-gehaeuse_hoehe / 2 , 0, gehaeuse_breite / 2])  
          rotate([0,90,0])
            hull(){
              unterteil(gehaeuse_breite, gehaeuse_laenge, gehaeuse_hoehe, wand_staerke);
            }
        translate([0,0,gehaeuse_breite / 2 + wand_staerke])
          cube([
                gehaeuse_hoehe +1,
                gehaeuse_laenge +1,
                gehaeuse_breite, 
               ], center = true);
      }
}

module forderwand_oben(gehaeuse_breite, gehaeuse_hoehe, wand_staerke){
  display_position_y = gehaeuse_hoehe / 7;
  knopf_position_y = -gehaeuse_hoehe / 3.5;
  knopf_position_x = gehaeuse_breite / 3.5;
  
  rotate([90,0,0])
    translate([0,gehaeuse_hoehe / 2, 0])
      union(){
        difference(){
          cube([
              gehaeuse_breite,
              gehaeuse_hoehe,
              wand_staerke, 
              ], center = true);
          
          translate([0, display_position_y, 0])
            display(wand_staerke+1);
          
          translate([knopf_position_x, knopf_position_y, 0 ])
             knopf(wand_staerke+1);
          
          translate([0, knopf_position_y, 0 ])
            knopf(wand_staerke+1);
          
          translate([-knopf_position_x, knopf_position_y, 0 ])
             knopf(wand_staerke+1);
        }
      }
}

module forderwand_unten(gehaeuse_breite, gehaeuse_hoehe, forderwand_hoehe, wand_staerke){
  rotate([90,0,0])
    translate([0,forderwand_hoehe / 2, 0])
      cube([
        gehaeuse_breite,
        forderwand_hoehe,
        wand_staerke
        ], center = true);
}



module forderwand(gehaeuse_breite, gehaeuse_hoehe, wand_staerke){
  forderwand_hoehe = gehaeuse_hoehe / 3.5;
  union(){
    forderwand_unten(gehaeuse_breite, gehaeuse_hoehe, forderwand_hoehe, wand_staerke);
    translate([0,0,forderwand_hoehe])
      rotate([0,90,0])
        cylinder(gehaeuse_breite, wand_staerke/2, wand_staerke/2, center= true);
    translate([0, 0, forderwand_hoehe])
      rotate([40,0,0])  
        forderwand_oben(gehaeuse_breite, gehaeuse_hoehe, wand_staerke);
  }
}

module hinterwand(gehaeuse_breite, gehaeuse_hoehe, wand_staerke) {
  translate([0,0,gehaeuse_hoehe/2])
    rotate([90,0,0])
      cube([
        gehaeuse_breite,
        gehaeuse_hoehe,
        wand_staerke,
        ], center = true);
}

module unterwand(gehaeuse_breite, gehaeuse_laenge, wand_staerke){
  
  cube([
    gehaeuse_breite,
    gehaeuse_laenge,
    wand_staerke
    ], center = true);
    
  montage_hilfe(gehaeuse_breite, gehaeuse_laenge, wand_staerke);
  mirror([1,0,0])
    montage_hilfe(gehaeuse_breite, gehaeuse_laenge, wand_staerke);
  mirror([0,1,0])
    montage_hilfe(gehaeuse_breite, gehaeuse_laenge, wand_staerke);  
  mirror([0,1,0])
    mirror([1,0,0])
    montage_hilfe(gehaeuse_breite, gehaeuse_laenge, wand_staerke);
}

module unterteil(gehaeuse_breite, gehaeuse_laenge, gehaeuse_hoehe, wand_staerke){ 
  difference(){
    union(){
      translate([0,0,wand_staerke/2])
        unterwand(gehaeuse_breite, gehaeuse_laenge, wand_staerke);
      
      translate([0, -(gehaeuse_laenge - wand_staerke) / 2, 0 ])
        hinterwand(gehaeuse_breite, gehaeuse_hoehe, wand_staerke);
      
      translate([0, (gehaeuse_laenge - wand_staerke) / 2, 0])
        forderwand(gehaeuse_breite, gehaeuse_hoehe, wand_staerke);
    }    
    
    translate([0,0,wand_staerke*4 + gehaeuse_hoehe])
      cube([
        gehaeuse_breite + 1,
        gehaeuse_laenge + 1,
        wand_staerke *8
        ], center= true
      );
  }
}

module montage_hilfe(gehaeuse_breite, gehaeuse_laenge, wand_staerke){
  montage_groesse = gehaeuse_laenge / 10;
  difference(){
    translate([(gehaeuse_breite - wand_staerke) / 2, (gehaeuse_laenge - montage_groesse ) / 2 - wand_staerke , (montage_groesse + wand_staerke) / 2 ])
      rotate([0,90,0])
        cube([
          montage_groesse,
          montage_groesse,
          wand_staerke
          ], center = true);
    montage_hilfe_loch(gehaeuse_breite, gehaeuse_laenge, wand_staerke);
  }
}

module montage_hilfe_loch(gehaeuse_breite, gehaeuse_laenge, wand_staerke){
  loch_radius = 2.5;
  montage_groesse = gehaeuse_laenge / 10;
  translate([(gehaeuse_breite - wand_staerke) / 2, (gehaeuse_laenge - montage_groesse ) / 2 - wand_staerke , (montage_groesse + wand_staerke) / 2 ])
    rotate([0,90,0])
      cylinder(
        wand_staerke +1, 
        loch_radius, 
        loch_radius, 
        center=true);      
}

module display(wand_staerke){
  display_breite = 70;
  display_hoehe = 30;
  
  cube([
    display_breite,
    display_hoehe,
    wand_staerke,         
    ], center = true);
}

module knopf(wand_staerke){  
  knopf_radius = 8;
  cylinder(
    wand_staerke, 
    knopf_radius, 
    knopf_radius, 
    center=true);
}