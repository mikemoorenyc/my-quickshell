
     function symbolFetch(id,isDay) {
       
    
    let string = "weather-XXX###";
    let symbol = ""
    let nontime = false;
    //NON DAY SPECIFIC
    if([56,57,66, 67].includes(id)) {
        return "rainy_snow"
        nontime =true
 
    }
    if([3].includes(id)) {
        return"cloud"
        nontime =true
  
    }
    if([51, 53, 55].includes(id)) {

     
       return "rainy_light"
        nontime =true
    }
    if([45, 48].includes(id)) {
        return"foggy"
       
    }
    if([63, 81].includes(id)) {
     
        return  "rainy"
        nontime =true
    }
    if([65, 82].includes(id)) {
     
        return "rainy_heavy"
        nontime =true
    }
    if([73].includes(id)) {
        return "snowing"
      
        nontime =true
    }
    if([76].includes(id)) {
        return "snowing_heavy"
      
        nontime =true
    }
    if([76].includes(id)) {
        return "snowflake"
      
        nontime =true
    }
    if([99].includes(id)) {
        nontime = true
       return "thunderstorm"
       
    }
    //TIME SPECIFIC
    //DAYTIME
    var day = isDay > 0
        if([0].includes(id)) {
          
        return day?"sunny":"bedtime"
        }
        if([61,80].includes(id)) {
         
            return "rainy_light"
        }
        if([1, 2,].includes(id)) {
   
            return day?"partly_cloudy_day":"partly_cloudy_night"
        }
        if([71,85].includes(id)) {
         
            return  day?"sunny_snowing":"weather_snowing"
        }
        if([96,95].includes(id)) {
      
           return "thunderstorm"
            
        }
    
  

   

    let dayString = isDay>0?"-day":"-night"
    if(nontime) {
        dayString=""
    }
    return string.replace("XXX",symbol).replace("###",dayString);
}
