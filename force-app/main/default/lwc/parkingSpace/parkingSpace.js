import { LightningElement,wire } from 'lwc';
import MY_DATA_JSON from '@salesforce/resourceUrl/platformLot';
import getParkingLoaction from '@salesforce/apex/ParkingSpaceController.getParkingLoaction';

export default class ParkingSpace extends LightningElement {
    cities;
    cityOptions;
    place = '';
    placeOptions;
    collectData;
    parkingLocation;
    showPlaceList = false;

    connectedCallback(){
        fetch(MY_DATA_JSON)
        .then(response => response.json())
        .then(data => {
        this.collectData=data;
        console.log('data-------------- ', JSON.stringify(data));
            this.cityOptions = this.mapOptions(data.ConcessionAuthority.authority);
            console.log('Concession Authority Options: ', JSON.stringify(this.concessionAuthorityOptions));
            // Additional options can be added based on your data structure
            console.log('Card Type Options: ', JSON.stringify(this.cardTypeOptions));
        })
        .catch(error => console.error('Error loading static resource:', error));
    }

    
    mapOptions(dataArray) {
        return dataArray.map(item => ({
            label: item.label,
            value: item.value,
        }));
    }

    cityChange(event){
        this.cities = event.target.value;
        console.log('city isd selected'+this.cities);
     if(this.cities === 'Bangalore'){
        console.log('i am in inside if condition');
        this.placeOptions = this.mapOptions(this.collectData.cardType.Bangalore);
        console.log("===="+JSON.stringify(this.placeOptions));
     }
    else if(this.cities ==='Hydrabad')
   {
        console.log('in side Hydrabad');
        this.placeOptions = this.mapOptions(this.collectData.cardType.Hydrabad);
        console.log("-----"+JSON.stringify(this.placeOptions));
   }
    
    }
    placeChange(event){
        this.place = event.target.value;
        console.log('selected place this.place'+this.place);
    } 
    
    
    @wire(getParkingLoaction, { cities : '$cities', places : '$place'})
    setParkingLoaction({ data, error }) {
        if(data){
            let locArray = [];
            console.log('data location ',data);
            data.forEach(element => {
                console.log('--element-> ', JSON.stringify(element));
                let obj = {};
                obj.id = element.Id;
                obj.Name = element.Name;
                obj.Address = element.Address__c;
                locArray.push(obj);
                });
                
                this.parkingLocation = locArray;
            this.showPlaceList =true;
        }
    }
}