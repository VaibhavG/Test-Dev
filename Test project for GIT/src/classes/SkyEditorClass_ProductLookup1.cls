global with sharing class SkyEditorClass_ProductLookup1 extends SkyVisualEditor.SkyEditorPageBaseWithSharing {	
	    	
	    public Product2 record{get;set;}	
	    	
    
	    public dataTableSet1 dataTableSet1 {get; private set;}	
	    	
	    public SkyVisualEditor.RecordTypeSelector recordTypeSelector {get; private set;}	
	    	
	    public SkyVisualEditor__SkyEditorDummy__c searchSelect1{get;set;}	
	    public List<SelectOption> searchSelect1_options {get;set;}	
	    	
	    public SkyVisualEditor__SkyEditorDummy__c searchSelect2{get;set;}	
	    public List<SelectOption> searchSelect2_options {get;set;}	
	    	
	    public SkyVisualEditor__SkyEditorDummy__c inputField1{get;set;}	
	    	
	    public SkyVisualEditor__SkyEditorDummy__c inputField2{get;set;}	
	    	
	    Map<String, String> parameters;	
	    Id opportunityId;	
	    Id pricebook2Id;	
	    public SkyEditorClass_ProductLookup1(ApexPages.StandardController controller) {	
	        super(controller);	

        SObjectField f;

        f = Product2.fields.Name;
        f = Product2.fields.ProductCode;
        f = Product2.fields.Family;
        f = Product2.fields.IsActive;

	            try {	
	                parameters = ApexPages.currentPage().getParameters();	
	                opportunityId = parameters.get('oppId');	
	                if (opportunityId != null) {	
	                    Opportunity opp = [select Pricebook2Id from Opportunity where Id = :opportunityId];	
	                    if (opp.Pricebook2Id != null) {	
	                        pricebook2Id = opp.Pricebook2Id;	
	                    } else {	
	                    throw new SkyVisualEditor.Errors.PricebookNotFoundException(SkyVisualEditor.Messages.PRICEBOOK_NOT_FOUND);	
	                    }	
	                }	
	            	
	            mainRecord = null;	
	            mainSObjectType = Product2.SObjectType;	
	            	
	            	
	            mode = SkyVisualEditor.LayoutMode.TempProductLookup_01; 
	            	
	            searchSelect1 = new SkyVisualEditor__SkyEditorDummy__c();	
	            	
	            searchSelect2 = new SkyVisualEditor__SkyEditorDummy__c();	
	            	
	            inputField1 = new SkyVisualEditor__SkyEditorDummy__c();	
	            	
	            inputField2 = new SkyVisualEditor__SkyEditorDummy__c();	
	            	
	            queryMap.put(	
	                'dataTableSet1',	
	                new SkyVisualEditor.Query('Product2')	
	                    .addFieldAsOutput('Name')	
	                    .addFieldAsOutput('ProductCode')	
	                    .addFieldAsOutput('Family')	
	                    .addFieldAsOutput('IsActive')	
	                    .limitRecords(500)	
	                    .addListener(new SkyVisualEditor.QueryWhereRegister(searchSelect1, 'SkyVisualEditor__Text__c', 'Name', new SkyVisualEditor.TextHolder('eq'), false, true, false))
	                    
	                    .addListener(new SkyVisualEditor.QueryWhereRegister(searchSelect2, 'SkyVisualEditor__Text__c', 'ProductCode', new SkyVisualEditor.TextHolder('eq'), false, true, false))
	                    
	                    .addListener(new SkyVisualEditor.QueryWhereRegister(inputField1, 'SkyVisualEditor__Text__c', 'Name', new SkyVisualEditor.TextHolder('co'), false, true, false))	
	                    
	                    .addListener(new SkyVisualEditor.QueryWhereRegister(inputField2, 'SkyVisualEditor__Text__c', 'ProductCode', new SkyVisualEditor.TextHolder('co'), false, true, false))	
	                    
	            );	
	            	
	            if (pricebook2Id != null) {	
	            queryMap.get('dataTableSet1').addWhere(' Id in (SELECT Product2Id FROM PricebookEntry WHERE IsActive = true AND Pricebook2Id=\'' + pricebook2Id + '\') ');
	            }
	            dataTableSet1 = new dataTableSet1(new List<Product2>(), new List<dataTableSet1Item>(), new List<Product2>(), null);
	            listItemHolders.put('dataTableSet1', dataTableSet1);	
	            	
	            	
	            recordTypeSelector = new SkyVisualEditor.RecordTypeSelector(Product2.SObjectType);	
	            	
	            	
	            update_searchSelect1_options();	
	            update_searchSelect2_options();	
	            doSearch();	
	        } catch (SkyVisualEditor.Errors.SObjectNotFoundException e) {	
	            SkyVisualEditor.Messages.addErrorMessage(e.getMessage());
	        } catch (SkyVisualEditor.Errors.FieldNotFoundException e) {	
	            SkyVisualEditor.Messages.addErrorMessage(e.getMessage());
            } catch (SkyVisualEditor.ExtenderException e) {                 e.setMessagesToPage();

        } catch (SkyVisualEditor.Errors.PricebookNotFoundException e) {
            SkyVisualEditor.Messages.addErrorMessage(e.getMessage());
            hidePageBody = true;
        }
	    }	
	    	
	    public List<SelectOption> getOperatorOptions_Product2_Name() { 
	        return getOperatorOptions('Product2', 'Name');	
	    }	
	    public List<SelectOption> getOperatorOptions_Product2_ProductCode() { 
	        return getOperatorOptions('Product2', 'ProductCode');	
	    }	
	    	

        @isTest(SeeAllData=true)
	    private static void testPageMethods() {
	        try {
                Opportunity[] opps = [SELECT Id FROM Opportunity WHERE Pricebook2Id != null LIMIT 1];
                if (opps.size() > 0) {
                    System.Test.setCurrentPage(new PageReference('/test?oppId=' + opps[0].Id));
                }
	            SkyEditorClass_ProductLookup1 page = new SkyEditorClass_ProductLookup1(new ApexPages.StandardController(new Product2()));
	            page.getOperatorOptions_Product2_Name();	
	            page.getOperatorOptions_Product2_ProductCode();	
	            page.searchSelect1.SkyVisualEditor__Text__c = 'test';
	            page.searchSelect1_ChangeListener();

	            opps = [SELECT Id FROM Opportunity WHERE Pricebook2Id = null LIMIT 1];
	            if (opps.size() > 0) {
	                System.Test.setCurrentPage(new PageReference('/test?oppId=' + opps[0].Id));
	            }
	            page = new SkyEditorClass_ProductLookup1(new ApexPages.StandardController(new Product2()));
	            System.assert(page.hidePageBody);                                        
	            System.assertNotEquals(null, SkyVisualEditor.Messages.getErrorMessages());
	            System.assertNotEquals('', SkyVisualEditor.Messages.getErrorMessages());
	        } catch (Exception e) {
	            System.debug(LoggingLevel.WARN, e);
	        }
	    }	
	    	
	    	
    global class dataTableSet1Item extends SkyVisualEditor.ListItem {
        public Product2 record{get; private set;}
        dataTableSet1Item(dataTableSet1 holder, Product2 record, SkyVisualEditor.RecordTypeSelector recordTypeSelector) {
            super(holder);
            if (record.Id == null ){
                if (recordTypeSelector != null) {
                    recordTypeSelector.applyDefault(record);
                }
                
            }
            this.record = record;
        }
        global override SObject getRecord() {return record;}
    }
    global class dataTableSet1 extends SkyVisualEditor.ListItemHolder {
        public List<dataTableSet1Item> items{get; private set;}
        dataTableSet1(List<SObject> records, List<SkyVisualEditor.ListItem> items, List<SObject> deleteRecords, SkyVisualEditor.RecordTypeSelector recordTypeSelector) {
            super(records, items, deleteRecords, recordTypeSelector);
            this.items = (List<dataTableSet1Item>)items;
        }
        global override SkyVisualEditor.ListItem create(SObject data) {
            return new dataTableSet1Item(this, (Product2)data, recordTypeSelector);
        }
    }
    private static testMethod void testdataTableSet1() {
        dataTableSet1 dataTableSet1 = new dataTableSet1(new List<Product2>(), new List<dataTableSet1Item>(), new List<Product2>(), null);
        dataTableSet1.create(new Product2());
    }
    

	    	
    public void update_searchSelect1_options() {
        searchSelect1_options = new SelectOption[]{ new SelectOption('', label.none) };
        SObject[] results;
        String soql = 'SELECT Name FROM Product2 WHERE Name != null ';
        if (pricebook2Id != null) {
            soql += 'AND Id in (SELECT Product2Id FROM PricebookEntry WHERE IsActive = true AND Pricebook2Id=\'' + pricebook2Id + '\') ';
        }
        soql += 'GROUP BY Name LIMIT 100';
        results = Database.query(soql);
        for (SObject r : results) {
            String value = (String)(r.get('Name'));
            searchSelect1_options.add(new SelectOption(value, value));
        }
    }
	    	
    public void update_searchSelect2_options() {
        searchSelect2_options = new SelectOption[]{ new SelectOption('', label.none) };
      if (searchSelect1.SkyVisualEditor__Text__c != null && searchSelect1.SkyVisualEditor__Text__c != '') {
        SObject[] results;
        String soql = 'SELECT ProductCode FROM Product2 WHERE ProductCode != null ';
        soql += 'AND Name=\'' + searchSelect1.SkyVisualEditor__Text__c + '\' ';
        if (pricebook2Id != null) {
            soql += 'AND Id in (SELECT Product2Id FROM PricebookEntry WHERE IsActive = true AND Pricebook2Id=\'' + pricebook2Id + '\') ';
        }
        soql += 'GROUP BY ProductCode LIMIT 100';
        results = Database.query(soql);
        for (SObject r : results) {
            String value = (String)(r.get('ProductCode'));
            searchSelect2_options.add(new SelectOption(value, value));
        }
      }
    }
	    	
 	public void searchSelect1_ChangeListener() {
	    	searchSelect2.SkyVisualEditor__Text__c = '';
doSearch();
	    	update_searchSelect2_options();
    	}

	    	
	}