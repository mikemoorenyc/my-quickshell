
     function symbolFetch(id,isDay) {
    
    let string = "weather-XXX###";
    let symbol = ""
    let nontime = false;
    //NON DAY SPECIFIC
    if([56,57,66, 67].includes(id)) {
        symbol = "freezing-rain"
        nontime =true
 
    }
    if([3].includes(id)) {
        symbol = "cloudy"
        nontime =true
  
    }
    if([51, 53, 55].includes(id)) {

     
        symbol="drizzle"
        nontime =true
    }
    if([45, 48].includes(id)) {
        symbol = "fog"
       
    }
    if([63, 81].includes(id)) {
     
        symbol = "rain"
        nontime =true
    }
    if([65, 82].includes(id)) {
     
        symbol = "rain-heavy"
        nontime =true
    }
    if([73].includes(id)) {
        symbol="snow"
      
        nontime =true
    }
    if([76].includes(id)) {
        symbol="snow-heavy"
      
        nontime =true
    }
    if([76].includes(id)) {
        symbol="snowflake"
      
        nontime =true
    }
    if([99].includes(id)) {
        nontime = true
        symbol="thunderstorm"
       
    }
    //TIME SPECIFIC
    //DAYTIME
  
        if([0].includes(id)) {
          
        symbol="clear"
        }
        if([61,80].includes(id)) {
         
            symbol = "rain-light"
        }
        if([1, 2,].includes(id)) {
   
            symbol = "partly-cloudy"
        }
        if([71,85].includes(id)) {
         
            symbol = "snow-light"
        }
        if([96,95].includes(id)) {
      
            symbol="thunderstorm"
            
        }
    
  

   

    let dayString = isDay>0?"-day":"-night"
    if(nontime) {
        dayString=""
    }
    return string.replace("XXX",symbol).replace("###",dayString);
}
