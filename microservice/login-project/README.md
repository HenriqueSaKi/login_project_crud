
## Login Project - API :iphone:

### API resources




### isAvailable
##### Description </br>
Check is the service is available.

##### Response
| Http Status | Message |
|--|--|
| `200` | The service is available! |

### register
##### Description </br>
Register a user into a SQL Server database by first name, last name, e-mail and password.

##### Body
```
{
	"firstName":"Henrique",
	"lastName":"Kisaki" ,
	"email":"example@example.com",
	"password":"password123"
}
```

##### Response 
| Http Status | Message |
|:--:|--|
| `200` |  |
| `400` | Failed request. |
| `409` | Email already registered. |


### login
##### Description </br>
Check user information.

##### Body 
```
{
	"email":"example@example.com",
	"password":"password123"
}
```

##### Response
| Http Status | Message |
|:--:|--|
| `200` | Accepted! |
| `409` | There's no account associated with this email. Try another email address or create a new account. |
| `409` | Invalid Credentials! |


### user
##### Description </br>

Return user data by e-mail and password.

##### Body
```
{
	"email":"example@example.com",
	"password":"password123"
}
```

##### Response
| Http Status | Message |
|:--:|--|
| `200` |  |

#### update
##### Description </br>

Update user data by email.

##### Body
```
{
	"firstName":"Henrique",
	"lastName":"Kisaki" ,
	"email":"example@example.com",
	"password":"password123"
}
```

##### Response
| Http Status | Message |
|:--:|--|
| `200` | Updated successfully! |


#### delete
##### Description </br>

Delete user by e-mail.

##### Body
```
{
	"email":"teste2@teste.com"
}
```

##### Response
| Http Status | Message |
|:--:|--|
| `200` | Account deleted successfully! |
