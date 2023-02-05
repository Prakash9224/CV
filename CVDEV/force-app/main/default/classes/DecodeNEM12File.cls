public class DecodeNEM12File implements Database.Batchable<Sobject>{
	
    public Database.QueryLocator start(Database.BatchableContext bc){
        String query;
        query='SELECT Id,VersionData from ContentVersion limit 1';
        return database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc,List<ContentVersion> atlist){
        if(atlist==null || (atlist!=null && atlist.isEmpty())){
            return;
        }
        try{
            String blobvalue;
         	ContentVersion at= new ContentVersion();
        	at=atlist[0];
            blobvalue = at.VersionData.toString();
            String[] splitString=blobvalue.split('\n200,');
            Map<String,String[]> nmap= new Map<String,String[]>();
            for(String s:splitString){
                if(nmap.containsKey(s.left(9))){
                  String[] tempAr = nmap.get(s.left(9));
                  tempAr.add(s);
                  nMap.put(s.left(9),tempAr);    
                }
                else{
                    if(!s.startsWith('100'))
                    nMap.put(s.left(9),new String[]{s.substring(11)});   
                }
            }
            for(String aa:nmap.keySet()){
                for(String bb:nmap.get(aa)){
                    if(bb.left(16)=='B1'){
                        
                    }
					                    
               }
                    
            }
            //String split=blobvalue.substringBetween('100','900');
            system.debug('splitString=='+splitString);
            system.debug('at'+at);
            system.debug('blobvalue'+blobvalue);
            
        }
        catch(Exception e){
            system.debug('Exception occured =='+e.getMessage());
            system.debug('Exception line =='+e.getLineNumber());
            system.debug('Exception cause =='+e.getCause());
        }
    }
    public void finish(Database.BatchableContext bc){
        
    }
}