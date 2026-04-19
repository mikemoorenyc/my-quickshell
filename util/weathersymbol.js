
     function symbolFetch(id,isDay) {
       
    
    let string = "weather-XXX###";
    let symbol = ""
    let nontime = false;
    //NON DAY SPECIFIC
    if([3].includes(id)) {
        nontime=true
        symbol="cloudy"
    }
    if([45,48].includes(id)) {
        nontime=true
        symbol="fog"
    }
    if([51, 53, 55].includes(id)) {
        nontime = true
        symbol="drizzle"
    }
    if([56, 57,66, 67].includes(id)) {
        nontime=true
        symbol="freezing-rain"
    }
    if([63,81].includes(id)) {
        nontime=true
        symbol="rain"
    }
    if([65,82].includes(id)) {
        nontime=true
        symbol="rain-heavy"
    }
    if([73,86].includes(id)) {
        nontime=true
        symbol="snow"
    }
    if([75].includes(id)) {
        nontime=true
        symbol="snow-heavy"
    }
    if([77].includes(id)) {
        nontime=true
        symbol="snowflake"
    }
    if([95,96,99].includes(id)) {
        nontime=true
        symbol="thunderstorm"
    }

       
    
    //TIME SPECIFIC
    //DAYTIME
    var day = isDay > 0
        if([0].includes(id)) {
          
        symbol = "clear"
        }
        if([1].includes(id)) {
            symbol="partly-cloudy"
        }
        if([2].includes(id)) {
            symbol="mostly-cloudy"
        }
        
        if([61,80].includes(id)) {
            symbol="rain-light"
        }
        if([71,85].includes(id)) {
            symbol="snow-light"
        }
    
  

   

    let dayString = isDay>0?"-day":"-night"
    if(nontime) {
        dayString=""
    }
    return string.replace("XXX",symbol).replace("###",dayString);
}
