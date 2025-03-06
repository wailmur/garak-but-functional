#!/bin/bash

output=$(python -c '
import json
import requests

# Function to log in and get the authentication token
def login_to_website(login_url, username, password):
    login_data = {"username": username, "password": password}
    response = requests.post(login_url, json=login_data)
    if response.status_code == 200:
        try:
            return response.json().get("token")
        except json.JSONDecodeError as e:
            return None
    else:
        raise Exception(f"Login failed with status code {response.status_code}")

# Main function to run the interaction
def main():
    # Replace with your companys login URL, username, and password
    login_url = "[login_url]"
    username = "[your_username]"
    password = "[your_password]"

    # Log in and get the authentication token
    auth_token = login_to_website(login_url, username, password)
    magic=""
    magic+="export REST_API_KEY=\""+str(auth_token)+"\""
    print(magic)
if __name__ == "__main__":
    main()
')

eval "$output"

if [ -n "$REST_API_KEY" ]; then
        echo "REST API Key: $REST_API_KEY"
else
        echo "Error: REST API Key was not set."
fi