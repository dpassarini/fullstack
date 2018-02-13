import { Component, OnInit } from '@angular/core';
import { User } from '../app.user';
import { ApiService } from '../api.service';
import { ActivatedRoute } from '@angular/router';
@Component({
  selector: 'app-authentication',
  templateUrl: './authentication.component.html',
  styleUrls: ['./authentication.component.css']
})
export class AuthenticationComponent implements OnInit {

  public user : User  = new User();

  constructor(public apiService: ApiService , public acRoute : ActivatedRoute) { }

  ngOnInit() {
  }

  public onSubmit(){
    console.log("Authenticate user: " + this.user);
    this.apiService.postBackend("/oauth/token", this.user).subscribe((r)=>{
      alert("Charge added !");
    });
  }

}
