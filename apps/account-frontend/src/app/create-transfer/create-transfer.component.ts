import { Component, OnInit } from '@angular/core';
import { Transfer } from '../app.transfer';
import { ApiService } from '../api.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-create-transfer',
  templateUrl: './create-transfer.component.html',
  styleUrls: ['./create-transfer.component.css']
})
export class CreateTransferComponent implements OnInit {
  public transfer : Transfer  = new Transfer();
  
  constructor(public apiService: ApiService , public acRoute : ActivatedRoute) { }

  ngOnInit() {

    this.acRoute.params.subscribe((data : any)=>{
      console.log(data.id);
      if(data && data.id){
        this.apiService.get("transfers/"+data.id).subscribe((data : Transfer)=>{
          this.transfer = data;
        });
      }
      else
      {
        this.transfer = new Transfer();
      }
    })
  }

  public onSubmit(){
    console.log("Adding a Transfer: " + this.transfer);
    this.apiService.postBackend("/transfers/transfer", this.transfer).subscribe((r)=>{
      console.log(r);
      this.transfer = new Transfer();
      alert("Transfer added !");
    });
  }

}
