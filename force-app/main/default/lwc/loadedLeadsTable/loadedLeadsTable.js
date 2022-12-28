import { LightningElement, api} from 'lwc';
import saveLeads from '@salesforce/apex/LeadService.saveLeads';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const columns = [
    { label: 'FirstName', fieldName: 'FirstName' },
    { label: 'LastName', fieldName: 'LastName' },
    { label: 'Company', fieldName: 'Company' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Exists', fieldName: 'Duplicate', type: 'boolean'},
];
const testData = [
    {FirstName: 'Kolya', LastName: 'Silivestrov', Company: 'LWC', Email: 'test@dog.com', Phone: '+37529228161'}
];  
export default class LoadedLeadsTable extends LightningElement {
   @api
   leads;
   selectedLeads;
   columns=columns;

   refreshSelectedRows(event){
    this.selectedLeads=event.detail.selectedRows;
    console.log(JSON.stringify(this.selectedLeads));
   }
   handleSave(){
    if(this.selectedLeads){
        saveLeads({leads:this.selectedLeads})
        .then(result => {
           this.dispatchEvent(new ShowToastEvent({
            title: 'Success',
            message: 'Leads were inserted',
            variant: 'success'           
           }))
        })
        .catch(error =>{
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: 'Some error occured during insertion',
                variant: 'error'           
               }))
        });
    }
   }
}