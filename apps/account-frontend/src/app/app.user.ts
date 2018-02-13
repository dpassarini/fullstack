export class User{
  public id:number;
  public name:string;
  public document:string;
  public email:string;
  public password:string;
  public password_confirmation:string;
  public company_name:string;
  public grant_type:string  = "password";
  public access_token:string;
}