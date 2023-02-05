public class DecodeNEM12File1 implements Database.Batchable<Sobject>{
    
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
            List<Customer_Reading__c> cusReading = new List<Customer_Reading__c>();
            Map<String,String[]> customerMap = new Map<String,String[]>();
            for(String s:splitString){
                if(customerMap.containsKey(s.left(10))){
                    String[] tempAr = customerMap.get(s.left(10));
                    tempAr.add(s);
                    customerMap.put(s.left(10),tempAr);    
                }
                else{
                    if(!s.startsWith('100'))
                        customerMap.put(s.left(10),new String[]{s});   
                }
            }
            For(String customerId: customerMap.keySet()){
                for(String genOrConsum: customerMap.get(customerId)){
                    System.debug('list---->'+genOrConsum);
                    if(genOrConsum.split(',')[3] == 'B1'){
                        System.debug('genOrConsum---->'+genOrConsum);
                        cusReading.addAll(createReading(genOrConsum,true,customerId));
                    }else if(genOrConsum.split(',')[3] == 'E1'){
                        System.debug('Consum---->'+genOrConsum);
                        cusReading.addAll(createReading(genOrConsum,false,customerId));
                    }
                } 
                
            }
            //insert cusReading;
        }
        catch(Exception e){
            system.debug('Exception occured =='+e.getMessage());
            system.debug('Exception line =='+e.getLineNumber());
            system.debug('Exception cause =='+e.getCause());
        }
    }
    
    public List<Customer_Reading__c> createReading(String genOrConsum, Boolean isGeneration,String customerId){
        
        List<Customer_Reading__c> readingList = new List<Customer_Reading__c>();
        for(String dailydata : genOrConsum.split('\n')){           
            Customer_Reading__c cr = new Customer_Reading__c();
            cr.Customer_Id__c=customerId;
            System.debug('isGeneration'+isGeneration);
            cr.reading_type__c=isGeneration?'Generation':'Consumption';
            
            System.debug('reading_type__c'+cr.reading_type__c);
            if(dailydata.startsWith('300')){
                String[] crData=dailydata.split(',');
                //System.debug('crData--->'+crData);
                cr.start_date__c=Date.newInstance(Integer.valueOf(crData[1].left(4)),Integer.valueOf(crData[1].mid(4,2)), Integer.valueOf(crData[1].right(2)));
                cr.Reading_1__c=Decimal.valueOf(crData[2]);
                cr.Reading_2__c=Decimal.valueOf(crData[3]);
                cr.Reading_3__c=Decimal.valueOf(crData[4]);
                cr.Reading_4__c=Decimal.valueOf(crData[5]);
                cr.Reading_5__c=Decimal.valueOf(crData[6]);
                cr.Reading_6__c=Decimal.valueOf(crData[7]);
                cr.Reading_7__c=Decimal.valueOf(crData[8]);
                cr.Reading_8__c=Decimal.valueOf(crData[9]);
                cr.Reading_9__c=Decimal.valueOf(crData[10]);
                cr.Reading_10__c=Decimal.valueOf(crData[11]);
                cr.Reading_11__c=Decimal.valueOf(crData[12]);
                cr.Reading_12__c=Decimal.valueOf(crData[13]);
                cr.Reading_13__c=Decimal.valueOf(crData[14]);
                cr.Reading_14__c=Decimal.valueOf(crData[15]);
                cr.Reading_15__c=Decimal.valueOf(crData[16]);
                cr.Reading_16__c=Decimal.valueOf(crData[17]);
                cr.Reading_17__c=Decimal.valueOf(crData[18]);
                cr.Reading_18__c=Decimal.valueOf(crData[19]);
                cr.Reading_19__c=Decimal.valueOf(crData[20]);
                cr.Reading_20__c=Decimal.valueOf(crData[21]);
                cr.Reading_21__c=Decimal.valueOf(crData[22]);
                cr.Reading_22__c=Decimal.valueOf(crData[23]);
                cr.Reading_23__c=Decimal.valueOf(crData[24]);
                cr.Reading_24__c=Decimal.valueOf(crData[25]);
                cr.Reading_25__c=Decimal.valueOf(crData[26]);
                cr.Reading_26__c=Decimal.valueOf(crData[27]);
                cr.Reading_27__c=Decimal.valueOf(crData[28]);
                cr.Reading_28__c=Decimal.valueOf(crData[29]);
                cr.Reading_29__c=Decimal.valueOf(crData[30]);
                cr.Reading_30__c=Decimal.valueOf(crData[31]);
                cr.Reading_31__c=Decimal.valueOf(crData[32]);
                cr.Reading_32__c=Decimal.valueOf(crData[33]);
                cr.Reading_33__c=Decimal.valueOf(crData[34]);
                cr.Reading_34__c=Decimal.valueOf(crData[35]);
                cr.Reading_35__c=Decimal.valueOf(crData[36]);
                cr.Reading_36__c=Decimal.valueOf(crData[37]);
                cr.Reading_37__c=Decimal.valueOf(crData[38]);
                cr.Reading_38__c=Decimal.valueOf(crData[39]);
                cr.Reading_39__c=Decimal.valueOf(crData[40]);
                cr.Reading_40__c=Decimal.valueOf(crData[41]);
                cr.Reading_41__c=Decimal.valueOf(crData[42]);
                cr.Reading_42__c=Decimal.valueOf(crData[43]);
                cr.Reading_43__c=Decimal.valueOf(crData[44]);
                cr.Reading_44__c=Decimal.valueOf(crData[45]);
                cr.Reading_45__c=Decimal.valueOf(crData[46]);
                cr.Reading_46__c=Decimal.valueOf(crData[47]);
                cr.Reading_47__c=Decimal.valueOf(crData[48]);
                cr.Reading_48__c=Decimal.valueOf(crData[49]);
                readingList.add(cr);
            }
        }     
        System.debug('readingList---->'+readingList);
        System.debug('readingList size---->'+readingList.size());
        return readingList;
    }
    
    public void finish(Database.BatchableContext bc){
        
    }
}