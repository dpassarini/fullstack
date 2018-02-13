export interface UserResponse {
  access_token: string;
}

export interface DefaultResponse {
  error: string;
}

export interface AccountResponse {
  id:number;
  name:string;
  status:string;
  parent_account_id:number;
}
