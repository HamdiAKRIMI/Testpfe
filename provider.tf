
provider "aws" {
   profile    = "default"
   #region     = "us-east-2" # For AWS Regular Account
   region      = "us-east-1" # For AWS Educate Account
   #shared_credentials_file = "/home/hamdi/Documents/My_Project/credentials" #For AWS Regular Account
   shared_credentials_file = "/home/hamdi/pfe-version1.0/credentials_educate" # For AWS Educate Account
 }