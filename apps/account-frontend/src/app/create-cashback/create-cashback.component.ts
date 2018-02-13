import { Component, OnInit } from '@angular/core';
import { Transfer } from '../app.transfer';
import { ApiService } from '../api.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-create-cashback',
  templateUrl: './create-cashback.component.html',
  styleUrls: ['./create-cashback.component.css']
})
export class CreateCashbackComponent implements OnInit {

  public transfer : Transfer  = new Transfer();
  
  constructor(public apiService: ApiService , public acRoute : ActivatedRoute) { }

  ngOnInit() {
    this.acRoute.params.subscribe((data : any)=>{
      console.log(data.id);
      if(data && data.id){
        this.apiService.get("cash_back/"+data.id).subscribe((data : Transfer)=>{
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
    console.log("Adding a cash back: " + this.transfer);
    this.apiService.postBackend("/transfers/cash_back", this.transfer).subscribe((r)=>{
      this.transfer = new Transfer();
      alert("Cashback created !");
    });
  }
}
