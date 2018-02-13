import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';


import { AppComponent } from './app.component';
import { ApiService } from './api.service';
import { RouterModule, Routes } from '@angular/router';
import { CreateUserComponent } from './create-user/create-user.component';
import { HttpClientModule, HttpClient } from '@angular/common/http';

import { FormsModule } from '@angular/forms';
import { MaterializeModule } from 'angular2-materialize';
import { HomeComponent } from './home/home.component';
import { ToolbarComponent } from './toolbar/toolbar.component';
import { AuthDialogComponent } from './auth-dialog/auth-dialog.component';
import { CreateAccountComponent } from './create-account/create-account.component';
import { CreateTransferComponent } from './create-transfer/create-transfer.component';
import { CreateChargeComponent } from './create-charge/create-charge.component';
import { CreateCashbackComponent } from './create-cashback/create-cashback.component';
import { AuthenticationComponent } from './authentication/authentication.component';
import { LogoutComponent } from './logout/logout.component';


@NgModule({
  declarations: [
    AppComponent,
    CreateUserComponent,
    HomeComponent,
    ToolbarComponent,
    AuthDialogComponent,
    CreateAccountComponent,
    CreateTransferComponent,
    CreateChargeComponent,
    CreateCashbackComponent,
    AuthenticationComponent,
    LogoutComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    MaterializeModule,
    RouterModule.forRoot([
      {
        path: 'create-cashback',
        component: CreateCashbackComponent
      },
      {
        path: 'logout',
        component: LogoutComponent
      },
      {
        path: 'create-users',
        component: CreateUserComponent
      },
      {
        path: 'create-account',
        component: CreateAccountComponent
      },
      {
        path: 'create-transfer',
        component: CreateTransferComponent
      },
      {
        path: 'create-charge',
        component: CreateChargeComponent
      },
      {
        path: 'home',
        component: HomeComponent
      }
    ])
  ],
  providers: [
    ApiService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
