import parser from '@salesforce/resourceUrl/papaparse';
import { LightningElement } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getDuplicates from '@salesforce/apex/LeadService.getDuplicates';
export default class CSVtoLeads extends LightningElement {
    leads;
    files;
    file;
    libraryIsLoaded=false;
    //load third-party library "Papa parse" for parsing csv files
    connectedCallback(){
        console.log("Download jquery csv library");
        if(!this.libraryIsLoaded){
            loadScript(this,parser+'/papaparse.js').then(()=>{
                this.libraryIsLoaded=true;
            })
            .catch(error => {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: 'error',
                variant: 'error'
                }));
            })
        }
    }
    //read and parse uploaded .csv file
    processFile(event){
        console.log('Files ' + event.target.files);
        this.files = event.target.files;
        if(this.files.length<1) return;
        var file = event.target.files[0];
        Papa.parse(file, {
            header: 'true',
            complete: (results) => {
                console.log("Rows: ", results.data);
                this.processParsedData(results.data);
            }
        });
    }
    //process raw leads,check and mark duplicates
    processParsedData(data){
        var csvLeads = data.map(item=> {
        return {
                FirstName: item['First Name'],
                LastName: item['Last Name'],
                Company: item['Company'],
                Email: item['Email'],
                Phone: item['Phone'],
                Client_Type__c: 'Customer'
            }
        });
        console.log("Leads: " + JSON.stringify(csvLeads));
        getDuplicates({leads :  csvLeads})
        .then(result=> {
            console.log("Duplicates: " + JSON.stringify(result));
            csvLeads.map(item=>{
                item.Duplicate = result.includes(item.Email)
            });
        })
        .then(()=>{
            this.leads = csvLeads;
            console.log("Proccessed: " + JSON.stringify(this.leads));
        });
    }
}