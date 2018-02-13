import { Component } from '@angular/core';
import {Angular2TokenService} from "angular2-token";
import { ApiService } from './api.service';
import {environment} from "../environments/environment";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app';
  constructor(private apiService: ApiService){

  }
  
}
