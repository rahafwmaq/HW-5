# HW-5


This assignment focuses on building a backend application using Dart. The application provides various endpoints to handle user account management and user profiles.

## Notes: 
* use **Supabase**
* use best practices

## Endpoints

### `/create-account` => POST

Creates a new user account by providing the following information:

- `name`: The name of the user.
- `email`: The email address of the user.
- `password`: The password of the user.

### `/login` => POST

Logs in a user by providing authentication tokens:

- `token`: The authentication token.
- `refresh token`: The refresh token used for renewing authentication.

  
### `/profile` => GET

Retrieves the user profile information:

- `name`: The name of the user.
- `email`: The email address of the user.
- `bio`: The user's biography or description.

### `/edit-profile` => POST

Updates the user profile with new information:

- `name`: The updated name of the user.
- `email`: The updated email address of the user.
- `bio`: The updated biography or description of the user.


### `/delete-account` => DELETE

Delete the user account by his `email`.
