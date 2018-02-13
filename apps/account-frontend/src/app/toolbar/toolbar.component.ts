import { Component, OnInit, ViewChild } from '@angular/core';
import {AuthDialogComponent} from "../auth-dialog/auth-dialog.component";

@Component({
  selector: 'app-toolbar',
  templateUrl: './toolbar.component.html',
  styleUrls: ['./toolbar.component.css']
})
export class ToolbarComponent implements OnInit {
  @ViewChild('authDialog') authDialog: AuthDialogComponent;
  public isAuthenticated : boolean;

  constructor() { }

  ngOnInit() {
    this.isAuthenticated = true;
    if(localStorage.getItem("token") == null){
      this.isAuthenticated = false;
    }
  }

  presentAuthDialog(mode?: 'login'| 'register'){
    this.authDialog.openDialog(mode);
  }

  public isAuthenticatewd(){
    if(localStorage.getItem("token") == null){
      return false;
    }
    return true;
  }

}
