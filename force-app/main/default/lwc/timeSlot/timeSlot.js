import { LightningElement, wire } from 'lwc';
import allocateTimeslot from '@salesforce/apex/ParkingSpaceController.allocateTimeslot';

export default class TimeSlot extends LightningElement {
    timeslots = [];
    @wire(allocateTimeslot)
    allocateTimeslots({ data, error }) {
        if (data) {
            this.timeslots = data;
        } else if (error) {
            this.error = error;
        }
    }
    // @wire(allocateTimeslot)
    // wiredTimeslots({ data, error }) {
    //     if (data) {
    //         this.timeslots = data;
    //     } else if (error) {
    //         console.error('Error fetching timeslot data', error);
    //     }
    // }
    // handleTimeslotClick(event) {
    //     const timeslotId = event.target.dataset.timeslot;
    //     // Implement logic to handle timeslot click and call appropriate Apex method
    //     // (allocate or deallocate based on the current availability status)
    // }
}