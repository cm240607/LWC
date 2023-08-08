public class uploadCSVcontroller 
  {

    public Blob contentFile { get; set; }
    public String nameFile { get; set; }
    public Integer rowCount { get; set; }
    public Integer colCount { get; set; }
    
    public List<List<String>> getResults() 
    {
        List<List<String>> parsedCSV = new List<List<String>>();
        rowCount = 0;
        colCount = 0;
        if (contentFile != null)
        {
            String fileString = contentFile.toString();
            parsedCSV = parseCSV(fileString, False);
            rowCount = parsedCSV.size();
            for (List<String> row : parsedCSV)
            {
                if (row.size() > colCount)
                {
                    colCount = row.size();
                }
            }
        }
        return parsedCSV;
    }
    
    public Pagereference CreatePDF()
     {
      pagereference pr = new pagereference('/apex/FinalReport1');
      pr.setredirect(true);
      return pr;
     }
    
    public static List<List<String>> parseCSV(String contents,Boolean skipHeaders) 
     {
        List<List<String>> allFields = new List<List<String>>();
        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try 
        {
          lines = contents.split('\r'); // using carriage return accomodates windows, unix, and mac files
        }
        catch (System.ListException e) 
        {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        Integer num = 0;
        for(String line: lines) 
        {
           if (line.replaceAll(',','').trim().length() == 0) break;
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field: fields) 
            {
                if (field.startsWith('"') && field.endsWith('"')) 
                {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
                else if (field.startsWith('"')) 
                {
                    makeCompositeField = true;
                    compositeField = field;
                }
                else if (field.endsWith('"')) 
                {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                }
                else if (makeCompositeField) 
                {
                    compositeField +=  ',' + field;
                }
                else
                {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
            
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        return allFields;       
     }

}