import { Component, OnInit } from '@angular/core';
import { User } from '../app.user';
import { ApiService } from '../api.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-create-user',
  templateUrl: './create-user.component.html',
  styleUrls: ['./create-user.component.css']
})

export class CreateUserComponent implements OnInit {
  public user : User  = new User();
  
  constructor(public apiService: ApiService , public acRoute : ActivatedRoute) { }

  ngOnInit() {

    this.acRoute.params.subscribe((data : any)=>{
      console.log(data.id);
      if(data && data.id){
        this.apiService.get("users/"+data.id).subscribe((data : User)=>{
          this.user = data;
        });
      }
      else
      {
        this.user = new User();
      }
    })
  }

  public onSubmit(){
    console.log("Adding a User: " + this.user);
    this.apiService.postBackend("/users", this.user).subscribe((r)=>{
      console.log(r);
      this.user = new User();
      alert("User added !");
    });
  }
}
