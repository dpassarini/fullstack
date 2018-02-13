import {Component, OnInit, Input, EventEmitter, ViewChild} from '@angular/core';
import {MaterializeAction} from "angular2-materialize";
import { ApiService } from '../api.service';
import { ActivatedRoute } from '@angular/router';
import { User } from '../app.user';
import { environment } from '../../environments/environment';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { UserResponse } from '../app.response.interfaces';
import { DefaultResponse } from '../app.response.interfaces';
import { Router } from '@angular/router';
import { AfterViewInit,ElementRef } from '@angular/core';

@Component({
  selector: 'app-auth-dialog',
  templateUrl: './auth-dialog.component.html',
  styleUrls: ['./auth-dialog.component.css']
})
export class AuthDialogComponent implements OnInit {
  public user : User  = new User();
  private API_URL : string = environment.apiBase;
  

  @Input('auth-mode') authMode: 'login' | 'register' = 'login';
  @Input('error-message') errorMessage;
  modalActions = new EventEmitter<string|MaterializeAction>();

  constructor(
    public apiService: ApiService, 
    public acRoute : ActivatedRoute,
    private http: HttpClient,
    private router: Router
  ) { }
  

  openDialog(mode: 'login' | 'register' = 'login'){
    this.authMode = mode;
    this.modalActions.emit({action:"modal", params:['open']});
  }

  ngOnInit() {
  }

  isLoginMode(){return this.authMode == 'login'}
  isRegisterMode(){return this.authMode == 'register'}

  public onSubmitLogin(){
    var endpoint = this.API_URL + "/oauth/token";
    this.http.post<UserResponse>(endpoint, this.user, {observe: "response"}).subscribe(
      resp => {
        localStorage.setItem("token", resp.body.access_token);
        localStorage.setItem("user_email", this.user.email);
        this.modalActions.emit({action:"modal", params:['close']});        
        window.location.reload();
      },
      (err: HttpErrorResponse) => {
        if (err.error instanceof Error) {
          console.log(err);
        } else {
          this.errorMessage = err.error[0] + " " + err.error[1];
          console.log(err);
        }
      }
    );
  }

  public onSubmitRegister(){
    var endpoint = this.API_URL + "/users";
    this.http.post<DefaultResponse>(endpoint, this.user, {observe: "response"}).subscribe(
      resp => {
        this.router.navigate(['/']);
        this.modalActions.emit({action:"modal", params:['close']});
      },
      (err: HttpErrorResponse) => {
        if (err.error instanceof Error) {
          console.log(err);
        } else {
          this.errorMessage = err.error[0] + " " + err.error[1];
          console.log(err);
        }
      }
    );
  }

}