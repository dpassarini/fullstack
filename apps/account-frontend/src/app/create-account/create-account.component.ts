import { Component, OnInit } from '@angular/core';
import { Account } from '../app.account';
import { ApiService } from '../api.service';
import { ActivatedRoute, Router } from '@angular/router';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { AccountResponse } from '../app.response.interfaces';
import { environment } from '../../environments/environment';


@Component({
  selector: 'app-create-account',
  templateUrl: './create-account.component.html',
  styleUrls: ['./create-account.component.css']
})
export class CreateAccountComponent implements OnInit {
  public account : Account  = new Account();
  private API_URL : string = environment.apiBase;
  private accountList : any;

  constructor(
    public apiService: ApiService , 
    public acRoute : ActivatedRoute,
    private http: HttpClient,
    private router: Router
  ) { }

  ngOnInit() {
    this.userAccounts();
    
    if(localStorage.getItem("token") == null){
      alert("Please, autehticate first");
      return;
    }
    else {
      this.acRoute.params.subscribe((data : any)=>{
        if(data && data.id){
          this.apiService.get("accounts/"+data.id).subscribe((data : Account)=>{
            this.account = data;
          });
        }
        else
        {
          this.account = new Account();
        }
      })
    }
  }

  public userAccounts() {
    var path = this.API_URL + "/accounts";
    if(localStorage.getItem("token") != null){
      path = path + "?access_token=" + localStorage.getItem("token");
    }


    return this.http.get<AccountResponse>(path).subscribe(
      (data) => {
        this.accountList = data;
      }
    )

    
  }

  public onSubmit(){
    var endpoint = this.API_URL + "/accounts";
    if(localStorage.getItem("token") != null){
      this.account.access_token = localStorage.getItem("token");
    }
    this.http.post<AccountResponse>(endpoint, this.account, {observe: "response"}).subscribe(
      resp => {
        alert('account added');
      }
    );
  }
}
