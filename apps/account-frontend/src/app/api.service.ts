import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable()
export class ApiService {
  API_URL : string = "http://localhost:3000";
  constructor(private http: HttpClient) { }

  public get(path) {
    if(localStorage.getItem("token") != null){
      path = path + "&" + localStorage.getItem("token");
    }
    var endpoint = this.API_URL + path;
    return this.http.get(endpoint);
  }

  public postBackend(path:string,body:any) {
    if(localStorage.getItem("token") != null){
      body.access_token = localStorage.getItem("token");
    }
    var endpoint = this.API_URL + path;
    return this.http.post(endpoint, body, {observe: "response"});
  }
}
