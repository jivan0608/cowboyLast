import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCurrencyType from '@salesforce/apex/getCurrencyTypeController.getCurrencyType';
import recordRate from '@salesforce/apex/CurrencyRateRecorderForLWC.recordRate';
import getRate from '@salesforce/apex/CurrencyRateRecorderForLWC.getRate';
const apiKey = 'wdDBDMxafdbuY3y2aiSgpSlyt7rnq8DA';
const endPoint = 'https://api.apilayer.com/exchangerates_data/latest?symbols=GBP,EUR&base=USD';

export default class CurrencyViewer extends LightningElement {
  @wire(getCurrencyType) wiredCyrrencyTypes;
  usdRate;
  gbpRate;
  eurRate;
  error;
    refreshRates() {
        this.error = 'No errors';
        fetch(endPoint, { method: "GET" , headers:{"apikey":apiKey}})
        .then((response) => response.json())
        .then((data) => {
            this.usdRate=1;
            this.eurRate = data.rates.EUR;
            this.gbpRate = data.rates.GBP;
            console.log("🚀 ~ data", data);
            console.log("🚀 ~ EUR", this.eurRate);
            console.log("🚀 ~ GBP", this.gbpRate);
            console.log("🚀 ~ USD", this.usdRate);})
        .then(()=> recordRate({isoCode:"EUR", ConversionRate : this.eurRate}))
        .then(result => {this.checkResult(result);console.log("🚀 ~ EURRECORDRESULT", result)})
        .then(()=>recordRate({isoCode:"USD", ConversionRate : this.usdRate}))
        .then(result => {this.checkResult(result);console.log("🚀 ~ USDRECORDRESULT", result)})
        .then(()=>(recordRate({isoCode:"GBP", ConversionRate : this.gbpRate})))
        .then(result => {this.checkResult(result);console.log("🚀 ~ GBPRECORDRESULT", result)})
        .then(()=>this.showMessage())
        .catch((error) => this.error=error);
    };
    showMessage() {
        if(this.error!="No errors") {
          this.showError();}
        else {
          this.showSucces();}
    }
    checkResult(result){
        if(result!="204") {
          this.error = 'record error';}
    }
    showError() {
        const event = new ShowToastEvent({
              title: 'Error message',
              message: 'Some error has been occured: ' + this.error,
              variant: 'error',
              mode: 'dismissable'
          });
        console.log(event);
        this.dispatchEvent(event);
        }
    showSucces() {
        const event = new ShowToastEvent({
              title: 'Succes message',
              message: 'Succesful',
              variant: 'succes',
              mode: 'dismissable'
          });
        console.log(event);
        this.dispatchEvent(event);
      }
      connectedCallback() {   
        getRate({isoCode:"USD"})
        .then(result=>{ {this.usdRate=result; console.log("🚀 ~ USD", this.usdRate)} });
         getRate({isoCode:"GBP"})
        .then(result=>{ {this.gbpRate=result; console.log("🚀 ~ GBP", this.gbpRate)} })
        getRate({isoCode:"EUR"})
        .then(result=>{ {this.eurRate=result; console.log("🚀 ~ EUR", this.eurRate)} })
      }
}