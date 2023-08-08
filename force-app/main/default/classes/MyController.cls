Public Class MyController {
    Public String myString{
    get{
        if (myString==null){
        myString='a';
        }
    return myString;
    } private set;
    }
    public String getMyString(){
    return 'getMystring';
    }
    
    public String getStringMethod(){
        if(myString==null){
        myString='b';
        }
        return myString;
        }
    }